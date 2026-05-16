import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

// Import Tabs
import 'package:monikid/features/child/home/home_tab_stu_screen.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_screen.dart';
import 'package:monikid/features/child/statistic/statistic_screen.dart';
import 'package:monikid/features/child/setting/setting_tab_stu.dart';

class StudentBottomNavBar extends StatefulWidget {
  const StudentBottomNavBar({super.key});

  @override
  State<StudentBottomNavBar> createState() => _StudentBottomNavBarState();
}

class _StudentBottomNavBarState extends State<StudentBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTabStudent(),
    const TransactionHistoryScreen(),
    const StatisticScreen(),
    const SettingTabStudent(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final glassColor = isDark
        ? AppTheme.surfaceDark.withValues(alpha: 0.78)
        : AppTheme.surfaceLight.withValues(alpha: 0.80);

    final unselectedColor = AppTheme.textGrey;

    return Scaffold(
      extendBody: true,
      body: LazyLoadIndexedStack(index: _currentIndex, children: _tabs),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.addTransaction),
          backgroundColor: AppTheme.primary,
          shape: const CircleBorder(),
          elevation: 0,
          child: Icon(
            Icons.add_rounded,
            size: 42.r,
            color: AppTheme.textWhite,
            weight: 700,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: BottomAppBar(
            color: glassColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            height: 64.h,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildNavItem(0, Icons.home_rounded, s.navChildHome, unselectedColor),
                    SizedBox(width: 28.w),
                    _buildNavItem(1, Icons.receipt_long_rounded, s.navChildTransactions, unselectedColor),
                  ],
                ),
                Row(
                  children: [
                    _buildNavItem(2, Icons.bar_chart_rounded, s.navChildStatistic, unselectedColor),
                    SizedBox(width: 28.w),
                    _buildNavItem(3, Icons.settings_rounded, s.navChildSettings, unselectedColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    Color unselectedColor,
  ) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppTheme.primary : unselectedColor;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24.r),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
