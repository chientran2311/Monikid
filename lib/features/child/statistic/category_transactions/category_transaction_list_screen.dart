import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transaction_list_provider.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transaction_list_state.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transactions_args.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_item.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class CategoryTransactionListScreen extends HookConsumerWidget {
  const CategoryTransactionListScreen({super.key, required this.args});

  final CategoryTransactionsArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(categoryTransactionListNotifierProvider);
    final notifier = ref.read(categoryTransactionListNotifierProvider.notifier);

    useEffect(() {
      Future.microtask(() => notifier.load(args));
      return null;
    }, [args.categoryKey, args.selectedTabIndex, args.transactionType]);

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: context.l10n.statisticCategoryTransactionListTitle,
      ),
      body: AppBackground(
        whiteBackground: true,
        child: _buildBody(context, state, isDark),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CategoryTransactionListState state,
    bool isDark,
  ) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    if (state.status == CategoryTransactionListStatus.initial ||
        state.isLoading) {
      return _Skeleton(isDark: isDark, topPadding: topPadding);
    }

    if (state.hasError || state.transactions.isEmpty) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              context.l10n.noTransactionsYet,
              textAlign: TextAlign.center,
              style: context.typo.body.medium.copyWith(
                color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
              ),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: topPadding,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      itemCount: state.transactions.length,
      itemBuilder: (context, index) {
        final transaction = state.transactions[index];
        return TransactionItem(
          transaction: transaction,
          showBadge: true,
          onTap: () => context.push(
            AppRoutes.detailTransactionPath(transaction.transactionId),
          ),
        );
      },
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({required this.isDark, required this.topPadding});

  final bool isDark;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final shimmerColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: topPadding,
          left: 20.w,
          right: 20.w,
          bottom: 24.h,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: shimmerColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.h,
                        width: 130.w,
                        color: shimmerColor,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 10.h,
                        width: 90.w,
                        color: shimmerColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(height: 16.h, width: 70.w, color: shimmerColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
