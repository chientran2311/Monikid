import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class UploadPicDialog extends HookConsumerWidget {
  const UploadPicDialog({
    super.key,
    required this.imageIntake,
    this.title,
    this.description,
    this.onImagePicked,
  });

  final TransactionImageIntake imageIntake;
  final String? title;
  final String? description;
  final Future<void> Function(TransactionImageSelection)? onImagePicked;

  Future<void> _pickImage(
    BuildContext context,
    ValueNotifier<bool> isPicking,
    String unsupportedFormatMessage,
    String loadErrorMessage,
    Future<TransactionImageSelection?> Function() pickImage,
  ) async {
    if (isPicking.value) return;
    isPicking.value = true;
    try {
      final selection = await pickImage();
      if (selection == null) return;

      if (onImagePicked != null) {
        await onImagePicked!(selection);
        if (context.mounted) context.pop();
      } else {
        if (context.mounted) context.pop(selection);
      }
    } on TransactionImageIntakeException catch (error) {
      if (!context.mounted) return;
      final message = switch (error.error) {
        TransactionImageIntakeError.unsupportedFormat => unsupportedFormatMessage,
        TransactionImageIntakeError.readFailed => loadErrorMessage,
      };
      AppSnackBar.error(context, message);
    } catch (error, _) {
      if (!context.mounted) return;
      AppSnackBar.error(context, error.toString());
    } finally {
      if (context.mounted) {
        isPicking.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPicking = useState(false);
    final s = context.l10n;

    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 40.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 24.h),
                decoration: BoxDecoration(
                  color: AppTheme.iconLight.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
              
              // Title
              Text(
                title ?? s.scanReceiptTitle,
                style: context.typo.headline.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  letterSpacing: -0.03,
                ),
              ),
              SizedBox(height: 28.h),
              
              // Action Group
              Column(
                children: [
                  // Camera Action
                  _ActionRow(
                    icon: Icons.photo_camera_outlined,
                    label: s.takePicture,
                    subtitle: s.scanReceiptCameraSubtitle,
                    enabled: !isPicking.value,
                    isDark: isDark,
                    onTap: () => _pickImage(
                      context,
                      isPicking,
                      s.transactionEvidenceUnsupportedFormat,
                      s.transactionEvidenceLoadError,
                      imageIntake.pickFromCamera,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  
                  // Gallery Action
                  _ActionRow(
                    icon: Icons.photo_library_outlined,
                    label: s.chooseFromGallery,
                    subtitle: s.scanReceiptGallerySubtitle,
                    enabled: !isPicking.value,
                    isDark: isDark,
                    onTap: () => _pickImage(
                      context,
                      isPicking,
                      s.transactionEvidenceUnsupportedFormat,
                      s.transactionEvidenceLoadError,
                      imageIntake.pickFromGallery,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 24.h),
              
              // Cancel Button
              PrimaryButton.secondary(
                title: s.actionCancel,
                onTap: isPicking.value ? null : context.pop,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.enabled,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool enabled;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          border: Border.all(
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 22.sp,
                color: AppTheme.primary,
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.typo.button.medium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: context.typo.caption.small.copyWith(
                      color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow
            Icon(
              Icons.chevron_right,
              size: 22.sp,
              color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
