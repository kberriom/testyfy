import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/domain/models/spotify_user_images.dart';

abstract interface class SpotifyImageRepositoryInterface {
  Future<SpotifyUserImages> getUserProfileImages(BearerToken token);
}