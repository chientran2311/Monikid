import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class TransactionFormField extends StatelessWidget {
  const TransactionFormField({
    super.key,
    required this.label,
    required this.value,
    required this.iconOrEmoji,
    required this.iconColor,
    this.showChevron = false,
  });

  final String label;
  final String value;
  final String iconOrEmoji;
  final Color iconColor;
  final bool showChevron;

  bool get _isCalendarIcon =>
      iconOrEmoji == 'calendar' || iconOrEmoji == '📅' || iconOrEmoji == 'ðŸ“…';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w500, color: isDark ? AppTheme.iconLight : AppTheme.borderDark),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.borderDark : const Color(0xFFF1F5F9),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _isCalendarIcon
                      ? Icon(Icons.calendar_today, color: iconColor, size: 20)
                      : Text(iconOrEmoji, style: context.typo.title.medium),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  value,
                  style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w500, color: isDark ? Colors.white : AppTheme.surfaceVeryDark),
                ),
              ),
              if (showChevron)
                const Icon(Icons.chevron_right, color: AppTheme.textMuted),
            ],
          ),
        ),
      ],
    );
  }
}
