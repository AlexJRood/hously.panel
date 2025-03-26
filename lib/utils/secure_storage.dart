import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> removeToken() async {
    await _storage.delete(key: 'token');
  }

  Future<void> clearStorage() async {
    await _storage.deleteAll();
  }

  Future<void> saveProfilePicture(String url) async {
    await _storage.write(key: 'profile_picture', value: url);
  }

  Future<String?> getProfilePicture() async {
    return await _storage.read(key: 'profile_picture');
  }
}
