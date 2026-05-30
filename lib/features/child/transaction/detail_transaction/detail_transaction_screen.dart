import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_provider.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/error_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/transaction_content.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class DetailTransactionScreen extends HookConsumerWidget {
  const DetailTransactionScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(detailTransactionNotifierProvider.notifier)
            .initialize(transactionId);
      });
      return null;
    }, [ref, transactionId]);

    ref.listen<DetailTransactionState>(detailTransactionNotifierProvider, (
      previous,
      next,
    ) {
      if (!context.mounted || previous?.status == next.status) return;
      if (next.status == TransactionStatus.error && next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    final state = ref.watch(detailTransactionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

    final showActions = state.transaction != null &&
        state.status != TransactionStatus.initial &&
        state.status != TransactionStatus.loading &&
        state.status != TransactionStatus.error;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.transactionDetailTitle,
          style: context.typo.subtitle.medium
              .copyWith(fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildBody(state, isDark),
          if (showActions)
            Positioned(
              bottom: 32.h,
              left: 20.w,
              right: 20.w,
              child: PrimaryButton(
                title: s.transactionEditAction,
                onTap: () async {
                  ref
                      .read(transactionHistoryProvider.notifier)
                      .selectTransaction(state.transaction!);
                  await context.push(
                    AppRoutes.updateTransactionPath(
                      state.transaction!.transactionId,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(DetailTransactionState state, bool isDark) {
    switch (state.status) {
      case TransactionStatus.initial:
      case TransactionStatus.loading:
        return TransactionDetailLoadingSkeleton(isDark: isDark);
      case TransactionStatus.error:
        return ErrorState(errorMessage: state.errorMessage);
      case TransactionStatus.ready:
      case TransactionStatus.submitting:
        if (state.transaction == null) {
          return Center(child: Text(s.transactionDetailNoData));
        }
        return TransactionContent(state: state, isDark: isDark);
      case TransactionStatus.success:
        return const SizedBox.shrink();
    }
  }
}
