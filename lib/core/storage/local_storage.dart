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

  // Save first 10 posts to local storage
  Future<void> savePosts(List<PostResponseItem> posts) async {
    final postsToSave = posts.take(10).toList();
    final jsonList = postsToSave.map((post) => post.toJson()).toList();
    await _prefs.setString(_cachedPostsKey, jsonEncode(jsonList));
  }

  // Load posts from local storage
  Future<List<PostResponseItem>> loadPosts() async {
    final jsonString = _prefs.getString(_cachedPostsKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => PostResponseItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Check if we have cached posts
  bool hasCachedPosts() {
    return _prefs.containsKey(_cachedPostsKey);
  }

  // Toggle local mode
  Future<void> setLocalMode(bool isLocal) async {
    await _prefs.setBool(_localModeKey, isLocal);
  }

  // Get local mode state
  bool getLocalMode() {
    return _prefs.getBool(_localModeKey) ?? false;
  }
}
