import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/statistic/statistic_provider.dart';

class CustomScrollMonth extends ConsumerStatefulWidget {
  const CustomScrollMonth({super.key});

  @override
  ConsumerState<CustomScrollMonth> createState() => _CustomScrollMonthState();
}

class _CustomScrollMonthState extends ConsumerState<CustomScrollMonth> {
  late List<DateTime> _months;
  late ScrollController _scrollController;
  final double _itemWidth = 100.0;

  @override
  void initState() {
    super.initState();
    _months = _generateMonths();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateMonths() {
    final now = DateTime.now();
    final List<DateTime> list = [];
    for (int i = 0; i <= 24; i++) {
      list.add(DateTime(now.year, now.month - i));
    }
    return list;
  }

  String _formatMonth(DateTime month) {
    final now = DateTime.now();
    if (month.year == now.year && month.month == now.month) {
      return 'Tháng này';
    } else if ((month.year == now.year && month.month == now.month - 1) || 
              (now.month == 1 && month.year == now.year - 1 && month.month == 12)) {
      return 'Tháng trước';
    } else {
      return '${month.month}/${month.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statisticProvider);
    final selectedMonth = state.selectedDate ?? DateTime.now();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        reverse: true, // "kéo từ trái -> phải -> sẽ hiển thị các tháng trước đó"
        itemCount: _months.length,
        itemBuilder: (context, index) {
          final month = _months[index];
          final isSelected = selectedMonth.year == month.year &&
                selectedMonth.month == month.month;

          return GestureDetector(
            onTap: () {
              ref.read(statisticProvider.notifier).setSelectedDate(month);
            },
            child: Container(
              width: _itemWidth,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.primary 
                    : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                _formatMonth(month),
                style: TextStyle(
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
