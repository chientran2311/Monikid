import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class RoleSelector extends StatelessWidget {
  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onRoleChanged('parent'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selectedRole == 'parent'
                      ? (isDark ? AppTheme.borderDark : AppTheme.surfaceLight)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: selectedRole == 'parent'
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                          ),
                        ]
                      : const [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.family_restroom,
                      size: 16,
                      color: selectedRole == 'parent'
                          ? AppTheme.primary
                          : (isDark
                                ? AppTheme.textMuted
                                : AppTheme.textGrey),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Phá»¥ huynh',
                      style: context.typo.subtitle.small.copyWith(
                        color: selectedRole == 'parent'
                            ? (isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark)
                            : (isDark
                                  ? AppTheme.textMuted
                                  : AppTheme.textGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onRoleChanged('child'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selectedRole == 'child'
                      ? (isDark ? AppTheme.borderDark : AppTheme.surfaceLight)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: selectedRole == 'child'
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                          ),
                        ]
                      : const [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 16,
                      color: selectedRole == 'child'
                          ? AppTheme.primary
                          : (isDark
                                ? AppTheme.textMuted
                                : AppTheme.textGrey),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Há»c sinh',
                      style: context.typo.subtitle.small.copyWith(
                        color: selectedRole == 'child'
                            ? (isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark)
                            : (isDark
                                  ? AppTheme.textMuted
                                  : AppTheme.textGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
