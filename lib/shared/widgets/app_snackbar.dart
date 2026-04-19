import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';

/// Loại SnackBar — khớp với design trong snackbars.html
enum SnackBarType { success, error, warning, info }

/// AppSnackBar — Hệ thống thông báo toast
/// Design: icon + message + close button (circle), có animation slide-up
/// Colors: success=#2E7D32, error=#D32F2F, warning=#FFA000, info=#1976D2
class AppSnackBar {
  AppSnackBar._();

  // Màu sắc theo design HTML
  static const _colors = {
    SnackBarType.success: Color(0xFF2E7D32),
    SnackBarType.error: Color(0xFFD32F2F),
    SnackBarType.warning: Color(0xFFFFA000),
    SnackBarType.info: Color(0xFF1976D2),
  };

  // Icons theo design HTML
  static const _icons = {
    SnackBarType.success: Icons.check_circle,
    SnackBarType.error: Icons.cancel,
    SnackBarType.warning: Icons.report_problem,
    SnackBarType.info: Icons.sync,
  };

  /// Hiện snackbar
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final bgColor = _colors[type]!;
    final icon = _icons[type]!;
    final textColor = type == SnackBarType.warning
        ? const Color(0xFF1E293B)
        : Colors.white;
    final closeColor = type == SnackBarType.warning
        ? const Color(0xFF1E293B).withOpacity(0.6)
        : Colors.white.withOpacity(0.7);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            // Icon — info type có animation xoay
            if (type == SnackBarType.info)
              _SpinningIcon(icon: icon, color: textColor)
            else
              Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 12),
            // Message
            Expanded(
              child: Text(
                message,
                style: context.typo.label.large.copyWith(
                  color: textColor,
                ),
              ),
            ),
            // Action button (nếu có)
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onAction();
                },
                child: Text(
                  actionLabel,
                  style: context.typo.title.small.copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            // Close button — circle, cùng row
            SizedBox(
              width: 28,
              height: 28,
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: closeColor.withOpacity(0.15),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.close, color: closeColor, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        elevation: 8,
        duration: duration,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  // === Shortcut methods ===

  /// ✅ Thành công
  static void success(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.success);
  }

  /// ❌ Lỗi
  static void error(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.error);
  }

  /// ⚠️ Cảnh báo
  static void warning(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.warning);
  }

  /// ℹ️ Info / Loading
  static void info(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.info);
  }
}

/// Spinning icon widget cho Info/Loading type
class _SpinningIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  const _SpinningIcon({required this.icon, required this.color});

  @override
  State<_SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<_SpinningIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(widget.icon, color: widget.color, size: 22),
    );
  }
}
