import 'package:flutter/foundation.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/change_profile/change_profile_state.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/app/app.dart';

part 'change_profile_provider.g.dart';

@riverpod
class ChangeProfile extends _$ChangeProfile {
  @override
  ChangeProfileState build() {
    Future.microtask(_loadProfile);
    return const ChangeProfileState();
  }

  Future<void> _loadProfile() async {
    state = state.copyWith(status: ChangeProfileStatus.loading);
    try {
      final user = ref.read(authSessionProvider).user;
      if (user != null) {
        final repository = ref.read(profileRepositoryProvider);
        final profile = await repository.getProfile(user.uid);
        if (profile != null) {
          state = state.copyWith(
            status: ChangeProfileStatus.ready,
            profile: profile,
            fullName: profile.fullName,
          );
          _updateFormValidity();
        } else {
          state = state.copyWith(
            status: ChangeProfileStatus.error,
            errorMessage: s.errorGeneric('Profile not found.'),
          );
        }
      } else {
        state = state.copyWith(
          status: ChangeProfileStatus.error,
          errorMessage: s.errorGeneric('Missing authenticated user.'),
        );
      }
    } catch (error, stackTrace) {
      logger.e('Error loading profile.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: ChangeProfileStatus.error,
        errorMessage: s.errorGeneric(error.toString()),
      );
    }
  }

  void updateFullName(String value) {
    ChangeProfileFieldError? error;
    if (value.trim().isEmpty) {
      error = ChangeProfileFieldError.requiredField;
    } else if (value.trim().length < 2) {
      error = ChangeProfileFieldError.fullNameTooShort;
    }
    state = state.copyWith(fullName: value, fullNameError: error);
    _updateFormValidity();
  }

  void _updateFormValidity() {
    final hasRequiredFields = state.fullName.trim().isNotEmpty;
    state = state.copyWith(isFormValid: state.fullNameError == null && hasRequiredFields);
  }

  Future<void> saveProfile() async {
    if (state.profile == null || !state.isFormValid) return;
    state = state.copyWith(status: ChangeProfileStatus.saving, errorMessage: null);
    try {
      final repository = ref.read(profileRepositoryProvider);
      final updatedProfile = state.profile!.copyWith(
        fullName: state.fullName.trim(),
      );
      await repository.updateProfile(updatedProfile);
      state = state.copyWith(
        status: ChangeProfileStatus.success,
        profile: updatedProfile,
      );
      await ref.read(authSessionProvider.notifier).refreshSession();
    } catch (error, stackTrace) {
      logger.e(
        'Error updating profile.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: ChangeProfileStatus.error,
        errorMessage: s.errorGeneric(error.toString()),
      );
    }
  }

  Future<void> uploadAvatar({
    required Uint8List bytes,
    required String mimeType,
  }) async {
    if (state.profile == null) return;
    final userId = state.profile!.id;
    state = state.copyWith(status: ChangeProfileStatus.saving, errorMessage: null);
    try {
      final repository = ref.read(profileRepositoryProvider);
      await repository.uploadAndUpdateAvatar(
        userId: userId,
        bytes: bytes,
        mimeType: mimeType,
      );
      final updated = await repository.getProfile(userId);
      state = state.copyWith(
        status: ChangeProfileStatus.ready,
        profile: updated ?? state.profile,
        fullName: updated?.fullName ?? state.fullName,
      );
      _updateFormValidity();
      ref.invalidate(profileImageProvider(userId));
      await ref.read(authSessionProvider.notifier).refreshSession();
    } catch (error, stackTrace) {
      logger.e('Error uploading avatar.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: ChangeProfileStatus.error,
        errorMessage: s.errorGeneric(error.toString()),
      );
    }
  }
}
