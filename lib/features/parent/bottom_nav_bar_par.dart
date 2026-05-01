import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/home_tab_par.dart';
import 'package:monikid/features/parent/setting/setting_tab_par.dart';
import 'package:monikid/features/parent/statistic/statistic_tab_par.dart';

class ParentBottomNavBar extends HookConsumerWidget {
  const ParentBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentIndex = useState(0);

    const tabs = [HomeTabParent(), StatisticTabParent(), SettingTabParent()];

    final navItems = [
      (Icons.home_rounded, s.navParentHome),
      (Icons.bar_chart_rounded, s.navParentStatistic),
      (Icons.settings_rounded, s.navParentSettings),
    ];

    final unselectedColor =
        isDark ? const Color(0xFF64748B) : AppTheme.textGrey;

    // Glass surface: semi-transparent so blur bleeds through
    final glassColor = isDark
        ? AppTheme.surfaceDark.withValues(alpha: 0.78)
        : Colors.white.withValues(alpha: 0.80);

    final glassBorder = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.white.withValues(alpha: 0.60);

    return Scaffold(
      // Body extends behind floating pill so BackdropFilter has content to blur
      extendBody: true,
      body: IndexedStack(index: currentIndex.value, children: tabs),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                height: 62.h,
                decoration: BoxDecoration(
                  color: glassColor,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: glassBorder, width: 0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(navItems.length, (i) {
                    final isSelected = currentIndex.value == i;
                    final color =
                        isSelected ? AppTheme.primary : unselectedColor;
                    return GestureDetector(
                      onTap: () => currentIndex.value = i,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(navItems[i].$1, color: color, size: 24.r),
                            SizedBox(height: 3.h),
                            Text(
                              navItems[i].$2,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
