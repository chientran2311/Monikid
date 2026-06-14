import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared currency amount input.
///
/// Captures the pattern common to the app's limit/amount setters: numeric
/// keyboard, digits-only, `'0'` hint and a trailing `đ` suffix. Visual details
/// (text style, alignment, label, border) are passed per call site so it adapts
/// without forking.
///
/// Note: amount fields that render `đ` *outside* the input (as a sibling
/// `Text`/prefix inside a custom container) keep their own layout — see
/// `transaction_amount_section.dart` and `set_money_limit_dialog.dart`.
class AppAmountField extends StatelessWidget {
  const AppAmountField({
    super.key,
    required this.controller,
    required this.textStyle,
    this.focusNode,
    this.hintStyle,
    this.suffixStyle,
    this.suffixText = 'đ',
    this.labelText,
    this.textAlign = TextAlign.center,
    this.bordered = false,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextStyle textStyle;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final String suffixText;
  final String? labelText;
  final TextAlign textAlign;

  /// When false, removes all borders (clean display style). When true, keeps
  /// the default underline decoration.
  final bool bordered;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      textAlign: textAlign,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: textStyle,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        hintText: '0',
        hintStyle: hintStyle,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        labelText: labelText,
        border: bordered ? null : InputBorder.none,
        enabledBorder: bordered ? null : InputBorder.none,
        focusedBorder: bordered ? null : InputBorder.none,
        disabledBorder: bordered ? null : InputBorder.none,
      ),
    );
  }
}
