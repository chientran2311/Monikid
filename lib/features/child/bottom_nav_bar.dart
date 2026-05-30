import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

import 'package:monikid/features/child/home/home_tab_stu_screen.dart';
import 'package:monikid/features/child/setting/setting_tab_stu.dart';
import 'package:monikid/features/child/statistic/statistic_screen.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_screen.dart';

class StudentBottomNavBar extends StatefulWidget {
  const StudentBottomNavBar({super.key});

  @override
  State<StudentBottomNavBar> createState() => _StudentBottomNavBarState();
}

// SingleTickerProviderStateMixin needed for pulse glow AnimationController on FAB.
class _StudentBottomNavBarState extends State<StudentBottomNavBar>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _ringRadius;
  late final Animation<double> _ringAlpha;

  final _tabs = const [
    HomeTabStudent(),
    TransactionHistoryScreen(),
    StatisticScreen(),
    SettingTabStudent(),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _ringRadius = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: _pulseCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    _ringAlpha = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(
        parent: _pulseCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // HTML: rgba(242,251,242,.88) — light green tint matching the HTML palette.
    final navBgColor = isDark
        ? AppTheme.surfaceDark.withValues(alpha: 0.88)
        : AppTheme.primaryLight.withValues(alpha: 0.88);

    const unselectedColor = AppTheme.textGrey;

    return Scaffold(
      extendBody: true,
      body: LazyLoadIndexedStack(index: _currentIndex, children: _tabs),
      floatingActionButton: AnimatedBuilder(
        animation: _pulseCtrl,
        builder: (context, child) {
          return Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryButtonGradient,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 8.h),
                  blurRadius: 20.r,
                  color: AppTheme.primary.withValues(alpha: 0.24),
                ),
                // Pulse glow ring — spreads outward and fades (mirrors CSS pulseGlow keyframes).
                BoxShadow(
                  spreadRadius: _ringRadius.value,
                  blurRadius: 0,
                  color: AppTheme.primary.withValues(alpha: _ringAlpha.value),
                ),
              ],
            ),
            child: child,
          );
        },
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => context.push(AppRoutes.addTransaction),
            customBorder: const CircleBorder(),
            splashColor: Colors.white.withValues(alpha: 0.18),
            child: Center(
              child: Icon(Icons.add_rounded, size: 32.r, color: AppTheme.textWhite),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: BottomAppBar(
          color: navBgColor,
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
            style: context.typo.caption.small.copyWith(
              color: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
