import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RoleSelector extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  const RoleSelector({
    Key? key,
    required this.selectedRole,
    required this.onRoleChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(4), // p-1
      decoration: BoxDecoration(
        color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12), // rounded-lg
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onRoleChanged('parent'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8), // py-2
                decoration: BoxDecoration(
                  color: selectedRole == 'parent'
                      ? (isDark ? const Color(0xFF334155) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // rounded-md
                  boxShadow: selectedRole == 'parent'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ]
                      : [],
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
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Phụ huynh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600, // font-semibold
                        color: selectedRole == 'parent'
                            ? (isDark ? Colors.white : const Color(0xFF0F172A))
                            : (isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onRoleChanged('student'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8), // py-2
                decoration: BoxDecoration(
                  color: selectedRole == 'student'
                      ? (isDark ? const Color(0xFF334155) : Colors.white)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // rounded-md
                  boxShadow: selectedRole == 'student'
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 16,
                      color: selectedRole == 'student'
                          ? AppTheme.primary
                          : (isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Học sinh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600, // font-semibold
                        color: selectedRole == 'student'
                            ? (isDark ? Colors.white : const Color(0xFF0F172A))
                            : (isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B)),
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
