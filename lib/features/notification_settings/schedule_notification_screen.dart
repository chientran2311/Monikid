import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/notification_settings/notification_settings_provider.dart';
import 'package:monikid/features/notification_settings/widgets/notification_hero_section.dart';
import 'package:monikid/features/notification_settings/widgets/notification_instruction_card.dart';
import 'package:monikid/features/notification_settings/widgets/notification_schedule_card.dart';
import 'package:monikid/features/notification_settings/widgets/notification_toggle_card.dart';
import 'package:monikid/features/notification_settings/widgets/time_picker_bottom_sheet.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class ScheduleNotificationScreen extends HookConsumerWidget {
  const ScheduleNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final state = ref.watch(notificationSettingsNotifierProvider);
    final notifier = ref.read(notificationSettingsNotifierProvider.notifier);

    final heroAnim = useAnimationController(duration: const Duration(milliseconds: 500));
    final card1Anim = useAnimationController(duration: const Duration(milliseconds: 500));
    final card2Anim = useAnimationController(duration: const Duration(milliseconds: 500));
    final card3Anim = useAnimationController(duration: const Duration(milliseconds: 500));

    useEffect(() {
      heroAnim.forward();
      Future.delayed(const Duration(milliseconds: 100), card1Anim.forward);
      Future.delayed(const Duration(milliseconds: 180), card2Anim.forward);
      Future.delayed(const Duration(milliseconds: 260), card3Anim.forward);
      return null;
    }, const []);

    ref.listen(notificationSettingsNotifierProvider, (_, next) {
      if (next.hasError && next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: s.notificationSettingsTitle),
      body: AppBackground(
        child: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
            left: 20.w,
            right: 20.w,
            bottom: 40.h,
          ),
          children: [
            _FadeSlide(controller: heroAnim, child: const NotificationHeroSection()),
            SizedBox(height: 16.h),
            _FadeSlide(
              controller: card1Anim,
              child: NotificationToggleCard(
                enabled: state.enabled,
                onChanged: notifier.toggleEnabled,
                isDark: isDark,
              ),
            ),
            SizedBox(height: 16.h),
            _FadeSlide(
              controller: card2Anim,
              child: NotificationScheduleCard(
                timeText: state.formattedTime,
                onTimeTap: () => _pickTime(context, ref, state.hour, state.minute),
                isDark: isDark,
              ),
            ),
            SizedBox(height: 16.h),
            _FadeSlide(
              controller: card3Anim,
              child: const NotificationInstructionCard(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime(BuildContext context, WidgetRef ref, int hour, int minute) async {
    final picked = await showTimePickerBottomSheet(
      context,
      initialHour: hour,
      initialMinute: minute,
    );
    if (picked == null) return;
    await ref
        .read(notificationSettingsNotifierProvider.notifier)
        .updateTime(picked.hour, picked.minute);
  }
}

class _FadeSlide extends StatelessWidget {
  const _FadeSlide({required this.controller, required this.child});

  final AnimationController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.04),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}
