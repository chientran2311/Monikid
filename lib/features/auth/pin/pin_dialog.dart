import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/pin/pin_dialog_provider.dart';
import 'package:monikid/features/auth/pin/pin_dialog_state.dart';

/// App-level helper method to trigger the PIN Dialog check
Future<bool> showPinDialogIfNeeded(BuildContext context, WidgetRef ref) async {
  final notifier = ref.read(pinDialogNotifierProvider.notifier);
  final needsDialog = await notifier.initialize();

  if (needsDialog && context.mounted) {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45, // Tương đương bg-slate-900/40
      builder: (_) => const PinDialog(),
    );
    return result ?? false;
  }
  return true;
}

class PinDialog extends ConsumerStatefulWidget {
  const PinDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends ConsumerState<PinDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pinDialogNotifierProvider);
    final notifier = ref.read(pinDialogNotifierProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Lắng nghe trạng thái success & error
    ref.listen<PinDialogState>(pinDialogNotifierProvider, (previous, next) {
      if (next.isSuccess && (previous == null || !previous.isSuccess)) {
        Navigator.of(context).pop(true);
      }
      if (next.hasError && (previous == null || !previous.hasError)) {
        _shakeController.forward(from: 0.0);
      }
    });

    String title;
    String description;
    if (state.mode == PinDialogMode.verify) {
      title = "Xác nhận mã PIN";
      description = "Vui lòng nhập mã PIN 6 chữ số để tiếp tục giao dịch.";
    } else {
      if (state.isConfirming) {
        title = "Xác nhận lại mã PIN";
        description = "Nhập lại mã PIN vừa tạo để đảm bảo độ chính xác.";
      } else {
        title = "Tạo mã PIN mới";
        description = "Tạo mã PIN 6 chữ số để bảo mật tài khoản CỦA BẠN.";
      }
    }

    final offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 0), weight: 1),
    ]).animate(_shakeController);

    return PopScope(
      canPop: false, // Ngăn chặn nút Back Android vật lý và vuốt cạnh màn hình
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 384),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(16), // rounded-xl
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
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
                        Icons.lock_rounded, // Tương ứng text-primary
                        color: AppTheme.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope', // Dựa theo HTML
                        fontSize: 20, // text-xl
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFF1F5F9)
                            : const Color(0xFF0F172A),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
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

              // PIN Display Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AnimatedBuilder(
                  animation: offsetAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(offsetAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primary,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            final isFilled = index < state.currentPin.length;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 14, // Same as .pin-dot in HTML
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFilled
                                    ? (state.hasError
                                          ? AppTheme.redAlert
                                          : AppTheme.primary)
                                    : (isDark
                                          ? const Color(0xFF1E293B)
                                          : const Color(0xFFE2E8F0)),
                                border: Border.all(
                                  color: isFilled
                                      ? (state.hasError
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

              // Custom Numeric Keypad
              Padding(
                padding: const EdgeInsets.all(24), // px-6 py-6
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKey('1', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('2', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('3', notifier, isDark),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKey('4', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('5', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('6', notifier, isDark),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKey('7', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('8', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey('9', notifier, isDark),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: const SizedBox(height: 64),
                        ), // Empty spacer h-16
                        const SizedBox(width: 12),
                        _buildKey('0', notifier, isDark),
                        const SizedBox(width: 12),
                        _buildKey(
                          'backspace',
                          notifier,
                          isDark,
                          icon: Icons.backspace_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Visual indicator for secure context
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
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
                      'KẾT NỐI BẢO MẬT BỞI SMARTSPENDING',
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
          ),
        ),
      ),
    );
  }

  Widget _buildKey(
    String value,
    PinDialogNotifier notifier,
    bool isDark, {
    IconData? icon,
  }) {
    // text-slate-800 bg-slate-50 // text-slate-100 bg-slate-800/50
    final bgColor = isDark
        ? const Color(0xFF1E293B).withOpacity(0.5)
        : const Color(0xFFF8FAFC);
    final textColor = isDark
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF1E293B);

    return Expanded(
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(8), // rounded-lg
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            if (value == 'backspace') {
              notifier.removeNumber();
            } else {
              notifier.addNumber(value);
            }
          },
          child: SizedBox(
            height: 64, // h-16
            child: Center(
              child: icon != null
                  ? Icon(icon, size: 28, color: textColor)
                  : Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 24, // text-2xl
                        fontWeight: FontWeight.w600, // font-semibold
                        color: textColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
