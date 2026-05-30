import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class GemmaSectionCard extends StatelessWidget {
  const GemmaSectionCard({
    super.key,
    required this.gemmaStatus,
    required this.gemmaProgress,
    required this.gemmaError,
    required this.isDark,
    required this.activeAiSource,
    required this.useLocalModel,
    required this.onDownloadConfirmed,
    required this.onCancel,
    required this.onDelete,
    required this.onToggleLocalModel,
  });

  final GemmaDownloadStatus gemmaStatus;
  final double gemmaProgress;
  final String? gemmaError;
  final bool isDark;
  final AiSource activeAiSource;
  final bool useLocalModel;
  final VoidCallback onDownloadConfirmed;
  final VoidCallback onCancel;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleLocalModel;

  Future<void> _handleDownloadTap(BuildContext context) async {
    final s = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.aiModelGemmaName,
        message: s.aiModelGemmaDownloadConfirmMessage,
        confirmLabel: s.aiModelDownload,
        cancelLabel: s.actionCancel,
      ),
    );
    if (confirmed != true || !context.mounted) return;
    onDownloadConfirmed();
  }

  Future<void> _handleDeleteTap(BuildContext context) async {
    final s = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.aiModelGemmaName,
        message: s.aiModelGemmaDeleteConfirmMessage,
        confirmLabel: s.aiModelDeleteModel,
        cancelLabel: s.actionCancel,
      ),
    );
    if (confirmed != true || !context.mounted) return;
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final errorColor = isDark ? AppTheme.redLight : AppTheme.redDark;

    final isDownloaded = gemmaStatus == GemmaDownloadStatus.downloaded;
    final isDownloading = gemmaStatus == GemmaDownloadStatus.downloading;
    final isDeleting = gemmaStatus == GemmaDownloadStatus.deleting;
    final isChecking = gemmaStatus == GemmaDownloadStatus.checkingCache;
    final isError = gemmaStatus == GemmaDownloadStatus.error;
    final isBusy = isDownloading || isDeleting || isChecking;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: Offset(0, 12.h),
                ),
              ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(Icons.phone_android,
                      color: AppTheme.primary, size: 22.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.aiModelGemmaName,
                        style: context.typo.title.small.copyWith(
                          fontWeight: FontWeight.w800,
                          color: textColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        s.aiModelGemmaCardDescription,
                        style: context.typo.body.small.copyWith(
                          color: mutedColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                if (isDeleting || isChecking)
                  SizedBox(
                    width: 22.r,
                    height: 22.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppTheme.primary,
                    ),
                  )
                else if (isDownloaded)
                  _DeletePill(
                    label: s.aiModelDeleteModel,
                    color: errorColor,
                    isBusy: isBusy,
                    onTap: () => _handleDeleteTap(context),
                  )
                else if (activeAiSource == AiSource.local)
                  Icon(Icons.check_circle_rounded,
                      color: AppTheme.primary, size: 20.r)
                else
                  _BadgePill(label: s.aiModelPrivateBadge),
              ],
            ),
            // Use local model toggle (only when downloaded)
            if (isDownloaded) ...[
              SizedBox(height: 14.h),
              Divider(height: 1, thickness: 1, color: borderColor),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.aiModelUseLocalModel,
                        style: context.typo.body.medium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    AppIosSwitch(
                      value: useLocalModel,
                      onChanged: isBusy ? null : onToggleLocalModel,
                      scale: 0.6,
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 14.h),
            Divider(height: 1, thickness: 1, color: borderColor),
            SizedBox(height: 14.h),
            // Description + states
            Text(
              s.aiModelGemmaDescription,
              style: context.typo.caption.big.copyWith(
                height: 1.4,
                color: mutedColor,
              ),
            ),
            if (isError && gemmaError != null) ...[
              SizedBox(height: 8.h),
              Text(
                gemmaError!,
                style: context.typo.caption.big.copyWith(color: errorColor),
              ),
            ],
            if (isDownloading) ...[
              SizedBox(height: 14.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: gemmaProgress,
                  minHeight: 6.h,
                  backgroundColor: borderColor,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${(gemmaProgress * 100).toStringAsFixed(0)}% — ${s.aiModelDownloadingNote}',
                style: context.typo.caption.medium.copyWith(color: mutedColor),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCancel,
                  icon: Icon(Icons.cancel_outlined, size: 18.r),
                  label: Text(
                    s.actionCancel,
                    style: context.typo.body.medium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: errorColor,
                    side: BorderSide(color: errorColor),
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ] else if (!isDownloaded && !isDeleting && !isChecking) ...[
              SizedBox(height: 14.h),
              PrimaryButton(
                title: s.aiModelDownload,
                icon: const Icon(Icons.download_rounded),
                onTap: () => _handleDownloadTap(context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DeletePill extends StatelessWidget {
  const _DeletePill({
    required this.label,
    required this.color,
    required this.isBusy,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isBusy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBusy ? null : onTap,
      child: Container(
        height: 28.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.typo.caption.medium.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppTheme.primaryLight, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: context.typo.caption.medium.copyWith(
          fontWeight: FontWeight.w800,
          color: AppTheme.primary,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
