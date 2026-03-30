import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/splash/splash_provider.dart';
import 'package:monikid/features/splash/splash_state.dart';
import 'package:monikid/features/splash/widgets/splash_brand_section.dart';
import 'package:monikid/features/splash/widgets/splash_loading_section.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

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
    if (state.authStatus == AuthStatus.isAuthenticated) {
      final role = ref.read(authSessionProvider).userRole;
      if (role == 'parent') {
        context.go(AppRoutes.parent);
      } else {
        context.go(AppRoutes.studentMain);
      }
      return;
    }

    if (state.onboardingComplete) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.onboard1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final splashState = ref.watch(splashNotifierProvider);

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
                      AppTheme.primary.withOpacity(0.20),
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                      AppTheme.primary.withOpacity(0.10),
                    ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
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
                          AppTheme.primary.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Expanded(
                      child: SplashBrandSection(),
                    ),
                    SplashLoadingSection(
                      progress: splashState.loadingProgress,
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
