import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'widgets/otp_input_field.dart';
import 'widgets/countdown_timer.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String? email;

  const OtpScreen({Key? key, this.email}) : super(key: key);

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  String _otpCode = '';
  bool _isLoading = false;
  String? _errorMessage;
  final GlobalKey<CountdownTimerState> _countdownKey =
      GlobalKey<CountdownTimerState>();

  void _handleVerify() {
    if (_otpCode.length < 6) {
      setState(() => _errorMessage = 'Vui lòng nhập đủ 6 chữ số');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    // TODO: Phase B — Gọi authProvider.verifyOtp(email, otp)
    // Tạm thời navigate sang UpdatePassword screen để test flow UI
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.push(AppRoutes.updatePassword);
      }
    });
  }

  void _handleResend() {
    // TODO: Phase B — Gọi lại authProvider.resetPassword(email)
    setState(() => _errorMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maskedEmail = _maskEmail(widget.email ?? '');

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar / Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(
                                0xFFF1F5F9,
                              ), // hover:bg-slate-100 / 800 roughly
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        size: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8), // pt-4 roughly
                    // Title
                    Text(
                      'Xác thực mã OTP',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32, // text-[32px]
                        fontWeight: FontWeight
                            .w800, // font-bold mapping to 800 in design
                        letterSpacing: -0.5, // tracking-tight
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        height: 1.25, // leading-tight
                      ),
                    ),
                    const SizedBox(height: 12), // mt-3
                    // Description
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16, // text-base
                          fontWeight: FontWeight.w400, // font-normal
                          height: 1.6, // leading-relaxed
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF475569), // text-slate-600
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'Chúng tôi đã gửi mã 6 chữ số đến email của bạn.\n',
                          ),
                          if (maskedEmail.isNotEmpty) ...[
                            TextSpan(
                              text: maskedEmail,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                            const TextSpan(text: '.\n'),
                          ],
                          const TextSpan(text: 'Vui lòng nhập mã để tiếp tục.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40), // py-10 roughly (40px)
                    // OTP Input
                    OtpInputField(
                      onCompleted: (code) {
                        setState(() => _otpCode = code);
                      },
                      onChanged: (code) {
                        setState(() {
                          _otpCode = code;
                          _errorMessage = null;
                        });
                      },
                    ),

                    // Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: AppTheme.redAlert,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 32), // mt-8
                    // Countdown timer
                    Center(
                      child: CountdownTimer(
                        key: _countdownKey,
                        durationSeconds: 59,
                        onResend: _handleResend,
                      ),
                    ),

                    const Spacer(),

                    // Action Section
                    PrimaryButton(
                      text: 'Xác nhận',
                      onPressed: _handleVerify,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 24), // mt-6
                    // Resend link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 12, // text-xs
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF94A3B8), // text-slate-400
                          ),
                          children: [
                            const TextSpan(text: 'Bạn không nhận được mã? '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  _handleResend();
                                  _countdownKey.currentState?.restart();
                                },
                                child: Text(
                                  'Gửi lại ngay',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w600, // font-semibold
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32), // pb-12 roughly
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Che email: n***@gmail.com
  String _maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return '';
    final parts = email.split('@');
    final name = parts[0];
    if (name.length <= 2) return email;
    return '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}@${parts[1]}';
  }
}
