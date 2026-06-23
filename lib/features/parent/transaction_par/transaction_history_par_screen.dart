import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/transaction_filter_bar.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/transaction_history_body.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class TransactionHistoryParScreen extends HookConsumerWidget {
  const TransactionHistoryParScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1;

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
      appBar: GlassAppBar(title: s.transactionHistoryTitle),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Parent view: read-only categories (no add / no drag-to-delete),
              // no monthly-limit box — these are child-only business features.
              TransactionFilterBar(
                isDark: isDark,
                allowCategoryManagement: false,
              ),
              TransactionHistoryBody(
                scrollController: scrollCtrl,
                isDark: isDark,
                showMonthlyLimit: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
