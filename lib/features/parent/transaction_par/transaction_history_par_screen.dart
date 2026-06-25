import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/transaction_history/providers/transaction_owner_uid_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/transaction_filter_bar.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/transaction_history_body.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

/// Parent view of a child's transaction history.
///
/// Reuses the child transaction UI + logic unchanged. The only difference is
/// the owner uid: this screen scopes [transactionOwnerUidProvider] to the
/// selected child's uid, so every transaction provider/widget below queries the
/// child's data instead of the logged-in parent's.
class TransactionHistoryParScreen extends StatelessWidget {
  const TransactionHistoryParScreen({super.key, required this.childUid});

  final String childUid;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        transactionOwnerUidProvider.overrideWithValue(childUid),
      ],
      child: _TransactionHistoryParView(childUid: childUid),
    );
  }
}

class _TransactionHistoryParView extends HookConsumerWidget {
  const _TransactionHistoryParView({required this.childUid});

  final String childUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final logger = getIt<Logger>();
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
                showBadge: true,
                onTransactionTap: (tx) {
                  logger.d(
                    'ParTransactionHistory: open detail '
                    'child=$childUid tx=${tx.transactionId}.',
                  );
                  context.push(
                    AppRoutes.parentTransactionDetailPath(
                      childUid,
                      tx.transactionId,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
