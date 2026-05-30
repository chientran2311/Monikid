import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/change_profile/change_profile_provider.dart';
import 'package:monikid/features/change_profile/change_profile_state.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_avatar_section.dart';
import 'package:monikid/features/change_profile/widgets/profile_edit_text_field.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/shared/widgets/loading_screen.dart';

class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changeProfileProvider);
    final notifier = ref.read(changeProfileProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight;
    final surfaceColor = isDark ? AppTheme.surfaceVariant : AppTheme.backgroundLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final subTextColor = AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

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

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor, size: 20.r),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.profileEditTitle,
          style: context.typo.subtitle.medium.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: state.status == ChangeProfileStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 24.h),
                          ProfileEditAvatarSection(
                            avatarUrl: state.profile?.avatarUrl,
                            bgColor: bgColor,
                            surfaceColor: surfaceColor,
                            subTextColor: subTextColor,
                            onTap: () => _showAvatarPicker(context, ref),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            s.profileEditAvatarLabel,
                            style: context.typo.body.medium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileEditTextField(
                                  label: s.profileEditFullName,
                                  hint: s.profileEditFullNameHint,
                                  initialValue: state.fullName,
                                  errorText: _fieldErrorText(context, state.fullNameError),
                                  onChanged: notifier.updateFullName,
                                  isDark: isDark,
                                ),
                                SizedBox(height: 20.h),
                                ProfileEditTextField(
                                  label: s.profileEditPhone,
                                  hint: s.profileEditPhoneHint,
                                  initialValue: state.phone,
                                  errorText: _fieldErrorText(context, state.phoneError),
                                  onChanged: notifier.updatePhone,
                                  icon: Icons.call,
                                  keyboardType: TextInputType.phone,
                                  isDark: isDark,
                                ),
                                SizedBox(height: 20.h),
                                ProfileEditTextField(
                                  label: s.profileEditEmail,
                                  initialValue: state.profile?.email ?? '',
                                  icon: Icons.mail,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: false,
                                  isDark: isDark,
                                  onChanged: (_) {},
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.h, left: 4.w),
                                  child: Text(
                                    s.profileEditEmailWarning,
                                    style: context.typo.caption.medium.copyWith(
                                      color: subTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                ProfileEditTextField(
                                  label: s.profileEditDob,
                                  hint: s.profileEditDobHint,
                                  initialValue: state.dob,
                                  onChanged: notifier.updateDob,
                                  icon: Icons.calendar_today,
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 48.h),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border(top: BorderSide(color: borderColor)),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isFormValid && !state.isSavingProfile
                            ? () => notifier.saveProfile()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          disabledBackgroundColor:
                              AppTheme.primary.withValues(alpha: 0.3),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 4,
                          shadowColor: AppTheme.primary.withValues(alpha: 0.4),
                        ),
                        child: state.isSavingProfile
                            ? SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.r,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppTheme.textWhite,
                                  ),
                                ),
                              )
                            : Text(
                                s.actionSaveChanges,
                                style: context.typo.subtitle.small,
                              ),
                      ),
                    ),
                  ),
                ],
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
      case ChangeProfileFieldError.invalidPhoneFormat:
        return context.l10n.profileEditErrorInvalidPhone;
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
