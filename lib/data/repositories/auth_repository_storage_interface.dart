import 'package:testyfy/domain/models/bearer_token.dart';

abstract interface class AuthRepositoryStorageInterface {
  Future<BearerToken?> getSpotifyBearerToken();
  Future<void> saveSpotifyBearerToken(BearerToken token);
  Future<void> invalidateSpotifyBearerToken();
}