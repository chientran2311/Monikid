import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget nhập mã OTP 6 chữ số
/// Tự động chuyển focus sang ô tiếp theo khi nhập xong
/// Hỗ trợ paste toàn bộ mã OTP
class OtpInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;

  const OtpInputField({
    Key? key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    // Auto focus ô đầu tiên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    // Xử lý paste toàn bộ OTP
    if (value.length > 1) {
      final chars = value.split('');
      for (int i = 0; i < chars.length && (index + i) < widget.length; i++) {
        _controllers[index + i].text = chars[i];
      }
      final nextIndex = (index + chars.length).clamp(0, widget.length - 1);
      _focusNodes[nextIndex].requestFocus();
      _checkCompleted();
      return;
    }

    if (value.isNotEmpty && index < widget.length - 1) {
      // Chuyển focus sang ô tiếp theo
      _focusNodes[index + 1].requestFocus();
    }

    widget.onChanged?.call(_otpCode);
    _checkCompleted();
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      // Xóa ô trước đó khi nhấn backspace ở ô trống
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _checkCompleted() {
    final code = _otpCode;
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Tính kích thước mỗi ô dựa trên width khả dụng
        final totalGap = (widget.length - 1) * 8.0;
        final boxWidth = ((constraints.maxWidth - totalGap) / widget.length)
            .clamp(40.0, 56.0);
        final boxHeight = boxWidth * 1.15;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {
            final hasFocus = _focusNodes[index].hasFocus;
            final hasValue = _controllers[index].text.isNotEmpty;

            return SizedBox(
              width: boxWidth,
              height: boxHeight,
              child: KeyboardListener(
                focusNode: FocusNode(), // Wrapper focus node
                onKeyEvent: (event) => _onKeyEvent(index, event),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    counterText: '', // Ẩn counter "0/1"
                    filled: true,
                    fillColor: isDark
                        ? (hasValue
                              ? AppTheme.primary.withOpacity(0.05)
                              : const Color(0xFF1E293B))
                        : (hasValue
                              ? AppTheme.primary.withOpacity(0.05)
                              : const Color(0xFFF8FAFC)),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: hasFocus || hasValue
                            ? AppTheme.primary
                            : (isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFE2E8F0)),
                        width: hasFocus ? 2 : 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: hasValue
                            ? AppTheme.primary
                            : (isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFE2E8F0)),
                        width: hasValue ? 2 : 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppTheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) => _onChanged(index, value),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
