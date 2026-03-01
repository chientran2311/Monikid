import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget keypad số dùng chung cho tất cả các màn hình PIN.
/// Bao gồm: 6 dot indicators + bàn phím số tùy chỉnh.
class PinKeypadWidget extends StatelessWidget {
  const PinKeypadWidget({
    required this.currentPin,
    required this.onAddNumber,
    required this.onRemoveNumber,
    this.hasError = false,
    this.isLoading = false,
    super.key,
  });

  final String currentPin;
  final void Function(String digit) onAddNumber;
  final VoidCallback onRemoveNumber;
  final bool hasError;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // --- 6 Dot Indicators ---
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final isFilled = index < currentPin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled
                            ? (hasError ? AppTheme.redAlert : AppTheme.primary)
                            : (isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFE2E8F0)),
                        border: Border.all(
                          color: isFilled
                              ? (hasError
                                    ? AppTheme.redAlert
                                    : AppTheme.primary)
                              : (isDark
                                    ? const Color(0xFF334155)
                                    : const Color(0xFFE2E8F0)),
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
        ),

        // --- Numeric Keypad ---
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildRow(context, ['1', '2', '3'], isDark),
              const SizedBox(height: 12),
              _buildRow(context, ['4', '5', '6'], isDark),
              const SizedBox(height: 12),
              _buildRow(context, ['7', '8', '9'], isDark),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SizedBox(height: 64)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildKey(context, '0', isDark)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildKey(
                      context,
                      'backspace',
                      isDark,
                      icon: Icons.backspace_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<String> digits, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildKey(context, digits[0], isDark)),
        const SizedBox(width: 12),
        Expanded(child: _buildKey(context, digits[1], isDark)),
        const SizedBox(width: 12),
        Expanded(child: _buildKey(context, digits[2], isDark)),
      ],
    );
  }

  Widget _buildKey(
    BuildContext context,
    String value,
    bool isDark, {
    IconData? icon,
  }) {
    final bgColor = isDark
        ? const Color(0xFF1E293B).withOpacity(0.5)
        : const Color(0xFFF8FAFC);
    final textColor = isDark
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF1E293B);

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (value == 'backspace') {
            onRemoveNumber();
          } else {
            onAddNumber(value);
          }
        },
        child: SizedBox(
          height: 64,
          child: Center(
            child: icon != null
                ? Icon(icon, size: 28, color: textColor)
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
