import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/splash/splash_provider.dart';
import 'package:monikid/features/splash/splash_state.dart';
import 'package:monikid/features/splash/widgets/splash_brand_section.dart';
import 'package:monikid/features/splash/widgets/splash_loading_section.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(splashNotifierProvider.notifier);
    final splashState = ref.watch(splashNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    useEffect(() {
      Future.microtask(notifier.validateUserForRoute);
      return null;
    }, [notifier]);

    ref.listen<SplashState>(splashNotifierProvider, (previous, next) {
      final targetChanged = previous?.routeTarget != next.routeTarget;
      if (!targetChanged || next.isLoading) {
        return;
      }

      if (next.routeTarget == SplashRouteTarget.onboarding) {
        context.go(AppRoutes.onboard1);
        return;
      }

      if (next.routeTarget == SplashRouteTarget.pinGateway) {
        context.go(AppRoutes.pinGateway);
        return;
      }

      if (next.routeTarget == SplashRouteTarget.login) {
        context.go(AppRoutes.login);
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
                      AppTheme.primary.withValues(alpha: 0.20),
                    ]
                  : [
                      AppTheme.surfaceLight,
                      AppTheme.surfaceLight,
                      AppTheme.primary.withValues(alpha: 0.10),
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
                          AppTheme.primary.withValues(alpha: 0.05),
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
