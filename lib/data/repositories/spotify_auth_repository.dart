import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify/spotify.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/data/repositories/spotify_auth_interface.dart';


class SpotifyAuthRepository implements SpotifyAuthInterface {
  late final http.Client _httpClient;
  late final JsonDecoder _jsonDecoder;

  SpotifyAuthRepository({http.Client? httpClient, JsonDecoder jsonDecoder = const JsonDecoder()}) {
    if (httpClient != null) {
      _httpClient = httpClient;
    } else {
      _httpClient = http.Client();
    }
    _jsonDecoder = jsonDecoder;
  }

  @override
  Future<BearerToken?> getAccessToken(String authorizationCode) async {
    final String body =
        'grant_type=authorization_code&code=$authorizationCode&redirect_uri=${const String.fromEnvironment('REDIRECT_URI')}';

    const clientSecret = String.fromEnvironment('CLIENT_SECRET');
    const clientId = String.fromEnvironment('CLIENT_ID');

    String base64auth = Base64Encoder.urlSafe().convert(utf8.encode('$clientId:$clientSecret'));

    Map<String, String> headers = {
      'Authorization': 'Basic $base64auth',
      'content-type': 'application/x-www-form-urlencoded',
    };

    final uri = Uri.https('accounts.spotify.com', '/api/token');

    http.Response response = await _httpClient
        .post(uri, body: body, headers: headers)
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 403) {
      //Special case - User is not added to spotify 'development mode' API whitelist
      throw AuthorizationException("403", "User is not added to spotify 'development mode' API allow list", uri);
    }

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonResponse = _jsonDecoder.convert(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return BearerToken(
        token: jsonResponse['access_token'],
        refreshToken: jsonResponse['refresh_token'],
        expireDate: DateTime.now().toUtc().add(Duration(minutes: 45)),
      );
    }
    return null;
  }
}
