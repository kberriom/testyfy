import 'package:testyfy/domain/models/bearer_token.dart';

abstract interface class SpotifyAuthInterface {
  Future<BearerToken?> getAccessToken(String authorizationCode);
}
