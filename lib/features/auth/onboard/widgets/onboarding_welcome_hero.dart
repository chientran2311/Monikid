import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class OnboardingWelcomeHero extends StatefulWidget {
  const OnboardingWelcomeHero({super.key});

  @override
  State<OnboardingWelcomeHero> createState() =>
      _OnboardingWelcomeHeroState();
}

class _OnboardingWelcomeHeroState extends State<OnboardingWelcomeHero>
    with TickerProviderStateMixin {
  late final AnimationController _blobCtrl;
  late final AnimationController _centerCtrl;
  late final AnimationController _coinCtrl;
  late final AnimationController _cardCtrl;
  late final AnimationController _shieldCtrl;

  @override
  void initState() {
    super.initState();
    _blobCtrl = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _centerCtrl = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _coinCtrl = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _coinCtrl.repeat(reverse: true);
    });

    _cardCtrl = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) _cardCtrl.repeat(reverse: true);
    });

    _shieldCtrl = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _shieldCtrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _blobCtrl.dispose();
    _centerCtrl.dispose();
    _coinCtrl.dispose();
    _cardCtrl.dispose();
    _shieldCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // pulseGlow: scale 1→1.15, opacity 0.6→0.9, 4s alternate
    final blobScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _blobCtrl, curve: Curves.easeInOut),
    );
    final blobOpacity = Tween<double>(begin: 0.6, end: 0.9).animate(
      CurvedAnimation(parent: _blobCtrl, curve: Curves.easeInOut),
    );
    // floatCenter: translateY 0→-12px, 6s
    final centerY = Tween<double>(begin: 0.0, end: -12.0).animate(
      CurvedAnimation(parent: _centerCtrl, curve: Curves.easeInOut),
    );
    // floatCoin: translateY 0→-15px, rotate 0→10deg, 4s
    final coinY = Tween<double>(begin: 0.0, end: -15.0).animate(
      CurvedAnimation(parent: _coinCtrl, curve: Curves.easeInOut),
    );
    final coinAngle =
        Tween<double>(begin: 0.0, end: 10 * math.pi / 180).animate(
      CurvedAnimation(parent: _coinCtrl, curve: Curves.easeInOut),
    );
    // floatCard: translateY 0→-10px, rotate -5→5deg, 5s
    final cardY = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(parent: _cardCtrl, curve: Curves.easeInOut),
    );
    final cardAngle = Tween<double>(
      begin: -5 * math.pi / 180,
      end: 5 * math.pi / 180,
    ).animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeInOut));
    // floatShield: translateY 0→12px, rotate 5→-5deg, 4.5s
    final shieldY = Tween<double>(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _shieldCtrl, curve: Curves.easeInOut),
    );
    final shieldAngle = Tween<double>(
      begin: 5 * math.pi / 180,
      end: -5 * math.pi / 180,
    ).animate(CurvedAnimation(parent: _shieldCtrl, curve: Curves.easeInOut));

    return SizedBox(
      width: double.infinity,
      height: 280.h,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _blobCtrl,
          _centerCtrl,
          _coinCtrl,
          _cardCtrl,
          _shieldCtrl,
        ]),
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Blob background (pulseGlow)
              Transform.scale(
                scale: blobScale.value,
                child: Opacity(
                  opacity: blobOpacity.value,
                  child: Container(
                    width: 220.r,
                    height: 220.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppTheme.primaryLight,
                          AppTheme.primaryLight.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Center wallet (floatCenter)
              Transform.translate(
                offset: Offset(0, centerY.value.h),
                child: SizedBox(
                  width: 130.r,
                  height: 130.r,
                  child: CustomPaint(painter: _WalletPainter()),
                ),
              ),
              // Coin — top right (floatCoin)
              Positioned(
                top: 24.h,
                right: 36.w,
                child: Transform.translate(
                  offset: Offset(0, coinY.value.h),
                  child: Transform.rotate(
                    angle: coinAngle.value,
                    child: SizedBox(
                      width: 50.r,
                      height: 50.r,
                      child: CustomPaint(painter: _CoinPainter()),
                    ),
                  ),
                ),
              ),
              // AI Scanner — bottom left (floatCard)
              Positioned(
                bottom: 40.h,
                left: 24.w,
                child: Transform.translate(
                  offset: Offset(0, cardY.value.h),
                  child: Transform.rotate(
                    angle: cardAngle.value,
                    child: SizedBox(
                      width: 58.r,
                      height: 58.r,
                      child: CustomPaint(painter: _ScannerPainter()),
                    ),
                  ),
                ),
              ),
              // Shield — bottom right (floatShield)
              Positioned(
                bottom: 28.h,
                right: 28.w,
                child: Transform.translate(
                  offset: Offset(0, shieldY.value.h),
                  child: Transform.rotate(
                    angle: shieldAngle.value,
                    child: SizedBox(
                      width: 56.r,
                      height: 56.r,
                      child: CustomPaint(painter: _ShieldPainter()),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SVG-faithful CustomPainters — art colors inline (not design system tokens)
// ─────────────────────────────────────────────────────────────────────────────

class _WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.143 * s, 0.286 * s, 0.714 * s, 0.500 * s),
        Radius.circular(0.143 * s),
      ),
      Paint()..color = AppTheme.primary,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.143 * s, 0.393 * s, 0.714 * s, 0.393 * s),
        Radius.circular(0.143 * s),
      ),
      Paint()..color = const Color(0xFF3D9B42),
    );
    final line = Paint()
      ..color = Colors.white
      ..strokeWidth = 4 * s / 140
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0.714 * s, 0.321 * s), Offset(0.857 * s, 0.321 * s), line);
    canvas.drawLine(Offset(0.786 * s, 0.250 * s), Offset(0.786 * s, 0.393 * s), line);
    final stripe = Paint()..color = Colors.white.withValues(alpha: 0.30);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.250 * s, 0.536 * s, 0.214 * s, 0.043 * s),
        const Radius.circular(2),
      ),
      stripe,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.250 * s, 0.629 * s, 0.357 * s, 0.043 * s),
        const Radius.circular(2),
      ),
      stripe,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _CoinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final c = Offset(s / 2, s / 2);
    canvas.drawCircle(c, 0.429 * s, Paint()..color = const Color(0xFFFFD700));
    canvas.drawCircle(c, 0.321 * s, Paint()..color = const Color(0xFFFFC107));
    canvas.drawRect(
      Rect.fromLTWH(0.446 * s, 0.357 * s, 0.107 * s, 0.286 * s),
      Paint()..color = Colors.white.withValues(alpha: 0.80),
    );
    final line = Paint()
      ..color = Colors.white.withValues(alpha: 0.80)
      ..strokeWidth = 2 * s / 56
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0.393 * s, 0.411 * s), Offset(0.607 * s, 0.411 * s), line);
    canvas.drawLine(Offset(0.393 * s, 0.589 * s), Offset(0.607 * s, 0.589 * s), line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _ScannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.143 * s, 0.143 * s, 0.714 * s, 0.714 * s),
        Radius.circular(0.171 * s),
      ),
      Paint()..color = const Color(0xFF1E293B),
    );
    final dash = Paint()
      ..color = AppTheme.primary
      ..strokeWidth = 2 * s / 70
      ..strokeCap = StrokeCap.round;
    final dashW = 4 * s / 70;
    var x = 0.071 * s;
    final y = 0.357 * s;
    while (x < 0.929 * s) {
      canvas.drawLine(Offset(x, y), Offset(x + dashW, y), dash);
      x += dashW * 2;
    }
    canvas.drawCircle(Offset(s / 2, s / 2), 0.171 * s, Paint()..color = const Color(0xFF334155));
    canvas.drawCircle(Offset(s / 2, s / 2), 0.114 * s, Paint()..color = const Color(0xFF0F172A));
    canvas.drawCircle(
      Offset(0.557 * s, 0.443 * s),
      0.029 * s,
      Paint()..color = Colors.white.withValues(alpha: 0.40),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final shield = Path()
      ..moveTo(0.500 * s, 0.156 * s)
      ..lineTo(0.188 * s, 0.281 * s)
      ..lineTo(0.188 * s, 0.469 * s)
      ..cubicTo(0.188 * s, 0.672 * s, 0.313 * s, 0.813 * s, 0.500 * s, 0.906 * s)
      ..cubicTo(0.688 * s, 0.813 * s, 0.813 * s, 0.672 * s, 0.813 * s, 0.469 * s)
      ..lineTo(0.813 * s, 0.281 * s)
      ..close();
    canvas.drawPath(shield, Paint()..color = const Color(0xFFFFF9C4));
    canvas.drawCircle(
      Offset(0.500 * s, 0.469 * s),
      0.188 * s,
      Paint()..color = AppTheme.primary,
    );
    final check = Path()
      ..moveTo(0.438 * s, 0.469 * s)
      ..lineTo(0.484 * s, 0.516 * s)
      ..lineTo(0.578 * s, 0.422 * s);
    canvas.drawPath(
      check,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 3 * s / 64
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
