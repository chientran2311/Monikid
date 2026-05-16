import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/home/home_scan_bill_notifier.dart';

class ScanBillLoadingDialog extends ConsumerWidget {
  const ScanBillLoadingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final state = ref.watch(homeScanBillNotifierProvider);

    ref.listen(homeScanBillNotifierProvider, (prev, next) {
      if ((prev?.isBusy ?? false) && !next.isBusy && context.mounted) {
        context.pop();
      }
    });

    final isScanning = state.status == HomeScanBillStatus.scanning;
    final statusText =
        isScanning ? s.scanBillScanningStatus : s.scanBillAnalyzingStatus;

    final bgColor =
        isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final subTextColor =
        isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor =
        isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 280.w,
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72.r,
                    height: 72.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.orangeWarning,
                      ),
                    ),
                  ),
                  Icon(
                    isScanning
                        ? Icons.document_scanner_outlined
                        : Icons.auto_awesome_outlined,
                    size: 32.r,
                    color: AppTheme.orangeWarning,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                s.scanBillLoadingTitle,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                statusText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: subTextColor,
                ),
              ),
              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: OutlinedButton(
                  onPressed: () =>
                      ref.read(homeScanBillNotifierProvider.notifier).cancel(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: subTextColor,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
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
