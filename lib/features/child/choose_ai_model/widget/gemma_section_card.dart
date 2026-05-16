import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';

class GemmaSectionCard extends StatelessWidget {
  const GemmaSectionCard({
    super.key,
    required this.gemmaStatus,
    required this.gemmaProgress,
    required this.gemmaError,
    required this.isDark,
    required this.onDownloadConfirmed,
    required this.onCancel,
    required this.onDelete,
  });

  final GemmaDownloadStatus gemmaStatus;
  final double gemmaProgress;
  final String? gemmaError;
  final bool isDark;
  final VoidCallback onDownloadConfirmed;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

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

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final errorColor = isDark ? const Color(0xFFFCA5A5) : const Color(0xFFDC2626);

    final isDownloaded = gemmaStatus == GemmaDownloadStatus.downloaded;
    final isDownloading = gemmaStatus == GemmaDownloadStatus.downloading;
    final isDeleting = gemmaStatus == GemmaDownloadStatus.deleting;
    final isChecking = gemmaStatus == GemmaDownloadStatus.checkingCache;
    final isError = gemmaStatus == GemmaDownloadStatus.error;
    final isBusy = isDownloading || isDeleting || isChecking;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Row(
            children: [
              Text(
                s.aiModelLocalSectionTitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: mutedColor,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(99.r),
                ),
                child: Text(
                  s.aiModelBetaLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 0.5),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.aiModelGemmaName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                    if (isDeleting || isChecking)
                      SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppTheme.primary,
                        ),
                      )
                    else
                      AppIosSwitch(
                        value: isDownloaded,
                        onChanged: isBusy
                            ? null
                            : (v) =>
                                v ? _handleDownloadTap(context) : onDelete(),
                      ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 0.5, color: borderColor),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.aiModelGemmaDescription,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1.4,
                        color: mutedColor,
                      ),
                    ),
                    if (isError && gemmaError != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        gemmaError!,
                        style: TextStyle(fontSize: 12.sp, color: errorColor),
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
                        style: TextStyle(fontSize: 11.sp, color: mutedColor),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: onCancel,
                          icon: Icon(Icons.cancel_outlined, size: 18.r),
                          label: Text(
                            s.actionCancel,
                            style: TextStyle(
                              fontSize: 14.sp,
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _handleDownloadTap(context),
                          icon: Icon(Icons.download_rounded, size: 18.r),
                          label: Text(
                            s.aiModelDownload,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
