import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/features/student/home/home_tab_provider.dart';
import 'package:monikid/features/student/home/home_tab_skeleton.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/auth/pin/pin_checker.dart';
import 'widgets/summary_mini_card.dart';
import 'widgets/quick_action.dart';

class HomeTabStudent extends HookConsumerWidget {
  const HomeTabStudent({Key? key}) : super(key: key);

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
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    final authState = ref.watch(authProvider);
    final user = authState.user;
    final userName = user?.displayName ?? "Học sinh";

    final transactionAsync = ref.watch(transactionStreamProvider);

    final recentTxsAsync = ref.watch(homeTabNotifierProvider);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: transactionAsync.when(
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
                  // Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chào buổi sáng,",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? const Color(0xFF94A3B8)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.primary.withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: user?.photoURL != null
                                      ? Image.network(
                                          user!.photoURL!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                                    Icons.person,
                                                    color: AppTheme.primary,
                                                  ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: AppTheme.primary,
                                        ),
                                ),
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade400,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFF1c2a1e)
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Summary Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF2f7f34), Color(0xFF246228)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -40,
                              right: -40,
                              child: Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -32,
                              left: -32,
                              child: Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Số dư hiện tại",
                                      style: TextStyle(
                                        color: Colors.green.shade100
                                            .withOpacity(0.9),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => isBalanceVisible.value =
                                          !isBalanceVisible.value,
                                      child: Icon(
                                        isBalanceVisible.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.green.shade100,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isBalanceVisible.value
                                      ? CurrencyFormatter.format(balance)
                                      : "******",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    SummaryMiniCard(
                                      title: "Tổng Thu",
                                      amount: CurrencyFormatter.formatCompact(
                                        totalIncome,
                                      ),
                                      icon: Icons.arrow_downward,
                                      iconColor: Colors.blue.shade200,
                                      iconBgColor: Colors.blue.shade500
                                          .withOpacity(0.2),
                                      isVisible: isBalanceVisible.value,
                                    ),
                                    const SizedBox(width: 16),
                                    SummaryMiniCard(
                                      title: "Tổng Chi",
                                      amount: CurrencyFormatter.formatCompact(
                                        totalExpense,
                                      ),
                                      icon: Icons.arrow_upward,
                                      iconColor: Colors.red.shade200,
                                      iconBgColor: Colors.red.shade500
                                          .withOpacity(0.2),
                                      isVisible: isBalanceVisible.value,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Quick Actions Grid
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuickAction(
                            icon: Icons.qr_code_scanner,
                            label: "Quét QR",
                            color: Colors.orange,
                            isDark: isDark,
                          ),
                          QuickAction(
                            icon: Icons.account_balance_wallet,
                            label: "Nạp tiền",
                            color: Colors.blue,
                            isDark: isDark,
                          ),
                          QuickAction(
                            icon: Icons.savings,
                            label: "Tiết kiệm",
                            color: Colors.purple,
                            isDark: isDark,
                          ),
                          QuickAction(
                            icon: Icons.more_horiz,
                            label: "Xem thêm",
                            color: Colors.pink,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Recent Transactions Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 24.0,
                        bottom: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Giao dịch gần đây",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: Chuyển qua tab lịch sử
                            },
                            child: const Text(
                              "Xem tất cả",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Recent Transactions List
                  recentTxsAsync.when(
                    data: (txState) {
                      final recentTxs = txState.transactions;
                      if (txState.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Center(
                              child: Text("Chưa có giao dịch nào."),
                            ),
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return TransactionItem(
                              transaction: recentTxs[index],
                              onTap: () {
                                context.push(
                                  AppRoutes.detailTransaction,
                                  extra: recentTxs[index],
                                );
                              },
                            );
                          }, childCount: recentTxs.length),
                        ),
                      );
                    },
                    loading: () => const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    error: (err, stack) => SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(child: Text("Lỗi: $err")),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          },
          loading: () => const HomeTabSkeleton(),
          error: (err, stack) => Center(child: Text("Lỗi: $err")),
        ),
      ),
    );
  }
}
