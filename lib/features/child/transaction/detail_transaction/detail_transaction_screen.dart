import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_provider.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/detail_transaction_bottom_bar.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/error_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/transaction_content.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';

class DetailTransactionScreen extends HookConsumerWidget {
  const DetailTransactionScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

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
      if (!context.mounted || previous?.status == next.status) {
        return;
      }

      switch (next.status) {
        case TransactionStatus.error:
          if (next.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
          }
          return;
        case TransactionStatus.initial:
        case TransactionStatus.loading:
        case TransactionStatus.ready:
        case TransactionStatus.submitting:
        case TransactionStatus.success:
          break;
      }
    });

    final state = ref.watch(detailTransactionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(state, isDark),
      bottomNavigationBar: _buildBottomBar(context, ref, state, isDark, bgColor),
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
        final transaction = state.transaction;
        if (transaction == null) {
          return Center(child: Text(s.transactionDetailNoData));
        }
        return TransactionContent(state: state, isDark: isDark);
      case TransactionStatus.success:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomBar(
    BuildContext context,
    WidgetRef ref,
    DetailTransactionState state,
    bool isDark,
    Color bgColor,
  ) {
    final transaction = state.transaction;
    if (transaction == null ||
        state.status == TransactionStatus.initial ||
        state.status == TransactionStatus.loading ||
        state.status == TransactionStatus.error) {
      return const SizedBox.shrink();
    }

    return DetailTransactionBottomBar(
      isDark: isDark,
      bgColor: bgColor,
      onEdit: () async {
        ref
            .read(transactionHistoryProvider.notifier)
            .selectTransaction(transaction);
        await context.push(
          AppRoutes.updateTransactionPath(transaction.transactionId),
        );
      },
    );
  }
}
