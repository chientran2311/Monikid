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
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_provider.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_state.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/features/transaction/transaction_type.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class ParentCategoryTransactionsArgs {
  const ParentCategoryTransactionsArgs({
    required this.childUid,
    required this.categoryKey,
    required this.categoryLabel,
    required this.period,
    this.transactionType = TransactionType.expense,
  });

  final String childUid;
  final String categoryKey;
  final String categoryLabel;
  final ParentStatisticPeriod period;
  final TransactionType transactionType;
}

class ParentCategoryTransactionsScreen extends HookConsumerWidget {
  const ParentCategoryTransactionsScreen({super.key, required this.args});

  final ParentCategoryTransactionsArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    useEffect(() {
      Future.microtask(
        () => ref.read(parentCategoryTransactionsNotifierProvider.notifier).load(
              childUid: args.childUid,
              categoryKey: args.categoryKey,
              period: args.period,
              transactionType: args.transactionType,
            ),
      );
      return null;
    }, [args.childUid, args.categoryKey, args.period, args.transactionType]);

    final state = ref.watch(parentCategoryTransactionsNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: args.categoryLabel),
      body: AppBackground(
        child: _Body(
          state: state,
          isDark: isDark,
          childUid: args.childUid,
        ),
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
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + kToolbarHeight + 20.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
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

class _TransactionTile extends ConsumerWidget {
  const _TransactionTile({
    required this.transaction,
    required this.isDark,
    required this.onTap,
  });

  final TransactionModel transaction;
  final bool isDark;
  final VoidCallback onTap;

  static bool _isEdited(TransactionModel t) =>
      t.updatedAt != null &&
      t.createdAt != null &&
      t.updatedAt!.isAfter(t.createdAt!);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final categoryLabel =
        findCategoryByTransactionKey(categories, transaction.categoryKey)?.label ??
        transaction.categoryLabel;
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          categoryLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typo.body.medium.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (_isEdited(transaction)) ...[
                        SizedBox(width: 6.w),
                        _EditedBadge(isDark: isDark),
                      ],
                    ],
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

class _EditedBadge extends StatelessWidget {
  const _EditedBadge({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.amberFill,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        context.l10n.parentStatisticEditedBadge,
        style: context.typo.caption.small.copyWith(
          color: AppTheme.amberText,
          fontWeight: FontWeight.w600,
          fontSize: 9.sp,
        ),
      ),
    );
  }
}
