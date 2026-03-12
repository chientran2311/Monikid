import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/statistic/statistic_provider.dart';
import 'widgets/month_tab.dart';
import 'widgets/legend_item.dart';
import 'widgets/category_progress_item.dart';
import 'widgets/custom_scroll_month.dart';
import 'widgets/custom_scroll_week.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final statState = ref.read(statisticProvider);
    if (statState.isLoading || statState.isLoadingMore || statState.isRefreshing || !statState.hasMore) {
      return;
    }
    
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(statisticProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : const Color(0xFFf9fbf9);
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    final statState = ref.watch(statisticProvider);
    final txs = statState.transactions;
    final prevTxs = statState.previousPeriodTransactions;

    // Currency formatter
    final formatCurrency = NumberFormat.currency(locale: 'vi', symbol: 'đ');

    final periodName = statState.selectedMonthIndex == 0 ? "tuần" : "tháng";

    // Determine diff percentage and text
    double curTotal = statState.totalExpense;
    double prevTotal = statState.previousPeriodTotalExpense;
    double percentDiff = 0;
    String diffText = "Chưa có dữ liệu $periodName trước";
    IconData diffIcon = Icons.remove;
    Color diffColor = Colors.white; // Default for no-data

    if (prevTotal > 0) {
      if (curTotal > prevTotal) {
        percentDiff = ((curTotal - prevTotal) / prevTotal) * 100;
        diffText = "Cao hơn ${percentDiff.toStringAsFixed(1)}% so với $periodName trước";
        diffIcon = Icons.trending_up;
        diffColor = Colors.redAccent;
      } else {
        percentDiff = ((prevTotal - curTotal) / prevTotal) * 100;
        diffText = "Thấp hơn ${percentDiff.toStringAsFixed(1)}% so với $periodName trước";
        diffIcon = Icons.trending_down;
        diffColor = Colors.white;
      }
    } else if (prevTotal == 0 && curTotal > 0) {
      diffText = "Không có chi tiêu $periodName trước";
      diffIcon = Icons.trending_up;
      diffColor = Colors.redAccent;
    }

    // Category calculation for Current Month
    final categoryTotals = <String, double>{};
    for (final tx in txs) {
      categoryTotals[tx.category] = (categoryTotals[tx.category] ?? 0) + tx.amount;
    }

    // Sort top 3
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top3 = sortedCategories.take(3).toList();

    // Category calculation for Previous Month to compare
    final prevCategoryTotals = <String, double>{};
    for (final tx in prevTxs) {
      prevCategoryTotals[tx.category] = (prevCategoryTotals[tx.category] ?? 0) + tx.amount;
    }

    // Prepare legend colors generically
    final List<Color> legendColors = [
      AppTheme.primary,
      const Color(0xFFE89F29),
      const Color(0xFF5e8761),
      const Color(0xFFa3c4a6),
    ];

    IconData getIconForCategory(String category) {
      switch (category.toLowerCase()) {
        case 'ăn uống':
          return Icons.restaurant;
        case 'học tập':
          return Icons.school;
        case 'di chuyển':
          return Icons.directions_bus;
        case 'mua sắm':
          return Icons.shopping_bag;
        case 'giải trí':
          return Icons.sports_esports;
        default:
          return Icons.category;
      }
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.surfaceDark.withOpacity(0.9)
            : const Color(0xFFf9fbf9).withOpacity(0.9),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Thống kê Chi tiêu",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(statisticProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Month Selector
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9), // slate-800 / slate-100
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          MonthTab(
                            title: "Theo tuần",
                            index: 0,
                            isDark: isDark,
                            selectedMonthIndex: statState.selectedMonthIndex,
                            onMonthSelected: (idx) => ref
                                .read(statisticProvider.notifier)
                                .setMonthIndex(idx),
                          ),
                          MonthTab(
                            title: "Theo tháng",
                            index: 1,
                            isDark: isDark,
                            selectedMonthIndex: statState.selectedMonthIndex,
                            onMonthSelected: (idx) => ref
                                .read(statisticProvider.notifier)
                                .setMonthIndex(idx),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (statState.selectedMonthIndex == 0)
                      const CustomScrollWeek()
                    else
                      const CustomScrollMonth(),
                    const SizedBox(height: 24),

                    // Error Message
                    if (statState.errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          statState.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (statState.isLoading && txs.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      // Total Spend Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -40,
                              right: -30,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tổng chi tiêu $periodName này",
                                  style: const TextStyle(
                                    color: Color(0xFFeaf5ea),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatCurrency.format(statState.totalExpense),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        diffIcon,
                                        size: 14,
                                        color: diffColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        diffText,
                                        style: TextStyle(
                                          color: diffColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Chart Section (Fake UI circle chart adapted to real data if any)
                      if (sortedCategories.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF1F5F9),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phân bổ chi tiêu",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Circular Chart Mockup
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Base gray circle
                                    SizedBox(
                                      width: 180,
                                      height: 180,
                                      child: CircularProgressIndicator(
                                        value: 1.0,
                                        strokeWidth: 20,
                                        color: isDark
                                            ? const Color(0xFF334155)
                                            : const Color(0xFFE2E8F0),
                                        strokeCap: StrokeCap.round,
                                      ),
                                    ),
                                    // Layering progresses from smallest to largest so they overlay
                                    // Wait, CircularProgressIndicator starts from top and goes right.
                                    // If we want a true pie chart, we need a package. We will simulate with stacked progressed.
                                    ...List.generate(top3.length, (index) {
                                      // Render from largest to smallest so they appear layered
                                      // Actually, render from largest (index 0) to smallest (last)
                                      // e.g. 1st: value=1.0 (portion of circle), 2nd: value=0.6, 3rd: value=0.3
                                      double cumulativeSum = 0;
                                      for (int i = 0; i <= index; i++) {
                                        cumulativeSum += top3[i].value;
                                      }
                                      double val =
                                          cumulativeSum / statState.totalExpense;
                                      return SizedBox(
                                        width: 180,
                                        height: 180,
                                        child: CircularProgressIndicator(
                                          value: val,
                                          strokeWidth: 20,
                                          color: legendColors[
                                              index % legendColors.length],
                                          backgroundColor: Colors.transparent,
                                          strokeCap: StrokeCap.round,
                                        ),
                                      );
                                    }).reversed,

                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Cao nhất",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                        Text(
                                          top3.isNotEmpty
                                              ? top3.first.key
                                              : "Chưa có",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Legend
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                  top3.length,
                                  (index) => LegendItem(
                                    label: top3[index].key,
                                    color: legendColors[
                                        index % legendColors.length],
                                    isDark: isDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (sortedCategories.isNotEmpty)
                        const SizedBox(height: 24),

                      // Top Categories List
                      if (sortedCategories.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top 3 danh mục chi tiêu",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(top3.length, (index) {
                          final category = top3[index].key;
                          final amount = top3[index].value;
                          final percent =
                              statState.totalExpense > 0
                                  ? amount / statState.totalExpense
                                  : 0.0;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: CategoryProgressItem(
                              icon: getIconForCategory(category),
                              name: category,
                              amount: formatCurrency.format(amount),
                              percent: percent,
                              color: legendColors[index % legendColors.length],
                              isDark: isDark,
                            ),
                          );
                        }),
                      ],

                      // Categories Trend Comparison
                      if (sortedCategories.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biến động danh mục",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...sortedCategories.map((entry) {
                          final category = entry.key;
                          final currentAmount = entry.value;
                          final prevAmount = prevCategoryTotals[category] ?? 0.0;

                          IconData trendIcon;
                          Color trendColor;
                          String diffStr;

                          if (currentAmount > prevAmount) {
                            trendIcon = Icons.arrow_upward;
                            trendColor = Colors.redAccent;
                            double p = prevAmount > 0
                                ? ((currentAmount - prevAmount) / prevAmount) * 100
                                : 100.0;
                            diffStr = "+${p.toStringAsFixed(0)}%";
                          } else if (currentAmount < prevAmount) {
                            trendIcon = Icons.arrow_downward;
                            trendColor = Colors.green;
                            double p = currentAmount > 0
                                ? ((prevAmount - currentAmount) / prevAmount) * 100
                                : 100.0;
                            diffStr = "-${p.toStringAsFixed(0)}%";
                          } else {
                            trendIcon = Icons.remove;
                            trendColor = Colors.grey;
                            diffStr = "0%";
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: surfaceColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF1F5F9),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                                  child: Icon(
                                    getIconForCategory(category),
                                    color: AppTheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatCurrency.format(currentAmount),
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(trendIcon, color: trendColor, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          diffStr,
                                          style: TextStyle(
                                            color: trendColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],

                      const SizedBox(height: 100), // Bottom nav padding
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
