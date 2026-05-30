import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_provider.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_state.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class ParentCategoryTransactionsArgs {
  const ParentCategoryTransactionsArgs({
    required this.childUid,
    required this.categoryKey,
    required this.categoryLabel,
    required this.period,
  });

  final String childUid;
  final String categoryKey;
  final String categoryLabel;
  final ParentStatisticPeriod period;
}

class ParentCategoryTransactionsScreen extends HookConsumerWidget {
  const ParentCategoryTransactionsScreen({super.key, required this.args});

  final ParentCategoryTransactionsArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

    useEffect(() {
      Future.microtask(
        () => ref.read(parentCategoryTransactionsNotifierProvider.notifier).load(
              childUid: args.childUid,
              categoryKey: args.categoryKey,
              period: args.period,
            ),
      );
      return null;
    }, [args.childUid, args.categoryKey, args.period]);

    final state = ref.watch(parentCategoryTransactionsNotifierProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          args.categoryLabel,
          style: context.typo.subtitle.medium.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: _Body(
        state: state,
        isDark: isDark,
        childUid: args.childUid,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.isDark,
    required this.childUid,
  });

  final ParentCategoryTransactionsState state;
  final bool isDark;
  final String childUid;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading ||
        state.status == ParentCategoryTransactionsStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return Center(child: Text(context.l10n.transactionLoadError));
    }

    if (state.transactions.isEmpty) {
      return Center(child: Text(context.l10n.parentStatisticNoData));
    }

    return ListView.separated(
      padding: EdgeInsets.all(20.r),
      itemCount: state.transactions.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final transaction = state.transactions[index];
        return _TransactionTile(
          transaction: transaction,
          isDark: isDark,
          onTap: () => context.push(
            AppRoutes.parentTransactionDetailPath(
              childUid,
              transaction.transactionId,
            ),
          ),
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.transaction,
    required this.isDark,
    required this.onTap,
  });

  final TransactionModel transaction;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  transaction.categoryIcon ?? '💸',
                  style: context.typo.subtitle.medium,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.categoryLabel,
                    style: context.typo.body.medium.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(transaction.date),
                    style: context.typo.caption.big.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
            Text(
              CurrencyFormatter.format(transaction.amountMinor),
              style: context.typo.body.medium.copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right_rounded, color: mutedColor, size: 20.r),
          ],
        ),
      ),
    );
  }
}
