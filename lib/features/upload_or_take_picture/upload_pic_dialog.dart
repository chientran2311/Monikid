import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';

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
      isPicking.value = false;
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
          color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.borderDark
                      : AppTheme.borderLight,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title ?? s.scanReceiptTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description ?? s.scanReceiptDesc,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppTheme.textMuted
                      : AppTheme.textGrey,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: Text(s.takePicture),
                enabled: !isPicking.value,
                onTap: () => _pickImage(
                  context,
                  isPicking,
                  s.transactionEvidenceUnsupportedFormat,
                  s.transactionEvidenceLoadError,
                  imageIntake.pickFromCamera,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(s.chooseFromGallery),
                enabled: !isPicking.value,
                onTap: () => _pickImage(
                  context,
                  isPicking,
                  s.transactionEvidenceUnsupportedFormat,
                  s.transactionEvidenceLoadError,
                  imageIntake.pickFromGallery,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isPicking.value
                      ? null
                      : () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? AppTheme.backgroundDark.withValues(alpha: 0.5)
                        : AppTheme.backgroundLight.withValues(alpha: 0.5),
                    foregroundColor: isDark
                        ? Colors.white
                        : AppTheme.surfaceVeryDark,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(s.actionCancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
