import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Shared "big number" amount input with an animated focus ring, a trailing
/// `đ` suffix, an optional uppercase label and an optional helper/error line.
///
/// Extracted from the child set-money-limit dialog so the parent
/// set-child-limit sheet renders an identical field. Manages its own focus
/// state internally (creates a [FocusNode] when one is not supplied).
class AmountInputBox extends StatefulWidget {
  const AmountInputBox({
    super.key,
    required this.controller,
    this.focusNode,
    this.label,
    this.helperText,
    this.hasError = false,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  /// Uppercase field label rendered above the box (pass already-cased text).
  final String? label;

  /// Line rendered below the box; coloured red when [hasError] is true.
  final String? helperText;
  final bool hasError;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  State<AmountInputBox> createState() => _AmountInputBoxState();
}

class _AmountInputBoxState extends State<AmountInputBox> {
  FocusNode? _internalNode;
  bool _hasFocus = false;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_internalNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _internalNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.hasError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.72,
              color: AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.ease,
          constraints: BoxConstraints(minHeight: 80.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: hasError
                ? AppTheme.dangerSurface
                : isDark
                    ? AppTheme.darkSurfaceVariant
                    : AppTheme.surfaceVeryLight,
            border: Border.all(
              color: hasError
                  ? AppTheme.redAlert
                  : _hasFocus
                      ? AppTheme.primary.withValues(alpha: 0.5)
                      : isDark
                          ? AppTheme.borderDark
                          : AppTheme.borderLight,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: hasError
                ? [
                    BoxShadow(
                      spreadRadius: 4.r,
                      color: AppTheme.redAlert.withValues(alpha: 0.12),
                    ),
                  ]
                : _hasFocus
                    ? [
                        BoxShadow(
                          spreadRadius: 4.r,
                          color: AppTheme.primary.withValues(alpha: 0.12),
                        ),
                      ]
                    : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  autofocus: widget.autofocus,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: context.typo.display.small.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: '0',
                    hintStyle: context.typo.display.small.copyWith(
                      color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                      letterSpacing: -0.8,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              Text(
                'đ',
                style: context.typo.subtitle.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        if (widget.helperText != null) ...[
          SizedBox(height: 8.h),
          Text(
            widget.helperText!,
            style: context.typo.caption.big.copyWith(
              color: hasError ? AppTheme.redAlert : AppTheme.textGrey,
              height: 1.45,
            ),
          ),
        ],
      ],
    );
  }
}
