import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  AppLocalStorage(this._prefs);
  final SharedPreferences _prefs;

  static Future<AppLocalStorage> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppLocalStorage(prefs);
  }

  Future<String?> read(String key) async {
    return _prefs.getString(key);
  }

  String? readSync(String key) {
    return _prefs.getString(key);
  }

  Future<bool?> readBool(String key) async {
    return _prefs.getBool(key);
  }

  bool? readBoolSync(String key) {
    return _prefs.getBool(key);
  }

  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      await delete(key: key);
    } else {
      await _prefs.setString(key, value);
    }
  }

  Future<void> writeBool({required String key, required bool value}) async {
    await _prefs.setBool(key, value);
  }

  Future<void> delete({required String key}) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
