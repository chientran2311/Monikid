import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Reusable auth input with animated focus ring, left icon, and optional
/// password visibility toggle. Used across login, register, and forgot-password.
class AuthInputField extends StatefulWidget {
  const AuthInputField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.placeholder,
    this.keyboardType,
    this.showPasswordToggle = false,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final IconData prefixIcon;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool showPasswordToggle;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final String? errorText;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  final _focusNode = FocusNode();
  var _hasFocus = false;
  var _obscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocus);
  }

  void _onFocus() => setState(() => _hasFocus = _focusNode.hasFocus);

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildInput(),
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: Text(
              widget.errorText!,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.captionSmall,
                weight: FontWeight.w500,
                color: AppTheme.redAlert,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInput() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: _hasFocus
              ? AppTheme.primary.withValues(alpha: 0.5)
              : AppTheme.textBlack.withValues(alpha: 0.14),
          width: _hasFocus ? 1.5.r : 1.r,
        ),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  spreadRadius: 4.r,
                  color: AppTheme.primary.withValues(alpha: 0.12),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44.w,
            child: Center(
              child: Icon(widget.prefixIcon, color: AppTheme.primary, size: 18.r),
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.showPasswordToggle && _obscure,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmitted,
              onChanged: widget.onChanged,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.bodyBig,
                weight: FontWeight.w700,
                color: AppTheme.textBlack,
                letterSpacing: -0.01,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: AppTextStyleFactory.style(
                  size: AppFontSizes.bodyBig,
                  weight: FontWeight.w600,
                  color: AppTheme.textGrey.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(right: 14.w),
              ),
            ),
          ),
          if (widget.showPasswordToggle)
            GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: SizedBox(
                width: 46.w,
                height: 46.h,
                child: Center(
                  child: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppTheme.textGrey,
                    size: 20.r,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

