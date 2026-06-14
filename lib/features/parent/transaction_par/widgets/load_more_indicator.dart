import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/shared/widgets/skeleton_widget/transaction_history_skeleton.dart';

class LoadMoreIndicator extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMore;
  final bool hasTransactions;
  final bool isDark;

  const LoadMoreIndicator({
    super.key,
    required this.isLoadingMore,
    required this.hasMore,
    required this.hasTransactions,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return Column(
        children: List.generate(
          2,
          (_) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: TransactionItemSkeleton(isDark: isDark),
          ),
        ),
      );
    }

    if (!hasMore && hasTransactions) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Đã hiển thị tất cả giao dịch',
            style: context.typo.caption.big.copyWith(
              color: isDark ? Colors.white38 : Colors.black26,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
