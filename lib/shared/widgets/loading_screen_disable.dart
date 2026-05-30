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
              color: AppTheme.surfaceLight,
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
                // Icon Container with Loading Spinner
                SizedBox(
                  width: 88.w,
                  height: 88.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Circle
                      Container(
                        width: 88.w,
                        height: 88.h,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.backgroundLight,
                            width: 4,
                          ),
                        ),
                      ),

                      // Rotating Spinner
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _spinnerController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Container(
                          width: 96.w,
                          height: 96.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border(
                              top: BorderSide(
                                color: AppTheme.primary,
                                width: 4,
                              ),
                              right: BorderSide(
                                color: AppTheme.primary.withValues(alpha: 0.1),
                                width: 4,
                              ),
                              bottom: BorderSide(
                                color: Colors.transparent,
                                width: 4,
                              ),
                              left: BorderSide(
                                color: Colors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Document Icon
                      Text(
                        '📄',
                        style: TextStyle(
                          fontSize: 40.sp,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4.h),
                              blurRadius: 6.r,
                              color: AppTheme.primary.withValues(alpha: 0.1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // Title
                Text(
                  s.scanBillLoadingTitle,
                  style: context.typo.title.large.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.02,
                    color: AppTheme.textBlack,
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
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () =>
                        ref.read(homeScanBillNotifierProvider.notifier).cancel(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.surfaceLight,
                      foregroundColor: AppTheme.textBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(
                          color: AppTheme.borderLight,
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
