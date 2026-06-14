import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Transparent top app-bar for tab roots (home, statistic), shown over
/// [AppBackground]. Matches HTML `.app-header`: a bold title on the left and an
/// optional trailing action on the right. The bar is transparent — any "glass"
/// effect lives inside [trailing].
///
/// Distinct from [GlassAppBar] in `glass_app_bar.dart`, which is the
/// back-button bar used by pushed detail screens.
class GlassTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassTabAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.titleFontSize = 24,
    this.horizontalPadding = 16,
  });

  /// Title text rendered on the left.
  final String title;

  /// Optional widget rendered on the right (e.g. a glass profile button or pill).
  final Widget? trailing;

  /// Title size in logical px; `.sp` is applied internally.
  final double titleFontSize;

  /// Horizontal padding in logical px; `.w` is applied internally.
  final double horizontalPadding;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: preferredSize.height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HTML `.app-header h1`: fw800, letter-spacing -0.04em, --fg color.
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize.sp,
                fontWeight: FontWeight.w800,
                color: isDark ? AppTheme.darkTextPrimary : AppTheme.homeParFg,
                letterSpacing: -0.04 * titleFontSize,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
