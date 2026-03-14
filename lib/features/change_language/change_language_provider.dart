import 'package:monikid/features/change_language/change_language_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_language_provider.g.dart';

@riverpod
class ChangeLanguage extends _$ChangeLanguage {
  @override
  ChangeLanguageState build() {
    _loadSavedLocale();
    return const ChangeLanguageState();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString('language_code') ?? 'vi';
    if (state.localeCode != savedLocale) {
      state = state.copyWith(localeCode: savedLocale);
    }
  }

  Future<void> setLanguage(String newCode) async {
    if (state.localeCode == newCode) return;
    
    state = state.copyWith(localeCode: newCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newCode);
  }
}
