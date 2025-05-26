import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/spotify.dart';
import 'package:testyfy/data/services/auth_service.dart';
import 'package:testyfy/domain/models/bearer_token.dart' show BearerToken;

part 'search_viewmodel.g.dart';

@riverpod
class SearchResultViewmodel extends _$SearchResultViewmodel {
  @override
  Future<List<Page>> build(String search, List<SearchType> searchTypes) async {
    final BearerToken bearerToken = await ref.watch(bearerTokenProvider.future);
    var spotify = SpotifyApi(
      SpotifyApiCredentials(
        const String.fromEnvironment('CLIENT_ID'),
        const String.fromEnvironment('CLIENT_SECRET'),
        accessToken: bearerToken.token,
        refreshToken: bearerToken.refreshToken,
        expiration: bearerToken.expireDate,
        scopes: [
          'user-read-private',
          'playlist-read-private',
          'playlist-read-collaborative',
          'user-top-read',
          'user-read-recently-played',
          'user-library-read',
        ],
      ),
    );
    return await spotify.search.get(search, types: searchTypes).getPage(35);
  }
}
