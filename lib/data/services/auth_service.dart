import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/spotify.dart';
import 'package:testyfy/data/repositories/secure_auth_storage_repository.dart';
import 'package:testyfy/data/repositories/spotify_auth_repository.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/routing/go_router_config.dart';
import 'package:testyfy/routing/go_router_routes.dart';
import 'package:testyfy/utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  final _secureAuthStorage = SecureAuthStorageRepository();
  final _spotifyAuthRepo = SpotifyAuthRepository();

  @override
  Future<BearerToken?> build() async {
    BearerToken? bearerToken = await _secureAuthStorage.getSpotifyBearerToken();
    if (bearerToken != null) {
      final remainingTime = bearerToken.expireDate.difference(DateTime.now().toUtc());
      final timer = Timer(remainingTime, () async {
        await signOff();
      });
      ref.onDispose(timer.cancel);
    }
    return bearerToken;
  }

  Future<void> signOff() async {
    await _secureAuthStorage.invalidateSpotifyBearerToken();
    state = AsyncData(null);
    ref.read(goRouterInstanceProvider).go(GoRouterRoutes.loginScreen.routeName);
  }

  void startAuth() async {
    const clientId = String.fromEnvironment('CLIENT_ID');
    const redirectUri = String.fromEnvironment('REDIRECT_URI');
    if (clientId.isEmpty || redirectUri.isEmpty || (const String.fromEnvironment('CLIENT_SECRET').isEmpty)) {
      ref.showTextSnackBar("ENV VARS ERROR");
      return;
    }
    List<String> scopeRequiredList = [
      'user-read-private',
      'playlist-read-private',
      'playlist-read-collaborative',
      'user-top-read',
      'user-read-recently-played',
      'user-library-read',
    ];
    String scopeRequired = "";
    for (int i = 0; i < scopeRequiredList.length - 1; i++) {
      var element = scopeRequiredList[i];
      scopeRequired = "$scopeRequired$element%20";
    }
    await launchUrl(
      Uri.parse(
        'https://accounts.spotify.com/en/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=$scopeRequired',
      ),
      mode: LaunchMode.inAppBrowserView,
    );
  }

  Future<AuthRequestState> handleAuthResponse(Map<String, String> responseMap) async {
    if (responseMap.isNotEmpty) {
      if (responseMap.containsKey('code')) {
        try {
          final token = await _spotifyAuthRepo.getAccessToken(responseMap['code']!);
          if (token != null) {
            _secureAuthStorage.saveSpotifyBearerToken(token);
            state = AsyncData(token);
            ref.read(goRouterInstanceProvider).pop();
            ref.read(goRouterInstanceProvider).replaceNamed(GoRouterRoutes.recommendationPage.routeName);
            return AuthRequestState.ok;
          }
        } on AuthorizationException catch (_) {
          return AuthRequestState.devModeError;
        }
      } else {
        //user may have deny access or an error occurred
        _secureAuthStorage.invalidateSpotifyBearerToken();
        return AuthRequestState.userDeny;
      }
    }
    ref.read(goRouterInstanceProvider).goNamed(GoRouterRoutes.loginScreen.routeName);
    return AuthRequestState.error;
  }
}

@riverpod
Future<BearerToken> bearerToken(Ref ref) async {
  BearerToken? maybeToken = await ref.watch(authServiceProvider.future);
  if (maybeToken != null) {
    return maybeToken;
  } else {
    await ref.read(authServiceProvider.notifier).signOff();
    throw Exception('Invalid State');
  }
}

enum AuthRequestState { userDeny, devModeError, error, ok }
