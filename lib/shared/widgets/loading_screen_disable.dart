import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/home/home_scan_bill_notifier.dart';

/// Receipt Processing Loading Dialog
/// 
/// Full-screen modal dialog shown during AI receipt scanning/processing.
/// Features:
/// - Centered white dialog card with rounded corners (34.r)
/// - Animated loading spinner around document icon
/// - Processing status text (scanning → analyzing)
/// - Cancel button to abort operation
/// - Auto-dismisses when processing completes
class ScanBillLoadingDialog extends ConsumerStatefulWidget {
  const ScanBillLoadingDialog({super.key});

  @override
  ConsumerState<ScanBillLoadingDialog> createState() =>
      _ScanBillLoadingDialogState();
}

class _ScanBillLoadingDialogState extends ConsumerState<ScanBillLoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinnerController;

  @override
  void initState() {
    super.initState();
    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat();
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final state = ref.watch(homeScanBillNotifierProvider);

    // Auto-dismiss when processing completes
    ref.listen(homeScanBillNotifierProvider, (prev, next) {
      if ((prev?.isBusy ?? false) && !next.isBusy && context.mounted) {
        context.pop();
      }
    });

    final isScanning = state.status == HomeScanBillStatus.scanning;
    final statusText =
        isScanning ? s.scanBillScanningStatus : s.scanBillAnalyzingStatus;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.12),
        body: Center(
          child: Container(
            width: 300.w,
            padding: EdgeInsets.fromLTRB(24.w, 36.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(34.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 20.h),
                  blurRadius: 40.r,
                  color: Colors.black.withValues(alpha: 0.12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon in circle + circular spinner ring
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Spinner — CircularProgressIndicator tự animate, bao quanh icon
                    SizedBox(
                      width: 88.w,
                      height: 88.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                        backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                      ),
                    ),

                    // Icon trong container hình tròn
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.backgroundLight,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '📄',
                          style: TextStyle(
                            fontSize: 36.sp,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 6,
                                color: AppTheme.primary.withValues(alpha: 0.15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // Title
                Text(
                  s.scanBillLoadingTitle,
                  style: context.typo.title.large.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.02,
                    color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.h),

                // Status Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    statusText,
                    style: context.typo.body.medium.copyWith(
                      color: AppTheme.textGrey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 32.h),

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  height: 65.h,
                  child: ElevatedButton(
                    onPressed: () =>
                        ref.read(homeScanBillNotifierProvider.notifier).cancel(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
                      foregroundColor:
                          isDark ? AppTheme.textWhite : AppTheme.textBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(
                          color: isDark
                              ? AppTheme.borderDark
                              : AppTheme.borderLight,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      s.actionCancel,
                      style: context.typo.button.medium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
