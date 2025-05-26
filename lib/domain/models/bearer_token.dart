import 'package:freezed_annotation/freezed_annotation.dart';

part 'bearer_token.freezed.dart';
part 'bearer_token.g.dart';

@freezed
abstract class BearerToken with _$BearerToken {
  const factory BearerToken({required String token, required String refreshToken, required DateTime expireDate}) = _BearerToken;

  factory BearerToken.fromJson(Map<String, dynamic> json) => _$BearerTokenFromJson(json);
}

enum StorageItemType {
  spotifyAccessTokenExpDate,
  spotifyAccessToken,
  spotifyRefreshToken;
}