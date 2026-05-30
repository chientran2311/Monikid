import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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

class ScheduleNotificationScreen extends HookConsumerWidget {
  const ScheduleNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final state = ref.watch(notificationSettingsNotifierProvider);
    final notifier = ref.read(notificationSettingsNotifierProvider.notifier);

    final bgColor = isDark ? AppTheme.backgroundDark : const Color(0xFFF2FBF5);
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

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
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, s, textColor, isDark),
      body: ListView(
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
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    dynamic s,
    Color textColor,
    bool isDark,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _GlassIconButton(
              onTap: () => context.pop(),
              isDark: isDark,
              child: Icon(Icons.chevron_left_rounded, color: textColor, size: 26.r),
            ),
            Expanded(
              child: Center(
                child: Text(
                  s.notificationSettingsTitle,
                  style: context.typo.subtitle.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
            _GlassIconButton(
              onTap: () {},
              isDark: isDark,
              child: Icon(Icons.help_outline_rounded, color: textColor, size: 20.r),
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

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.onTap,
    required this.child,
    required this.isDark,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.76),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                width: 1,
              ),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
