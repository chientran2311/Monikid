import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget đếm ngược thời gian gửi lại OTP
/// Hiển thị icon schedule + text countdown
/// Khi hết thời gian gọi onFinished callback
class CountdownTimer extends StatefulWidget {
  final int durationSeconds;
  final VoidCallback? onFinished;
  final VoidCallback? onResend;

  const CountdownTimer({
    Key? key,
    this.durationSeconds = 60,
    this.onFinished,
    this.onResend,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late int _remaining;
  Timer? _timer;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.durationSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining > 0) {
        setState(() => _remaining--);
      } else {
        timer.cancel();
        setState(() => _isFinished = true);
        widget.onFinished?.call();
      }
    });
  }

  /// Restart lại countdown (gọi từ bên ngoài hoặc khi nhấn "Gửi lại")
  void restart() {
    _timer?.cancel();
    setState(() {
      _remaining = widget.durationSeconds;
      _isFinished = false;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isFinished) {
      return GestureDetector(
        onTap: () {
          widget.onResend?.call();
          restart();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, size: 16, color: AppTheme.primary),
            const SizedBox(width: 6),
            Text(
              'Gửi lại mã',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule_rounded,
          size: 16,
          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8),
        ),
        const SizedBox(width: 6),
        Text(
          'Gửi lại mã sau ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
        Text(
          '${_remaining}s',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }
}
