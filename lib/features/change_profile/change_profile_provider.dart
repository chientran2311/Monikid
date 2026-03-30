import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/change_profile/change_profile_state.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/App/app.dart';

part 'change_profile_provider.g.dart';

@riverpod
class ChangeProfile extends _$ChangeProfile {
  @override
  ChangeProfileState build() {
    _loadProfile();
    return const ChangeProfileState();
  }

  Future<void> _loadProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionProvider).user;
      if (user != null) {
        final repository = ref.read(profileRepositoryProvider);
        final profile = await repository.getProfile(user.uid);
        state = state.copyWith(profile: profile, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, errorMessage: 'User not logged in');
      }
    } catch (e) {
      logger.e('Error loading Profile: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: s.errorGeneric(e.toString()),
      );
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? phone,
    String? dob,
    String? gender,
    String? avatarUrl,
  }) async {
    if (state.profile == null) return;
    state = state.copyWith(isSaving: true, errorMessage: null, saveSuccess: false);
    try {
      final updatedProfile = state.profile!.copyWith(
        fullName: fullName ?? state.profile!.fullName,
        phone: phone ?? state.profile!.phone,
        dob: dob ?? state.profile!.dob,
        gender: gender ?? state.profile!.gender,
        avatarUrl: avatarUrl ?? state.profile!.avatarUrl,
      );
      
      final repository = ref.read(profileRepositoryProvider);
      await repository.updateProfile(updatedProfile);
      
      state = state.copyWith(
        profile: updatedProfile,
        isSaving: false,
        saveSuccess: true,
      );
    } catch (e) {
      logger.e('Error updating Profile: $e');
      state = state.copyWith(
        isSaving: false,
        errorMessage: s.errorGeneric(e.toString()),
      );
    }
  }
}
