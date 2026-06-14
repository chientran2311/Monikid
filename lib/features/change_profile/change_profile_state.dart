import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/profile/profile_model.dart';

part 'change_profile_state.freezed.dart';

enum ChangeProfileStatus {
  initial,
  loading,
  ready,
  saving,
  success,
  error,
}

enum ChangeProfileFieldError {
  requiredField,
  fullNameTooShort,
}

@freezed
abstract class ChangeProfileState with _$ChangeProfileState {
  const factory ChangeProfileState({
    ProfileModel? profile,
    @Default(ChangeProfileStatus.initial) ChangeProfileStatus status,
    @Default('') String fullName,
    ChangeProfileFieldError? fullNameError,
    @Default(false) bool isFormValid,
    @Default(false) bool isSaving,
    String? errorMessage,
    @Default(false) bool saveSuccess,
  }) = _ChangeProfileState;

  const ChangeProfileState._();

  bool get isLoading => status == ChangeProfileStatus.loading;
  bool get isSavingProfile => status == ChangeProfileStatus.saving;
}