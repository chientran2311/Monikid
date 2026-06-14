import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/change_profile/change_profile_provider.dart';
import 'package:monikid/features/change_profile/change_profile_state.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_avatar_section.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_form_card.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_form_row.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_text_field.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';
import 'package:monikid/shared/widgets/loading_screen.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changeProfileProvider);
    final notifier = ref.read(changeProfileProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fullNameController = useTextEditingController(text: state.fullName);

    useEffect(() {
      if (state.status == ChangeProfileStatus.ready) {
        if (fullNameController.text != state.fullName) {
          fullNameController.text = state.fullName;
        }
      }
      return null;
    }, [state.status]);

    ref.listen(changeProfileProvider, (previous, next) {
      if (next.status == ChangeProfileStatus.success &&
          previous?.status != ChangeProfileStatus.success) {
        context.showSuccessSnackBar(s.profileEditSaveSuccess);
        context.pop();
      }
      if (next.status == ChangeProfileStatus.error &&
          next.errorMessage != null &&
          previous?.status != ChangeProfileStatus.error) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1;

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: s.profileEditTitle),
      body: AppBackground(
        child: state.status == ChangeProfileStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + 24.h,
                    bottom: 100.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileEditAvatarSection(
                        avatarUrl: state.profile?.avatarUrl,
                        fullName: state.fullName,
                        onTap: () => _showAvatarPicker(context, ref),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        s.profileEditAvatarLabel,
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ProfileEditFormCard(
                          isDark: isDark,
                          children: [
                            ProfileEditFormRow(
                              icon: Icons.person_outline_rounded,
                              label: s.profileEditFullName.toUpperCase(),
                              isDark: isDark,
                              child: ProfileEditTextField(
                                controller: fullNameController,
                                hint: s.profileEditFullNameHint,
                                errorText: _fieldErrorText(context, state.fullNameError),
                                onChanged: notifier.updateFullName,
                                isDark: isDark,
                              ),
                            ),
                            ProfileEditFormRow(
                              icon: Icons.email_outlined,
                              label: s.profileEditEmail.toUpperCase(),
                              isDark: isDark,
                              showDivider: false,
                              trailingWidget: Icon(
                                Icons.lock_outline,
                                size: 16.r,
                                color: AppTheme.textMuted,
                              ),
                              child: Text(
                                state.profile?.email ?? '',
                                style: TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      20.w,
                      12.h,
                      20.w,
                      MediaQuery.of(context).padding.bottom + 12.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          bgColor.withValues(alpha: 0),
                          bgColor,
                        ],
                        stops: const [0.0, 0.35],
                      ),
                    ),
                    child: PrimaryButton(
                      title: s.actionSaveChanges,
                      onTap: state.isFormValid && !state.isSavingProfile
                          ? notifier.saveProfile
                          : null,
                      isLoading: state.isSavingProfile,
                    ),
                  ),
                ),
                if (state.isSavingProfile) const LoadingScreen(),
              ],
            ),
        ),
    );
  }

  String? _fieldErrorText(BuildContext context, ChangeProfileFieldError? error) {
    if (error == null) return null;
    switch (error) {
      case ChangeProfileFieldError.requiredField:
        return context.l10n.profileEditErrorNameRequired;
      case ChangeProfileFieldError.fullNameTooShort:
        return context.l10n.profileEditErrorNameTooShort;
    }
  }

  void _showAvatarPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UploadPicDialog(
        imageIntake: ref.read(transactionImageIntakeProvider),
        title: context.l10n.profileEditAvatarLabel,
        description: context.l10n.profileEditAvatarDesc,
        onImagePicked: (selection) async {
          unawaited(
            ref.read(changeProfileProvider.notifier).uploadAvatar(
              bytes: selection.bytes,
              mimeType: selection.mimeType,
            ),
          );
        },
      ),
    );
  }
}
