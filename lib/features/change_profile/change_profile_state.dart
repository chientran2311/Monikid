import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/profile/profile_model.dart';

part 'change_profile_state.freezed.dart';

@freezed
abstract class ChangeProfileState with _$ChangeProfileState {
  const factory ChangeProfileState({
    ProfileModel? profile,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
    @Default(false) bool saveSuccess,
  }) = _ChangeProfileState;

  const ChangeProfileState._();
}
