import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testyfy/data/services/auth_service.dart';
import 'package:testyfy/routing/go_router_routes.dart';
import 'package:testyfy/utils/localization_utils.dart';
import 'package:testyfy/utils/snackbar_utils.dart';

class SpotifyAuthDeeplinkReceiver extends ConsumerStatefulWidget {
  const SpotifyAuthDeeplinkReceiver({super.key});

  @override
  ConsumerState<SpotifyAuthDeeplinkReceiver> createState() => _SpotifyAuthDeeplinkReceiverState();
}

class _SpotifyAuthDeeplinkReceiverState extends ConsumerState<SpotifyAuthDeeplinkReceiver> {
  late Map<String, String> responseMap;
  bool canPop = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authStartResult = await ref.read(authServiceProvider.notifier).handleAuthResponse(responseMap);
      if (mounted) {
        if (authStartResult != AuthRequestState.ok) {
          String error = switch (authStartResult) {
            AuthRequestState.userDeny => context.localizations.authDeny,
            AuthRequestState.devModeError => context.localizations.spotifyDevelopmentMode,
            _ => context.localizations.authFail,
          };
          ref.showTextSnackBar(error);
        }
        //If auth Ok auth service will redirect
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    responseMap = GoRouterState.of(context).uri.queryParameters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Center(child: SizedBox.square(dimension: 60, child: CircularProgressIndicator())),
      ),
    );
  }
}
