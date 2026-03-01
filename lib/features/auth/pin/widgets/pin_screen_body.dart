import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget Body dùng chung cho tất cả màn hình PIN (tạo mới, nhập lại, xác thực).
/// UI đồng nhất với PinDialog: lock icon → 6 dots (có shake) → keypad → security footer.
class PinScreenBody extends StatefulWidget {
  const PinScreenBody({
    required this.title,
    required this.description,
    required this.currentPin,
    required this.onAddNumber,
    required this.onRemoveNumber,
    this.hasError = false,
    this.isLoading = false,
    super.key,
  });

  final String title;
  final String description;
  final String currentPin;
  final void Function(String digit) onAddNumber;
  final VoidCallback onRemoveNumber;
  final bool hasError;
  final bool isLoading;

  @override
  State<PinScreenBody> createState() => _PinScreenBodyState();
}

class _PinScreenBodyState extends State<PinScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void didUpdateWidget(PinScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Khi hasError chuyển thành true, chạy animation lắc
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward(from: 0.0);
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header: Lock icon + Title + Description ──────────────────
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: AppTheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? const Color(0xFFF1F5F9)
                      : const Color(0xFF0F172A),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 14,
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),

        // ── 6 Dots với Shake Animation ────────────────────────────────
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
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFilled
                              ? (widget.hasError
                                    ? AppTheme.redAlert
                                    : AppTheme.primary)
                              : (isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFE2E8F0)),
                          border: Border.all(
                            color: isFilled
                                ? (widget.hasError
                                      ? AppTheme.redAlert
                                      : AppTheme.primary)
                                : (isDark
                                      ? const Color(0xFF334155)
                                      : const Color(0xFFE2E8F0)),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ),

        // ── Keypad ────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildRow(['1', '2', '3'], isDark),
              const SizedBox(height: 12),
              _buildRow(['4', '5', '6'], isDark),
              const SizedBox(height: 12),
              _buildRow(['7', '8', '9'], isDark),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: SizedBox(height: 64)),
                  const SizedBox(width: 12),
                  _buildKey('0', isDark),
                  const SizedBox(width: 12),
                  _buildKey(
                    'backspace',
                    isDark,
                    icon: Icons.backspace_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Security Footer ───────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          color: AppTheme.primary.withOpacity(isDark ? 0.1 : 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_rounded,
                color: AppTheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'KẾT NỐI BẢO MẬT BỞI MONIKID',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppTheme.primary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(List<String> digits, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildKey(digits[0], isDark),
        const SizedBox(width: 12),
        _buildKey(digits[1], isDark),
        const SizedBox(width: 12),
        _buildKey(digits[2], isDark),
      ],
    );
  }

  Widget _buildKey(String value, bool isDark, {IconData? icon}) {
    final bgColor = isDark
        ? const Color(0xFF1E293B).withOpacity(0.5)
        : const Color(0xFFF8FAFC);
    final textColor = isDark
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF1E293B);

    return Expanded(
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            if (value == 'backspace') {
              onRemoveNumber();
            } else {
              onAddNumber(value);
            }
          },
          child: SizedBox(
            height: 64,
            child: Center(
              child: icon != null
                  ? Icon(icon, size: 28, color: textColor)
                  : Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void onAddNumber(String digit) => widget.onAddNumber(digit);
  void onRemoveNumber() => widget.onRemoveNumber();
}
