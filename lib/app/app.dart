import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/core/service/notification_tap_intent.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/change_theme/change_theme_provider.dart';
import 'package:monikid/features/notification_settings/notification_nav_provider.dart';
import 'package:monikid/l10n/app_localizations.dart';

/// Global localization accessor for legacy non-widget call sites.
AppLocalizations get s => rootNavigatorKey.l10n;

/// Main App Widget
class MoniKidApp extends ConsumerStatefulWidget {
  const MoniKidApp({super.key});

  @override
  ConsumerState<MoniKidApp> createState() => _MoniKidAppState();
}

class _MoniKidAppState extends ConsumerState<MoniKidApp> {
  StreamSubscription<NotificationTapIntent>? _tapSub;

  @override
  void initState() {
    super.initState();
    final service = getIt<LocalNotificationService>();
    // Cold-start tap: consume the one-shot intent captured during initialize().
    final initial = service.initialTapIntent;
    if (initial != null) {
      service.initialTapIntent = null;
      Future.microtask(
        () => ref.read(notificationNavProvider.notifier).set(initial),
      );
    }
    // Taps while the app process is alive.
    _tapSub = service.onNotificationTap.listen((intent) {
      ref.read(notificationNavProvider.notifier).set(intent);
    });
  }

  @override
  void dispose() {
    _tapSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final localeState = ref.watch(changeLanguageProvider);
    final themeMode = ref.watch(changeThemeProvider).themeMode;

    return MaterialApp.router(
      title: 'MoniKid',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      themeAnimationDuration: const Duration(milliseconds: 700),
      themeAnimationCurve: Curves.easeInOut,

      // Router
      routerConfig: router,
      builder: (context, child) {
        ScreenUtils.init(context);
        return AppTypographyScope(
          typography: AppTypography(
            defaultColor: Theme.of(context).textTheme.bodyMedium?.color ??
                Theme.of(context).colorScheme.onSurface,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },

      // Localization
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeState.localeCode),
    );
  }
}
