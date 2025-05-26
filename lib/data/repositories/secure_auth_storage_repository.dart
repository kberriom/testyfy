import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/data/repositories/auth_repository_storage_interface.dart';

class SecureAuthStorageRepository implements AuthRepositoryStorageInterface {
  final FlutterSecureStorage _storage;

  SecureAuthStorageRepository({
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  }) : _storage = storage;

  @override
  Future<BearerToken?> getSpotifyBearerToken() async {
    try {
      final String? storedToken = await _storage.read(key: StorageItemType.spotifyAccessToken.name);
      final String? storedRefreshToken = await _storage.read(key: StorageItemType.spotifyRefreshToken.name);
      final String? storedExpDate = await _storage.read(key: StorageItemType.spotifyAccessTokenExpDate.name);

      if (storedToken != null &&
          storedToken.isNotEmpty &&
          storedRefreshToken != null &&
          storedRefreshToken.isNotEmpty &&
          storedExpDate != null &&
          storedRefreshToken.isNotEmpty) {
        return BearerToken(
          token: storedToken,
          refreshToken: storedRefreshToken,
          expireDate: DateTime.parse(storedExpDate),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveSpotifyBearerToken(BearerToken token) async {
    await _storage.write(
      key: StorageItemType.spotifyAccessTokenExpDate.name,
      value: token.expireDate.toIso8601String(),
    );
    await _storage.write(key: StorageItemType.spotifyAccessToken.name, value: token.token);
    return await _storage.write(key: StorageItemType.spotifyRefreshToken.name, value: token.refreshToken);
  }

  @override
  Future<void> invalidateSpotifyBearerToken() async {
    await _storage.delete(key: StorageItemType.spotifyAccessTokenExpDate.name);
    await _storage.delete(key: StorageItemType.spotifyRefreshToken.name);
    return await _storage.delete(key: StorageItemType.spotifyAccessToken.name);
  }
}
