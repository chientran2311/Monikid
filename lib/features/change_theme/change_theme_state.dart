import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_theme_state.freezed.dart';

@freezed
abstract class ChangeThemeState with _$ChangeThemeState {
  const factory ChangeThemeState({
    @Default(ThemeMode.light) ThemeMode themeMode,
  }) = _ChangeThemeState;

  const ChangeThemeState._();

  bool get isDark => themeMode == ThemeMode.dark;
}
