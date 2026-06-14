import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/change_theme/change_theme_state.dart';

part 'change_theme_provider.g.dart';

@riverpod
class ChangeTheme extends _$ChangeTheme {
  late final AppLocalStorage _storage;
  late final Logger _logger;

  @override
  ChangeThemeState build() {
    _storage = getIt<AppLocalStorage>();
    _logger = getIt<Logger>();
    // Synchronous read — value available since setupLocator() runs before runApp.
    final saved = _storage.readSync(StorageKeys.themeModeKey);
    final mode = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    return ChangeThemeState(themeMode: mode);
  }

  /// Toggle between light and dark, persisting the choice.
  Future<void> setDark(bool isDark) async {
    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    if (state.themeMode == mode) return;
    state = state.copyWith(themeMode: mode);
    try {
      await _storage.write(
        key: StorageKeys.themeModeKey,
        value: isDark ? 'dark' : 'light',
      );
      _logger.i('ChangeTheme.setDark: persisted. isDark=$isDark');
    } catch (error, stackTrace) {
      _logger.e('ChangeTheme.setDark failed to persist. isDark=$isDark',
          error: error, stackTrace: stackTrace);
    }
  }
}
