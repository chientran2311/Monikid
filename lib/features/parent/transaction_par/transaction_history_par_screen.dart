import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/parent/transaction_par/widgets/transaction_filter_bar.dart';
import 'package:monikid/features/parent/transaction_par/widgets/transaction_history_par_body.dart';
import 'package:monikid/shared/widgets/app_bar_push.dart';

class TransactionHistoryParScreen extends HookConsumerWidget {
  const TransactionHistoryParScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    final scrollCtrl = useScrollController();

    useEffect(() {
      Future.microtask(() {
        ref.read(transactionHistoryProvider.notifier).init();
      });
      return null;
    }, const []);

    final isLoadingMore = ref.watch(
      transactionHistoryProvider.select((v) => v.isLoadingMore),
    );
    final hasMore = ref.watch(
      transactionHistoryProvider.select((v) => v.hasMore),
    );

    useEffect(() {
      void onScroll() {
        if (!scrollCtrl.hasClients) return;
        final position = scrollCtrl.position;
        if (position.pixels >= position.maxScrollExtent - 120 &&
            !isLoadingMore &&
            hasMore) {
          ref.read(transactionHistoryProvider.notifier).loadMore();
        }
      }

      scrollCtrl.addListener(onScroll);
      return () => scrollCtrl.removeListener(onScroll);
    }, [scrollCtrl, isLoadingMore, hasMore]);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: const AppBarPush(title: 'Lịch sử Giao dịch'),
      body: SafeArea(
        child: Column(
          children: [
            TransactionFilterBar(isDark: isDark),
            TransactionHistoryParBody(
              scrollController: scrollCtrl,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
