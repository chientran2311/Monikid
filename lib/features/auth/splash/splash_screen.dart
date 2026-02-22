import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'dart:async';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/config/storage_keys.dart';

/// SplashScreen — Màn hình chào mừng/loading
/// Chỉ hiển thị SAU đăng nhập/đăng ký thành công.
/// Hiển thị 2 giây rồi chuyển sang Home theo role.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    final authState = ref.read(authProvider);

    if (authState.isAuthenticated) {
      // Chuyển hướng theo role
      final role = authState.userRole;
      if (role == 'parent') {
        context.go(AppRoutes.parent);
      } else {
        context.go(
          AppRoutes.studentMain,
        ); // Giả định route này tồn tại hoặc map về đúng childHome
      }
    } else {
      // Kiểm tra xem đã hoàn thành onboard chưa
      final storage = getIt<AppLocalStorage>();
      final isComplete =
          storage.readSync(StorageKeys.onboardCompleteKey) == 'true';
      if (isComplete) {
        context.go(AppRoutes.login);
      } else {
        context.go(AppRoutes.onboard1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme colors helper
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false, // Splash là transition — không cho back
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      AppTheme.backgroundDark,
                      AppTheme.backgroundDark,
                      AppTheme.primary.withOpacity(0.2),
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                      AppTheme.primary.withOpacity(0.1),
                    ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(), // Top space
                // --- Center Content: Logo & Brand ---
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Abstract "Wallet" shape background
                      Container(
                        width: 112,
                        height: 112,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppTheme.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Transform.rotate(
                          angle: 0.05,
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.account_balance_wallet,
                                  size: 64,
                                  color: AppTheme.primary,
                                ),
                                Positioned(
                                  top: -16,
                                  right: -8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppTheme.backgroundDark
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.eco,
                                      size: 42,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Brand Name
                      Text(
                        "SmartSpending",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: isDark
                              ? AppTheme.primaryLight
                              : AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        "Quản lý thông minh, tương lai vững bền",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                // --- Bottom Loading Indicator ---
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "LOADING",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppTheme.primaryLight.withOpacity(0.8)
                                    : AppTheme.primary.withOpacity(0.8),
                                letterSpacing: 1.0,
                              ),
                            ),
                            const Text(
                              "30%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Progress Bar
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 200 * 0.3,
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(9999),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Version Text
                      const Text(
                        "Phiên bản 1.0.2",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
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
