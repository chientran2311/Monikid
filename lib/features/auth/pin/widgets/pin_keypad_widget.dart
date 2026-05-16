import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFilled
                              ? activeColor
                              : (isDark
                                    ? AppTheme.surfaceVariant
                                    : AppTheme.borderLight),
                          border: Border.all(
                            color: isFilled
                                ? activeColor
                                : (isDark
                                      ? AppTheme.borderDark
                                      : AppTheme.borderLight),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ),
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
                  const Expanded(child: SizedBox(height: 64)),
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

  Widget _buildKey(BuildContext context, String value, bool isDark, {IconData? icon}) {
    final bgColor = isDark
        ? const Color(0xFF1E293B).withValues(alpha: 0.5)
        : const Color(0xFFF8FAFC);
    final textColor =
        isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B);

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (widget.isDisabled || widget.isLoading) {
            return;
          }

          if (value == 'backspace') {
            widget.onRemoveNumber();
          } else {
            widget.onAddNumber(value);
          }
        },
        child: SizedBox(
          height: 64,
          child: Center(
            child: icon != null
                ? Icon(icon, size: 28, color: textColor)
                : Text(
                    value,
                    style: context.typo.title.large.copyWith(color: textColor),
                  ),
          ),
        ),
      ),
    );
  }
}
