import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget hiển thị độ mạnh của mật khẩu
/// Gồm progress bar, label (Yếu/Trung bình/Mạnh), % và gợi ý
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({Key? key, required this.password})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strength = _calculateStrength(password);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Label + Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                  children: [
                    const TextSpan(text: 'Độ bảo mật: '),
                    TextSpan(
                      text: strength.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: strength.color,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${strength.percentage}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: strength.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: strength.percentage / 100,
              minHeight: 8,
              backgroundColor: isDark
                  ? const Color(0xFF334155)
                  : const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(strength.color),
            ),
          ),
          const SizedBox(height: 12),

          // Hint text
          Text(
            'Gợi ý: Sử dụng kết hợp chữ hoa, chữ thường, số và ký hiệu.',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 0.5,
              color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  _PasswordStrength _calculateStrength(String pwd) {
    if (pwd.isEmpty) {
      return _PasswordStrength(
        label: 'Chưa nhập',
        percentage: 0,
        color: const Color(0xFF94A3B8),
      );
    }

    int score = 0;

    // Chiều dài
    if (pwd.length >= 6) score += 20;
    if (pwd.length >= 8) score += 10;
    if (pwd.length >= 12) score += 10;

    // Chữ thường
    if (pwd.contains(RegExp(r'[a-z]'))) score += 15;

    // Chữ hoa
    if (pwd.contains(RegExp(r'[A-Z]'))) score += 15;

    // Số
    if (pwd.contains(RegExp(r'[0-9]'))) score += 15;

    // Ký tự đặc biệt
    if (pwd.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score += 15;

    score = score.clamp(0, 100);

    if (score < 30) {
      return _PasswordStrength(
        label: 'Yếu',
        percentage: score,
        color: AppTheme.redAlert,
      );
    } else if (score < 60) {
      return _PasswordStrength(
        label: 'Trung bình',
        percentage: score,
        color: AppTheme.orangeWarning,
      );
    } else {
      return _PasswordStrength(
        label: 'Mạnh',
        percentage: score,
        color: AppTheme.primary,
      );
    }
  }
}

class _PasswordStrength {
  final String label;
  final int percentage;
  final Color color;

  _PasswordStrength({
    required this.label,
    required this.percentage,
    required this.color,
  });
}
