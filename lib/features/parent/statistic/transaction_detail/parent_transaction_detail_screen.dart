import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_provider.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_state.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/parent_transaction_detail_card.dart';

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
    ScreenUtils.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

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
      body = const Center(child: CircularProgressIndicator());
    } else if (state.hasError) {
      body = Center(child: Text(context.l10n.transactionLoadError));
    } else {
      final transaction = state.transaction;
      if (transaction == null) {
        body = Center(child: Text(context.l10n.transactionDetailNoData));
      } else {
        body = SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: ParentTransactionDetailCard(
            transaction: transaction,
            isDark: isDark,
          ),
        );
      }
    }

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
          context.l10n.transactionDetailTitle,
          style: TextStyle(
            color: textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
