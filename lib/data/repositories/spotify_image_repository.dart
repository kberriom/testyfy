import 'dart:convert';

import 'package:http/http.dart';
import 'package:testyfy/data/repositories/spotify_image_repository_interface.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/domain/models/spotify_user_images.dart';

class SpotifyImageRepository implements SpotifyImageRepositoryInterface {
  SpotifyImageRepository();

  @override
  Future<SpotifyUserImages> getUserProfileImages(BearerToken token) async {
    final response = await get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {'Authorization': "Bearer ${token.token}"},
    );
    return SpotifyUserImages.fromJson(utf8.decode(response.bodyBytes));
  }
}
