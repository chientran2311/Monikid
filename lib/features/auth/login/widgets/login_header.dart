import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Abstract Illustration
        Container(
          width: 128, // w-32
          height: 128, // h-32
          margin: const EdgeInsets.only(bottom: 32), // mb-8
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(40), // rounded-[40px]
            border: Border.all(
              color: Colors.white,
              width: 4,
            ), // border-white border-4
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // shadow-md
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 64, // w-16
                height: 64, // h-16
                decoration: const BoxDecoration(
                  color: Color(0xFFF97316), // bg-orange-500
                  shape: BoxShape.circle,
                ),
              ),
              const Positioned(
                bottom: -16, // -bottom-4
                child: Icon(
                  Icons.yard_rounded, // potted_plant equivalent
                  size: 80, // text-[80px]
                  color: AppTheme.primary,
                ),
              ),
              // Sparkles
              const Positioned(
                top: 16,
                right: 16,
                child: Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFDE047),
                  size: 16,
                ), // text-yellow-300 text-sm
              ),
              const Positioned(
                top: 32,
                left: 16,
                child: Icon(
                  Icons.star_rounded,
                  color: Color(0xFF93C5FD),
                  size: 24,
                ), // text-blue-300 text-xl
              ),
            ],
          ),
        ),

        // Title & Tagline
        Text(
          "MoniKid",
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 36, // text-4xl
            fontWeight: FontWeight.w800, // font-extrabold
            letterSpacing: -0.5,
            color: isDark ? AppTheme.primaryLight : AppTheme.primary,
          ),
        ),
        const SizedBox(height: 8), // mt-2
        Text(
          "Quản lý tài chính an toàn cho gia đình bạn.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            color: isDark
                ? const Color(0xFF94A3B8)
                : const Color(0xFF64748B), // text-slate-500 / slate-400
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
