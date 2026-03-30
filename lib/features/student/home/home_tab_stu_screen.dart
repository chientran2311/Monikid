import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/features/student/home/home_tab_provider.dart';
import 'package:monikid/features/student/home/home_tab_skeleton.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/auth/pin/pin_checker.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
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

    final authState = ref.watch(authSessionProvider);
    final user = authState.user;
    final userName = user?.displayName ?? "Học sinh";

    final transactionAsync = ref.watch(transactionStreamProvider);

    final recentTxsAsync = ref.watch(homeTabNotifierProvider);
    final summaryAsync = ref.watch(homeMonthlySummaryProvider);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: transactionAsync.when(
          data: (transactions) {
            final summary = summaryAsync.valueOrNull ?? (totalIncome: 0.0, totalExpense: 0.0);
            final totalIncome = summary.totalIncome;
            final totalExpense = summary.totalExpense;
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
                            label: s.scanbill,
                            color: Colors.orange,
                            isDark: isDark,
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const UploadPicDialog(),
                              );
                            },
                          ),
                          QuickAction(
                            icon: Icons.account_balance_wallet,
                            label: s.chatting,
                            color: Colors.blue,
                            isDark: isDark,
                             onTap: () {},
                          ),
                          QuickAction(
                            icon: Icons.savings,
                            label: s.requestmoney,
                            color: Colors.purple,
                            isDark: isDark,
                             onTap: () {},
                          ),
                          QuickAction(
                            icon: Icons.more_horiz,
                            label: "Xem thêm",
                            color: Colors.pink,
                            isDark: isDark,
                             onTap: () {},
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
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Center(
                              child: Text(s.noTransactionsYet),
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
                        child: Center(child: Text(s.errorGeneric(err.toString()))),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          },
          loading: () => const HomeTabSkeleton(),
          error: (err, stack) => RefreshIndicator(
            onRefresh: () async {
               // Trigger a rebuild of the stream provider by calling refresh on homeTabNotifierProvider 
               // (or invalidating the stream provider directly)
               ref.invalidate(transactionStreamProvider);
               await ref.read(homeTabNotifierProvider.notifier).refresh();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            "Có lỗi xảy ra khi tải dữ liệu.\nVui lòng kiểm tra console/log (nếu là lỗi Index).",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: textColor),
                          ),
                          const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref.invalidate(transactionStreamProvider);
                                ref.read(homeTabNotifierProvider.notifier).refresh();
                              },
                              child: Text(s.actionRetry),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
