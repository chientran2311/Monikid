import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// A row of [length] single-digit OTP input cells.
///
/// Handles auto-advance on digit entry, back-navigation on backspace,
/// and multi-digit paste. Expose via [GlobalKey<OtpInputRowState>] to
/// call [clear] from a parent widget.
class OtpInputRow extends StatefulWidget {
  const OtpInputRow({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.enabled = true,
    this.length = 6,
  });

  final void Function(String otp) onCompleted;
  final void Function(String otp)? onChanged;
  final bool enabled;
  final int length;

  @override
  State<OtpInputRow> createState() => OtpInputRowState();
}

class OtpInputRowState extends State<OtpInputRow> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    if (mounted) _focusNodes.first.requestFocus();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _handleChanged(int index, String value) {
    if (value.isEmpty) {
      widget.onChanged?.call(_otp);
      return;
    }
    final digit = value.replaceAll(RegExp(r'\D'), '');
    if (digit.isEmpty) {
      _controllers[index].clear();
      widget.onChanged?.call(_otp);
      return;
    }
    _controllers[index].text = digit[0];
    _controllers[index].selection = const TextSelection.collapsed(offset: 1);
    widget.onChanged?.call(_otp);
    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else {
      final otp = _otp;
      if (otp.length == widget.length) widget.onCompleted(otp);
    }
  }

  void _handlePaste(int startIndex, String text) {
    final digits = text.replaceAll(RegExp(r'\D'), '');
    final count = digits.length.clamp(0, widget.length - startIndex);
    for (var i = 0; i < count; i++) {
      _controllers[startIndex + i].text = digits[i];
    }
    final nextIndex = (startIndex + count).clamp(0, widget.length - 1);
    _focusNodes[nextIndex].requestFocus();
    final otp = _otp;
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) widget.onCompleted(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.length; i++) ...[
          if (i > 0) SizedBox(width: 10.w),
          Expanded(
            child: _OtpCell(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              enabled: widget.enabled,
              onChanged: (v) => _handleChanged(i, v),
              onBackspaceFromEmpty:
                  i > 0 ? () => _focusNodes[i - 1].requestFocus() : null,
              onPaste: (text) => _handlePaste(i, text),
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Single cell
// ─────────────────────────────────────────────

class _OtpCell extends StatefulWidget {
  const _OtpCell({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.onChanged,
    this.onBackspaceFromEmpty,
    required this.onPaste,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final void Function(String) onChanged;
  final VoidCallback? onBackspaceFromEmpty;
  final void Function(String) onPaste;

  @override
  State<_OtpCell> createState() => _OtpCellState();
}

class _OtpCellState extends State<_OtpCell> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) setState(() => _hasFocus = widget.focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasFocus
        ? AppTheme.primary.withValues(alpha: 0.6)
        : AppTheme.textBlack.withValues(alpha: 0.2);

    return Container(
      height: 58.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: borderColor,
          width: _hasFocus ? 1.5 : 1.0,
        ),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 3.5.r,
                  color: AppTheme.primary.withValues(alpha: 0.14),
                ),
              ]
            : null,
      ),
      child: Focus(
        onKeyEvent: (_, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              widget.controller.text.isEmpty) {
            widget.onBackspaceFromEmpty?.call();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          maxLines: 1,
          inputFormatters: [
            _OtpPasteFormatter(widget.onPaste),
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: AppTextStyleFactory.style(
            size: AppFontSizes.titleBig,
            weight: FontWeight.w900,
            color: AppTheme.textBlack,
            letterSpacing: -0.02,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            isCollapsed: true,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Paste formatter — intercepts multi-char input
// ─────────────────────────────────────────────

class _OtpPasteFormatter extends TextInputFormatter {
  const _OtpPasteFormatter(this.onPaste);
  final void Function(String) onPaste;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > 1) {
      onPaste(newValue.text);
      return oldValue;
    }
    return newValue;
  }
}
