import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/theme/theme.dart';

class PinKeypadWidget extends StatefulWidget {
  const PinKeypadWidget({
    required this.currentPin,
    required this.onAddNumber,
    required this.onRemoveNumber,
    this.hasError = false,
    this.isLoading = false,
    this.isDisabled = false,
    super.key,
  });

  final String currentPin;
  final void Function(String digit) onAddNumber;
  final VoidCallback onRemoveNumber;
  final bool hasError;
  final bool isLoading;
  final bool isDisabled;

  @override
  State<PinKeypadWidget> createState() => _PinKeypadWidgetState();
}

class _PinKeypadWidgetState extends State<PinKeypadWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void didUpdateWidget(covariant PinKeypadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenH = MediaQuery.sizeOf(context).height;
    final dotsVertPad = (screenH * 0.036).clamp(12.0, 52.0);
    final rowGap = (screenH * 0.016).clamp(8.0, 20.0);
    final bottomPad = (screenH * 0.028).clamp(12.0, 40.0);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: dotsVertPad),
          child: AnimatedBuilder(
            animation: _offsetAnimation,
            builder: (context, child) => Transform.translate(
              offset: Offset(_offsetAnimation.value, 0),
              child: child,
            ),
            child: widget.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      final isFilled = index < widget.currentPin.length;
                      final activeColor = widget.hasError
                          ? AppTheme.redAlert
                          : AppTheme.primary;
                      return AnimatedScale(
                        scale: isFilled ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          width: 16.r,
                          height: 16.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled ? activeColor : Colors.transparent,
                            border: Border.all(
                              color: isFilled
                                  ? activeColor
                                  : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
                              width: 2,
                            ),
                            boxShadow: isFilled
                                ? [
                                    BoxShadow(
                                      offset: Offset(0, 4.h),
                                      blurRadius: 12.r,
                                      color: AppTheme.primary.withValues(alpha: 0.3),
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              _buildRow(['1', '2', '3'], isDark),
              SizedBox(height: rowGap),
              _buildRow(['4', '5', '6'], isDark),
              SizedBox(height: rowGap),
              _buildRow(['7', '8', '9'], isDark),
              SizedBox(height: rowGap),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  SizedBox(width: 24.w),
                  Expanded(child: _KeyButton(value: '0', isDark: isDark, onTap: _canInput ? () => widget.onAddNumber('0') : null)),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: _KeyButton(
                      value: 'backspace',
                      isDark: isDark,
                      icon: Icons.backspace_outlined,
                      onTap: _canInput ? widget.onRemoveNumber : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: bottomPad),
            ],
          ),
        ),
      ],
    );
  }

  bool get _canInput => !widget.isDisabled && !widget.isLoading;

  Widget _buildRow(List<String> digits, bool isDark) {
    return Row(
      children: [
        Expanded(child: _KeyButton(value: digits[0], isDark: isDark, onTap: _canInput ? () => widget.onAddNumber(digits[0]) : null)),
        SizedBox(width: 24.w),
        Expanded(child: _KeyButton(value: digits[1], isDark: isDark, onTap: _canInput ? () => widget.onAddNumber(digits[1]) : null)),
        SizedBox(width: 24.w),
        Expanded(child: _KeyButton(value: digits[2], isDark: isDark, onTap: _canInput ? () => widget.onAddNumber(digits[2]) : null)),
      ],
    );
  }
}

const _kKeyLetters = {
  '2': 'ABC', '3': 'DEF', '4': 'GHI', '5': 'JKL',
  '6': 'MNO', '7': 'PQRS', '8': 'TUV', '9': 'WXYZ',
};

class _KeyButton extends StatefulWidget {
  const _KeyButton({
    required this.value,
    required this.isDark,
    required this.onTap,
    this.icon,
  });

  final String value;
  final bool isDark;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  State<_KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<_KeyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final digitColor = widget.isDark ? AppTheme.surfaceLightGrey : AppTheme.textBlack;
    final letters = _kKeyLetters[widget.value];
    final keyH = (MediaQuery.sizeOf(context).height * 0.09).clamp(48.0, 88.0);

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.onTap != null
          ? (_) {
              setState(() => _pressed = false);
              widget.onTap!();
            }
          : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: keyH,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pressed
                ? (widget.isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLightGrey)
                : Colors.transparent,
          ),
          child: Center(
            child: widget.icon != null
                ? Icon(widget.icon, size: keyH * 0.46, color: widget.isDark ? AppTheme.textGrey : AppTheme.textBlack)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.value,
                        style: AppTextStyleFactory.style(
                          size: (keyH * 0.46).clamp(22.0, 32.0),
                          weight: FontWeight.w500,
                          color: digitColor,
                        ),
                      ),
                      if (letters != null)
                        Text(
                          letters,
                          style: AppTextStyleFactory.style(
                            size: AppFontSizes.labelSmall,
                            weight: FontWeight.w600,
                            color: AppTheme.textGrey,
                            letterSpacing: 0.1 * AppFontSizes.labelSmall,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
