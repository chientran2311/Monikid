import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/home/home_scan_bill_notifier.dart';
import 'package:monikid/features/child/home/widgets/quick_action.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/shared/widgets/loading_screen_disable.dart';

class HomeQuickActions extends ConsumerWidget {
  const HomeQuickActions({
    required this.isDark,
    required this.onSetLimitTap,
    super.key,
  });

  final bool isDark;
  final VoidCallback onSetLimitTap;

  Future<void> _handleScanBill(BuildContext context, WidgetRef ref) async {
    final imageSelection =
        await showModalBottomSheet<TransactionImageSelection>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UploadPicDialog(
        imageIntake: ref.read(transactionImageIntakeProvider),
      ),
    );

    if (!context.mounted || imageSelection == null) return;

    ref
        .read(homeScanBillNotifierProvider.notifier)
        .scanAndAnalyze(imageSelection);

    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ScanBillLoadingDialog(),
    );

    if (!context.mounted) return;
    final finalState = ref.read(homeScanBillNotifierProvider);
    if (finalState.status == HomeScanBillStatus.ready &&
        finalState.transactionAiResult != null) {
      context.push(
        AppRoutes.addTransaction,
        extra: (finalState.transactionAiResult, finalState.scannedImage),
      );
      ref.read(homeScanBillNotifierProvider.notifier).reset();
    } else if (finalState.status == HomeScanBillStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.scanBillAiError)),
      );
      ref.read(homeScanBillNotifierProvider.notifier).reset();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isBusy = ref.watch(
      homeScanBillNotifierProvider.select((s) => s.isBusy),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.homeStudentQuickActionsTitle,
          style: context.typo.title.small.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textBlack,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: Opacity(
                opacity: isBusy ? 0.5 : 1.0,
                child: QuickAction(
                  emoji: '🧾',
                  title: s.homeStudentScanBillTitle,
                  subtitle: s.homeStudentScanBillSubtitle,
                  isDark: isDark,
                  onTap: isBusy ? null : () => _handleScanBill(context, ref),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: QuickAction(
                emoji: '🎯',
                title: s.homeStudentSetMonthlyLimit,
                subtitle: s.homeStudentSetLimitSubtitle,
                isDark: isDark,
                onTap: onSetLimitTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
