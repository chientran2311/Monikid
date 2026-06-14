import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionSubmitAction extends StatefulWidget {
  const TransactionSubmitAction({
    super.key,
    required this.label,
    required this.isSubmitting,
    required this.enabled,
    required this.onSubmit,
  });

  final String label;
  final bool isSubmitting;
  final bool enabled;
  final VoidCallback onSubmit;

  @override
  State<TransactionSubmitAction> createState() =>
      _TransactionSubmitActionState();
}

class _TransactionSubmitActionState extends State<TransactionSubmitAction> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    if (widget.enabled) setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    if (widget.enabled) widget.onSubmit();
  }

  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scrimColor =
        isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scrimColor.withValues(alpha: 0),
              scrimColor.withValues(alpha: 0.95),
            ],
            stops: const [0.0, 0.28],
          ),
        ),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: widget.enabled ? 1.0 : 0.6,
              duration: const Duration(milliseconds: 200),
              child: Container(
                height: 58.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppTheme.primary, AppTheme.primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 16.h),
                      blurRadius: 32.r,
                      color: AppTheme.primary.withValues(alpha: 0.25),
                    ),
                  ],
                ),
                child: Center(
                  child: widget.isSubmitting
                      ? SizedBox(
                          width: 22.r,
                          height: 22.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.label,
                          style: AppTextStyleFactory.style(
                            size: AppFontSizes.titleSmall,
                            weight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
