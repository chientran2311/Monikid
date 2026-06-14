import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/features/splash/splash_provider.dart';
import 'package:monikid/features/splash/splash_state.dart';
import 'package:monikid/features/splash/widgets/splash_brand_section.dart';
import 'package:monikid/features/splash/widgets/splash_loading_section.dart';
import 'package:monikid/features/splash/widgets/splash_mesh_background.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(splashNotifierProvider.notifier);
    final splashState = ref.watch(splashNotifierProvider);

    final exitCtrl = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final exitAnim = CurvedAnimation(
      parent: exitCtrl,
      curve: const Cubic(0.7, 0, 0.3, 1),
    );

    final isMounted = useRef(true);
    final isExiting = useRef(false);
    useEffect(() => () { isMounted.value = false; }, const []);

    useEffect(() {
      Future.microtask(notifier.validateUserForRoute);
      return null;
    }, [notifier]);

    void onProgressComplete() {
      if (isExiting.value) return;
      final target = ref.read(splashNotifierProvider).routeTarget;
      if (target == SplashRouteTarget.none) return;
      isExiting.value = true;
      exitCtrl.forward().then((_) {
        if (!isMounted.value) return;
        switch (target) {
          case SplashRouteTarget.onboarding:
            context.go(AppRoutes.onboard1);
          case SplashRouteTarget.login:
            context.go(AppRoutes.login);
          case SplashRouteTarget.enterPinCode:
            context.go(AppRoutes.enterPinCode);
          case SplashRouteTarget.createNewPin:
            context.go(AppRoutes.createNewPin);
          case SplashRouteTarget.none:
            break;
        }
      });
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: AnimatedBuilder(
          animation: exitAnim,
          builder: (context, child) {
            final t = exitAnim.value;
            Widget content = child!;
            if (t > 0.01) {
              final blur = t * 20.0;
              content = ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: content,
              );
            }
            return Transform.scale(
              scale: 1.0 + t * 0.1,
              child: Opacity(opacity: 1.0 - t, child: content),
            );
          },
          child: Stack(
            children: [
              const Positioned.fill(child: SplashMeshBackground()),
              SafeArea(
                child: Column(
                  children: [
                    const Expanded(child: SplashBrandSection()),
                    SplashLoadingSection(
                      progress: splashState.loadingProgress,
                      onComplete: onProgressComplete,
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
}
