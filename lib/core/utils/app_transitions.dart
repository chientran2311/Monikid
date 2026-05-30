import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Fade transition — used for context.go destinations (full stack replacement,
/// no back-navigation semantics). Duration: 250ms.
CustomTransitionPage<void> fadePage(GoRouterState state, Widget child) =>
    CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );

/// Slide-from-right transition — used for context.push destinations (overlay
/// navigation with a back stack). Duration: 300ms.
CustomTransitionPage<void> slidePage(GoRouterState state, Widget child) =>
    CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final slide = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
        return SlideTransition(position: slide, child: child);
      },
    );

/// Transition builder for AnimatedSwitcher — slide + fade for step-based
/// navigation within a single screen (e.g., onboarding steps).
Widget switcherSlideTransition(Widget child, Animation<double> animation) {
  final slide = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
  return SlideTransition(
    position: slide,
    child: FadeTransition(opacity: animation, child: child),
  );
}
