import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/features/parent/home/home_tab_provider.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/features/student/home/home_tab_skeleton.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/features/auth/pin/pin_checker.dart';
import 'widgets/summary_card.dart';
import 'widgets/quick_action.dart';

class HomeTabParent extends HookConsumerWidget {
  const HomeTabParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBalanceVisible = useState(true);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkAndShowPinScreens(context);
      });
      return null;
    }, const []);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define colors used in this page specifically
    final bgColor = isDark ? const Color(0xFF152210) : const Color(0xFFF6F8F6);
    final surfaceColor = isDark ? const Color(0xFF1E2E1A) : Colors.white;
    final parentPrimary = const Color(0xFF49EC13);
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    final authState = ref.watch(authProvider);
    final user = authState.user;
    final userName = user?.displayName ?? "Phụ huynh";

    final transactionAsync = ref.watch(transactionStreamProvider);
    final recentTxsAsync = ref.watch(homeTabNotifierProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: surfaceColor.withOpacity(0.9),
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            // User Avatar
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: parentPrimary.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: user?.photoURL != null
                        ? Image.network(
                            user!.photoURL!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.person,
                                  color: AppTheme.primary,
                                ),
                          )
                        : const Icon(Icons.person, color: AppTheme.primary),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: parentPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: surfaceColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Greeting & Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chào phụ huynh,",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textSubColor,
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: const EdgeInsets.only(right: 16),
            icon: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: textSubColor,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppTheme.redAlert,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: transactionAsync.when(
        data: (transactions) {
          double totalIncome = 0;
          double totalExpense = 0;

          for (var tx in transactions) {
            if (tx.type == 'income') {
              totalIncome += tx.amount;
            } else {
              totalExpense += tx.amount;
            }
          }

          final balance = totalIncome - totalExpense;

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(homeTabNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SummaryCard(
                          parentPrimary: parentPrimary,
                          balance: balance,
                          totalIncome: totalIncome,
                          totalExpense: totalExpense,
                          isBalanceVisible: isBalanceVisible.value,
                          onVisibilityToggle: () {
                            isBalanceVisible.value = !isBalanceVisible.value;
                          },
                        ),
                      ),

                      // Quick Actions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuickAction(
                              icon: Icons.add_card,
                              label: "Nạp tiền",
                              isPrimary: true,
                              parentPrimary: parentPrimary,
                              isDark: isDark,
                            ),
                            QuickAction(
                              icon: Icons.gpp_maybe,
                              label: "Giới hạn",
                              isPrimary: false,
                              parentPrimary: parentPrimary,
                              isDark: isDark,
                            ),
                            QuickAction(
                              icon: Icons.savings,
                              label: "Tiết kiệm",
                              isPrimary: false,
                              parentPrimary: parentPrimary,
                              isDark: isDark,
                            ),
                            QuickAction(
                              icon: Icons.more_horiz,
                              label: "Thêm",
                              isPrimary: false,
                              parentPrimary: parentPrimary,
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                          ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Giao dịch mới nhất",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: parentPrimary,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Xem tất cả",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),

                // Recent Transactions List (Paginated)
                recentTxsAsync.when(
                  data: (txState) {
                    final recentTxs = txState.transactions;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (txState.isEmpty) {
                          return Container(
                            color: surfaceColor,
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(
                              child: Text(s.noTransactionsYet),
                            ),
                          );
                        }

                        return Container(
                          color: surfaceColor,
                          padding: const EdgeInsets.only(
                            bottom: 12.0,
                            left: 24,
                            right: 24,
                          ),
                          child: TransactionItem(
                            transaction: recentTxs[index],
                            onTap: () {},
                          ),
                        );
                      }, childCount: txState.isEmpty ? 1 : recentTxs.length),
                    );
                  },
                  loading: () => SliverToBoxAdapter(
                    child: Container(
                      color: surfaceColor,
                      padding: const EdgeInsets.all(32.0),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (err, stack) => SliverToBoxAdapter(
                    child: Container(
                      color: surfaceColor,
                      padding: const EdgeInsets.all(32.0),
                      child: Center(child: Text(s.errorGeneric(err.toString()))),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(height: 100, color: surfaceColor),
                ),
              ],
            ),
          );
        },
        loading: () => const HomeTabSkeleton(),
        error: (err, stack) => Center(child: Text(s.errorGeneric(err.toString()))),
      ),
    );
  }
}
