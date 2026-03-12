import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/statistic/statistic_provider.dart';

class CustomScrollWeek extends ConsumerStatefulWidget {
  const CustomScrollWeek({super.key});

  @override
  ConsumerState<CustomScrollWeek> createState() => _CustomScrollWeekState();
}

class _CustomScrollWeekState extends ConsumerState<CustomScrollWeek> {
  late List<DateTime> _weeks;
  late ScrollController _scrollController;
  final double _itemWidth = 120.0;

  @override
  void initState() {
    super.initState();
    _weeks = _generateWeeks();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateWeeks() {
    final now = DateTime.now();
    final List<DateTime> list = [];
    final currentDay = now.weekday;
    final mondayOfThisWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: currentDay - 1));
    
    for (int i = 0; i <= 19; i++) { // 20 latest weeks
      list.add(mondayOfThisWeek.subtract(Duration(days: 7 * i)));
    }
    return list;
  }

  String _formatWeek(DateTime monday) {
    final now = DateTime.now();
    final currentDay = now.weekday;
    final mondayOfThisWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: currentDay - 1));
    final diffDays = mondayOfThisWeek.difference(monday).inDays;
    
    if (diffDays == 0) {
      return 'This week';
    } else if (diffDays == 7) {
      return 'Last week';
    } else {
      final sunday = monday.add(const Duration(days: 6));
      return '${monday.day}/${monday.month} - ${sunday.day}/${sunday.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statisticProvider);
    final selectedDate = state.selectedDate ?? DateTime.now();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        reverse: true, // "kéo từ trái -> phải -> sẽ hiển thị các tuần trước đó"
        itemCount: _weeks.length,
        itemBuilder: (context, index) {
          final monday = _weeks[index];
          // Compare weeks (start date)
          // Just check if difference is 0 when both are converted to their Monday
          final selectedCurrentDay = selectedDate.weekday;
          final selectedMonday = DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
                .subtract(Duration(days: selectedCurrentDay - 1));
          
          final isSelected = selectedMonday.year == monday.year &&
                selectedMonday.month == monday.month &&
                selectedMonday.day == monday.day;

          return GestureDetector(
            onTap: () {
              ref.read(statisticProvider.notifier).setSelectedDate(monday);
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
                _formatWeek(monday),
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
