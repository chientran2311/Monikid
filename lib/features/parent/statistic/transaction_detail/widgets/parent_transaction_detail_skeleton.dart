import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/parent_transaction_detail_card.dart';
import 'package:monikid/models/entities/transaction_model.dart';

/// Loading placeholder for the parent transaction detail screen. Mirrors the
/// real success layout (icon → amount → category → info rows) by feeding the
/// actual [ParentTransactionDetailCard] mock data inside a [Skeletonizer], so
/// the transition into loaded content has no layout shift.
class ParentTransactionDetailSkeleton extends StatelessWidget {
  const ParentTransactionDetailSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 20.h,
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
        ),
        child: ParentTransactionDetailCard(
          transaction: _mockTransaction(),
          isDark: isDark,
        ),
      ),
    );
  }

  TransactionModel _mockTransaction() {
    final anchor = DateTime(2024, 1, 1, 12);
    return TransactionModel(
      transactionId: 'mock',
      userId: 'mock',
      amountMinor: 120000,
      type: 'expense',
      categoryKey: 'mock',
      categoryLabel: 'Danh mục',
      categoryIcon: '💸',
      note: 'Ghi chú giao dịch',
      dateTs: anchor,
      createdAt: anchor,
    );
  }
}
