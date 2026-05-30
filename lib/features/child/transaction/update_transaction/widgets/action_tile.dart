import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    this.iconStr,
    this.iconData,
    this.iconBgColor,
    this.iconColor,
    required this.label,
    required this.value,
    required this.isDark,
    required this.surfaceColor,
    required this.enabled,
    this.onTap,
    this.trailingIcon = Icons.chevron_right,
  });

  final String? iconStr;
  final IconData? iconData;
  final Color? iconBgColor;
  final Color? iconColor;
  final String label;
  final String value;
  final bool isDark;
  final Color surfaceColor;
  final bool enabled;
  final VoidCallback? onTap;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: iconStr != null && iconStr!.isNotEmpty
                    ? Text(iconStr!, style: context.typo.title.big)
                    : Icon(iconData, color: iconColor),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.typo.caption.big.copyWith(fontWeight: FontWeight.w500, color: AppTheme.textGrey),
                  ),
                  Text(
                    value,
                    style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.surfaceVeryDark),
                  ),
                ],
              ),
            ),
            Icon(
              trailingIcon,
              color: enabled
                  ? AppTheme.textMuted
                  : AppTheme.iconLight,
            ),
          ],
        ),
      ),
    );
  }
}
