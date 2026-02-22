import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monikid/models/response/post_response.dart';

class AppLocalStorage {
  AppLocalStorage(this._prefs);
  final SharedPreferences _prefs;

  static const String _cachedPostsKey = 'cached_posts';
  static const String _localModeKey = 'local_mode';

  static Future<AppLocalStorage> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppLocalStorage(prefs);
  }

  Future<String?> read(String key) async {
    return _prefs.getString(key);
  }

  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      await delete(key: key);
    } else {
      await _prefs.setString(key, value);
    }
  }

  Future<void> delete({required String key}) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
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
