import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_language_state.freezed.dart';

@freezed
abstract class ChangeLanguageState with _$ChangeLanguageState {
  const factory ChangeLanguageState({
    @Default('vi') String localeCode,
  }) = _ChangeLanguageState;

  const ChangeLanguageState._();
}
