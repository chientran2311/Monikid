import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
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

    // Start pipeline then immediately show loading dialog.
    ref
        .read(homeScanBillNotifierProvider.notifier)
        .scanAndAnalyze(imageSelection);

    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ScanBillLoadingDialog(),
    );

    // Dialog auto-closed (pipeline done or user cancelled). Handle result.
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

    final actions = [
      (
        icon: Icons.qr_code_scanner,
        label: s.scanbill,
        color: Colors.orange,
        onTap: isBusy ? null : () => _handleScanBill(context, ref),
      ),
      (
        icon: Icons.track_changes,
        label: s.homeStudentSetMonthlyLimit,
        color: Colors.teal,
        onTap: onSetLimitTap,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = ScreenUtils.screenWidth;
        final screenHeight = ScreenUtils.screenHeight;
        final spacing = 12.w;
        final availableWidth = constraints.maxWidth - (spacing * 2);
        final itemWidth = availableWidth / 3;
        final circleSize = (screenWidth * 0.14).clamp(48.0, 62.0);
        final iconSize = (circleSize * 0.48).clamp(22.0, 30.0);
        final labelFontSize = screenHeight < 700 ? 11.5.r : 12.5.r;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: actions
              .map((action) {
                final index = actions.indexOf(action);
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == actions.length - 1 ? 0 : spacing,
                    ),
                    child: Opacity(
                      opacity: action.onTap == null ? 0.5 : 1.0,
                      child: SizedBox(
                        width: itemWidth,
                        child: QuickAction(
                          icon: action.icon,
                          label: action.label,
                          color: action.color,
                          isDark: isDark,
                          circleSize: circleSize,
                          iconSize: iconSize,
                          labelFontSize: labelFontSize,
                          onTap: action.onTap,
                        ),
                      ),
                    ),
                  ),
                );
              })
              .toList(growable: false),
        );
      },
    );
  }
}
