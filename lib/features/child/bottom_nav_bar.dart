import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/service/notification_tap_intent.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

import 'package:monikid/features/child/home/home_tab_stu_screen.dart';
import 'package:monikid/features/child/setting/setting_tab_stu.dart';
import 'package:monikid/features/child/statistic/statistic_screen.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_screen.dart';
import 'package:monikid/features/notification_settings/notification_nav_provider.dart';

class StudentBottomNavBar extends ConsumerStatefulWidget {
  const StudentBottomNavBar({super.key});

  @override
  ConsumerState<StudentBottomNavBar> createState() => _StudentBottomNavBarState();
}

// SingleTickerProviderStateMixin needed for pulse glow AnimationController on FAB.
class _StudentBottomNavBarState extends ConsumerState<StudentBottomNavBar>
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

    // Notification tap → switch to the Statistic tab (own data, no select).
    // Done in a post-frame callback so we never modify a provider during build.
    final navIntent = ref.watch(notificationNavProvider);
    if (navIntent?.target == NotificationTarget.childStat) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_currentIndex != 2) setState(() => _currentIndex = 2);
        ref.read(notificationNavProvider.notifier).clear();
      });
    }

    // HTML: rgba(242,251,242,.88) — light green tint matching the HTML palette.
    final navBgColor = isDark
        ? AppTheme.surfaceDark.withValues(alpha: 0.88)
        : AppTheme.primaryLight.withValues(alpha: 0.88);

    const unselectedColor = AppTheme.textGrey;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            // Main shadow for depth
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.70)
                  : Colors.black.withValues(alpha: 0.18),
              blurRadius: 32.r,
              spreadRadius: 0,
              offset: Offset(0, -8.h),
            ),
            // Secondary glow shadow
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: isDark ? 0.12 : 0.15),
              blurRadius: 24.r,
              spreadRadius: -4.r,
              offset: Offset(0, -4.h),
            ),
          ],
        ),
        child: ClipPath(
          clipper: _BottomNavClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: BottomAppBar(
              color: navBgColor,
              shape: const _SmoothNotchedShape(),
              notchMargin: 12.0,
              height: 72.h,
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

// U-notch with smooth shoulders — no sharp peaks.
//
// Root cause of sharp peaks: placing the arc junction exactly at host.top forces
// the G1 control point to be *above* host.top, which gets widget-clipped → kink.
//
// Fix: offset the arc start/end 22° below the bar top (still on the FAB circle).
// This lets both shoulder beziers stay entirely *within* the visible bar area,
// so the smooth curve is never clipped, and the junction is visually seamless.
//
// Math check (r = FAB_radius + notchMargin, θ = 22°):
//   aLeft.y  = top + r·sin22 ≈ top + 0.375r  (below bar top ✓)
//   lcp2.y   = aLeft.y − arm·cos22  =  top + 0.375r − 0.32r·0.927
//            ≈ top + 0.078r                   (still below bar top ✓, no clip)
class _SmoothNotchedShape extends NotchedShape {
  const _SmoothNotchedShape();

  // Pre-computed for θ = 22°
  static const _cos22 = 0.9272;
  static const _sin22 = 0.3746;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final r = guest.width / 2.0; // already includes notchMargin
    final cx = guest.center.dx;
    final sw = r * 0.60; // horizontal shoulder width

    // Arc start/end: 22° below the bar's top edge, still on the FAB circle.
    final aLeft = Offset(cx - r * _cos22, host.top + r * _sin22);
    final aRight = Offset(cx + r * _cos22, host.top + r * _sin22);

    // arm chosen so that cp2.y = aLeft.y − arm·cos22 > host.top (stays visible).
    // arm·cos22 < r·sin22  →  arm < 0.404r  →  use 0.32r.
    final arm = r * 0.32;

    // G1 control points: back-project along the arc tangent at each junction.
    // Arc tangent at aLeft (going downward on FAB circle) ≈ (sin22, cos22).
    final lcp2 = Offset(aLeft.dx - arm * _sin22, aLeft.dy - arm * _cos22);
    final rcp1 = Offset(aRight.dx + arm * _sin22, aRight.dy - arm * _cos22);

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(aLeft.dx - sw, host.top)
      // Left shoulder: starts horizontal on flat bar, curves smoothly into arc.
      ..cubicTo(
        aLeft.dx - sw * 0.35, host.top, // cp1: horizontal pull
        lcp2.dx, lcp2.dy,               // cp2: G1 tangent match at aLeft
        aLeft.dx, aLeft.dy,             // arc start (22° into the bar)
      )
      // FAB arc: 136° arc going DOWN through the notch bottom.
      // clockwise:false = right-hand side of rightward travel = below chord = DOWN ✓
      ..arcToPoint(aRight, radius: Radius.circular(r), clockwise: false)
      // Right shoulder: mirrors left — curves smoothly out of arc to flat bar.
      ..cubicTo(
        rcp1.dx, rcp1.dy,                // cp1: G1 tangent match at aRight
        aRight.dx + sw * 0.35, host.top, // cp2: horizontal pull
        aRight.dx + sw, host.top,         // shoulder end on flat bar
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

// Custom clipper that follows the same notched shape for glass effect clipping.
class _BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
