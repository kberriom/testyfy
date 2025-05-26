import 'package:dart_mappable/dart_mappable.dart';

part 'spotify_user_images.mapper.dart';

@MappableClass()
class SpotifyUserImages with SpotifyUserImagesMappable {
  final List<SpotifyUserImage> images;

  SpotifyUserImages({required this.images});

  static final fromMap = SpotifyUserImagesMapper.fromMap;
  static final fromJson = SpotifyUserImagesMapper.fromJson;
}

@MappableClass()
class SpotifyUserImage with SpotifyUserImageMappable {
  final String url;
  final int? height;
  final int? width;

  SpotifyUserImage({required this.url, this.height, this.width});

  static final fromMap = SpotifyUserImageMapper.fromMap;
  static final fromJson = SpotifyUserImageMapper.fromJson;
}
