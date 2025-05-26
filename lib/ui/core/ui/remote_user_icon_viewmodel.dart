import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testyfy/data/repositories/spotify_image_repository.dart';
import 'package:testyfy/data/services/auth_service.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/domain/models/spotify_user_images.dart';

part 'remote_user_icon_viewmodel.g.dart';

@riverpod
class RemoteUserIconViewmodel extends _$RemoteUserIconViewmodel {
  SpotifyImageRepository imageRepository = GetIt.instance.registerSingletonIfAbsent(
    () => SpotifyImageRepository(),
    instanceName: 'imageRepository',
  );

  @override
  Future<String?> build() async {
    final BearerToken bearerToken = await ref.watch(bearerTokenProvider.future);
    SpotifyUserImages imagesResult = await imageRepository.getUserProfileImages(bearerToken);
    return imagesResult.images.firstWhere((image) => image.height == 64, orElse: () => imagesResult.images.first).url;
  }
}
