import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Visual variant for [AppTextField].
/// - [outlined]: filled box with rounded border (turns red on error).
/// - [borderless]: no border, used inside cards/sheets that draw their own box.
enum AppTextFieldStyle { outlined, borderless }

/// Unified single-line / multiline text input for the whole app.
///
/// Replaces the many ad-hoc `TextField` declarations scattered across screens.
/// Specialized inputs (OTP cells, currency amount, auth animated ring) keep
/// their own widgets — see `otp_input_row.dart`, `app_amount_field.dart`,
/// `auth_input_field.dart`.
///
/// Vietnamese (Telex) input is safe: when [maxLength] is set we apply a
/// [LengthLimitingTextInputFormatter] with
/// [MaxLengthEnforcement.truncateAfterCompositionEnds] so the IME composing
/// region (diacritics) is never cut mid-composition.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscurable = false,
    this.enabled = true,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.suffix,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.style = AppTextFieldStyle.outlined,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int minLines;
  final int maxLines;

  /// When true, masks the text and shows an eye toggle as the suffix.
  final bool obscurable;
  final bool enabled;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;

  /// Leading widget (icon/emoji). Maps to [InputDecoration.prefixIcon].
  final Widget? prefix;

  /// Trailing widget. Ignored when [obscurable] is true (replaced by the eye).
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final AppTextFieldStyle style;

  /// Optional overrides — when null, theme defaults are used.
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscurable;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isMultiline = widget.maxLines > 1;

    // Vietnamese-safe length limiting: never set a bare `maxLength` on the
    // inner TextField — its default formatter cuts the IME composing region.
    final formatters = <TextInputFormatter>[
      if (widget.inputFormatters != null) ...widget.inputFormatters!,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType ??
              (isMultiline ? TextInputType.multiline : null),
          inputFormatters: formatters.isEmpty ? null : formatters,
          minLines: widget.minLines,
          maxLines: widget.obscurable ? 1 : widget.maxLines,
          obscureText: widget.obscurable && _obscured,
          textCapitalization: widget.textCapitalization,
          textAlign: widget.textAlign,
          textAlignVertical:
              isMultiline ? TextAlignVertical.top : TextAlignVertical.center,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          style: widget.textStyle ??
              context.typo.body.big.copyWith(color: textColor),
          decoration: _decoration(context, isDark: isDark, hasError: hasError),
        ),
        if (hasError) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: Text(
              widget.errorText!,
              style: context.typo.caption.big.copyWith(color: AppTheme.redAlert),
            ),
          ),
        ],
      ],
    );
  }

  InputDecoration _decoration(
    BuildContext context, {
    required bool isDark,
    required bool hasError,
  }) {
    final isMultiline = widget.maxLines > 1;
    final hint = widget.hintText;

    final base = InputDecoration(
      hintText: hint,
      hintStyle: widget.hintStyle ??
          context.typo.body.big.copyWith(color: AppTheme.textMuted),
      counterText: '',
      isDense: widget.style == AppTextFieldStyle.borderless,
      prefixIcon: widget.prefix,
      suffixIcon: _buildSuffix(),
    );

    if (widget.style == AppTextFieldStyle.borderless) {
      return base.copyWith(
        filled: false,
        contentPadding: widget.contentPadding ?? EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      );
    }

    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: color, width: width),
        );

    return base.copyWith(
      filled: true,
      fillColor: isDark ? AppTheme.surfaceDark : AppTheme.backgroundLight,
      contentPadding: widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: isMultiline ? 14.h : 17.h,
          ),
      enabledBorder: border(
        hasError
            ? AppTheme.redAlert
            : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
        hasError ? 1.5 : 1,
      ),
      focusedBorder: border(
        hasError ? AppTheme.redAlert : AppTheme.primary,
        1.5,
      ),
      errorBorder: border(AppTheme.redAlert, 1.5),
      focusedErrorBorder: border(AppTheme.redAlert, 1.5),
    );
  }

  Widget? _buildSuffix() {
    if (widget.obscurable) {
      return GestureDetector(
        onTap: () => setState(() => _obscured = !_obscured),
        child: Icon(
          _obscured
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppTheme.textGrey,
          size: 20.r,
        ),
      );
    }
    return widget.suffix;
  }
}
