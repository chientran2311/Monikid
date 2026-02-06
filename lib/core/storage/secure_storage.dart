import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  AppSecureStorage() : _storage = _createSecureStorage();
  final FlutterSecureStorage _storage;
  static FlutterSecureStorage _createSecureStorage() {
    return const FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.unlocked_this_device,
      ),
    );
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      await delete(key: key);
    } else {
      await _storage.write(key: key, value: value);
    }
  }

  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
