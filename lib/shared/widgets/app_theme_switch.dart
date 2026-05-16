import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Smooth theme toggle switch with sun/moon icons
/// 
/// Usage:
/// ```dart
/// AppThemeSwitch(
///   isDark: isDarkMode,
///   onChanged: (value) => toggleTheme(value),
/// )
/// ```
class AppThemeSwitch extends StatelessWidget {
  const AppThemeSwitch({
    super.key,
    required this.isDark,
    this.onChanged,
    this.showLabels = false,
  });

  /// Current theme mode - true for dark, false for light
  final bool isDark;
  
  /// Callback when switch is toggled
  final ValueChanged<bool>? onChanged;
  
  /// Whether to show "Light"/"Dark" text labels next to icons
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sun icon (light mode)
        AnimatedOpacity(
          opacity: isDark ? 0.4 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.light_mode_outlined,
            size: 20.r,
            color: isDark 
                ? const Color(0xFF94A3B8) 
                : const Color(0xFFFFA500),
          ),
        ),
        SizedBox(width: 8.w),
        
        // Smooth switch
        Transform.scale(
          scale: 0.85,
          child: CupertinoSwitch(
            value: isDark,
            onChanged: onChanged,
            activeTrackColor: AppTheme.primary,
            inactiveTrackColor: const Color(0xFFE5E5EA),
          ),
        ),
        
        SizedBox(width: 8.w),
        
        // Moon icon (dark mode)
        AnimatedOpacity(
          opacity: isDark ? 1.0 : 0.4,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.dark_mode_outlined,
            size: 20.r,
            color: isDark 
                ? AppTheme.primary 
                : const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}
