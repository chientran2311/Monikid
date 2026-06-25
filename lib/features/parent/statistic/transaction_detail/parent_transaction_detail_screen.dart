import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_provider.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_state.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/parent_transaction_detail_card.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/parent_transaction_detail_skeleton.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class ParentTransactionDetailScreen extends HookConsumerWidget {
  const ParentTransactionDetailScreen({
    super.key,
    required this.childUid,
    required this.transactionId,
  });

  final String childUid;
  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    useEffect(() {
      Future.microtask(
        () => ref.read(parentTransactionDetailNotifierProvider.notifier).load(
              childUid: childUid,
              transactionId: transactionId,
            ),
      );
      return null;
    }, [childUid, transactionId]);

    final state = ref.watch(parentTransactionDetailNotifierProvider);

    Widget body;

    if (state.isLoading ||
        state.status == ParentTransactionDetailStatus.initial) {
      body = ParentTransactionDetailSkeleton(isDark: isDark);
    } else if (state.hasError) {
      body = Center(child: Text(context.l10n.transactionLoadError));
    } else {
      final transaction = state.transaction;
      if (transaction == null) {
        body = Center(child: Text(context.l10n.transactionDetailNoData));
      } else {
        body = SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 20.h,
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
          ),
          child: ParentTransactionDetailCard(
            transaction: transaction,
            isDark: isDark,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: context.l10n.transactionDetailTitle),
      body: AppBackground(child: body),
    );
  }
}
