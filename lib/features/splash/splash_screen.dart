import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/features/splash/splash_provider.dart';
import 'package:monikid/features/splash/splash_state.dart';
import 'package:monikid/core/theme/theme.dart';
import 'dart:async';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(splashNotifierProvider.notifier).init();
    });
  }

  void _navigateToHome(SplashState state) {
    if (state.isAuthenticated) {
      final role = ref.read(authProvider).userRole;
      if (role == 'parent') {
        context.go(AppRoutes.parent);
      } else {
        context.go(AppRoutes.studentMain);
      }
    } else {
      if (state.onboardingComplete) {
        context.go(AppRoutes.login);
      } else {
        context.go(AppRoutes.onboard1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final splashState = ref.watch(splashNotifierProvider);
    final progress = splashState.loadingProgress;
    final progressValue = progress / 100.0;

    ref.listen<SplashState>(splashNotifierProvider, (previous, next) {
      if (previous?.isLoading == true && next.isLoading == false) {
        _navigateToHome(next);
      }
    });

    return PopScope(
      canPop: false,
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
                      AppTheme.primary.withOpacity(0.20), // to-primary/20
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                      AppTheme.primary.withOpacity(0.10), // to-primary/10
                    ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Decorative Background Element (Subtle)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppTheme.primary.withOpacity(0.05), // from-primary/5
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: TweenAnimationBuilder(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo Container
                                Container(
                                  width: 112, // w-28
                                  height: 112, // h-28
                                  margin: const EdgeInsets.only(
                                    bottom: 24,
                                  ), // mb-6
                                  decoration: BoxDecoration(
                                    color: AppTheme.primary.withOpacity(
                                      0.1,
                                    ), // bg-primary/10
                                    borderRadius: BorderRadius.circular(
                                      24,
                                    ), // rounded-3xl
                                    border: Border.all(
                                      color: AppTheme.primary.withOpacity(
                                        0.2,
                                      ), // border-primary/20
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                          0.05,
                                        ), // shadow-sm
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Transform.rotate(
                                    angle: 3 * 3.14159 / 180, // rotate-3
                                    child: Center(
                                      child: Transform.rotate(
                                        angle:
                                            -3 *
                                            3.14159 /
                                            180, // -rotate-3 inside
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.center,
                                          children: [
                                            const Icon(
                                              Icons.account_balance_wallet,
                                              size: 64, // text-[64px]
                                              color: AppTheme.primary,
                                            ),
                                            Positioned(
                                              top: -8, // -top-4
                                              right: -8, // -right-2
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ), // p-1
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? AppTheme.backgroundDark
                                                      : Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                            0.05,
                                                          ), // drop-shadow-sm
                                                      blurRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.eco,
                                                  size:
                                                      34, // 42px total including padding
                                                  color: AppTheme.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Brand Name
                                Text(
                                  "SmartSpending",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30, // text-3xl
                                    fontWeight:
                                        FontWeight.w800, // font-extrabold
                                    letterSpacing: -0.5, // tracking-tight
                                    color: isDark
                                        ? AppTheme.primaryLight
                                        : AppTheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8), // mb-2
                                // Tagline
                                Text(
                                  "Quản lý thông minh, tương lai vững bền",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        14, // sm:text-base (using 14 as safe default)
                                    fontWeight: FontWeight.w500, // font-medium
                                    letterSpacing: 0.25, // tracking-wide
                                    color: isDark
                                        ? const Color(0xFF94A3B8)
                                        : const Color(
                                            0xFF64748B,
                                          ), // text-slate-400 / neutral-gray
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --- Bottom Loading Indicator ---
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                      ), // max-w-[200px]
                      padding: const EdgeInsets.only(
                        bottom: 48,
                        left: 16,
                        right: 16,
                      ), // pb-12 px-4
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ), // px-1
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 300),
                              tween: Tween<double>(
                                begin: 0,
                                end: progress.toDouble(),
                              ),
                              builder: (context, value, _) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "LOADING",
                                      style: TextStyle(
                                        fontSize: 12, // text-xs
                                        fontWeight:
                                            FontWeight.w600, // font-semibold
                                        color: isDark
                                            ? AppTheme.primaryLight.withOpacity(
                                                0.8,
                                              )
                                            : AppTheme.primary.withOpacity(0.8),
                                        letterSpacing: 1.0, // tracking-wider
                                      ),
                                    ),
                                    Text(
                                      "${value.toInt()}%",
                                      style: const TextStyle(
                                        fontSize: 12, // text-xs
                                        fontWeight:
                                            FontWeight.w500, // font-medium
                                        color: Color(
                                          0xFF94A3B8,
                                        ), // text-slate-400
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12), // gap-3
                          // Progress Bar
                          Container(
                            height: 6, // h-1.5
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : const Color(
                                      0xFFE2E8F0,
                                    ), // bg-slate-700 : slate-200
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 300),
                                tween: Tween<double>(
                                  begin: 0,
                                  end: progressValue,
                                ),
                                builder: (context, value, _) {
                                  return FractionallySizedBox(
                                    widthFactor: value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          9999,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.primary.withOpacity(
                                              0.5,
                                            ), // shadow-[0_0_10px_rgba(47,127,121,0.5)]
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8), // mt-2
                          // Version Text
                          const Text(
                            "Phiên bản 1.0.2",
                            style: TextStyle(
                              fontSize: 10, // text-[10px]
                              fontWeight: FontWeight.w500, // font-medium
                              color: Color(0xFF94A3B8), // text-slate-400
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
