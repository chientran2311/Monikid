import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/features/child/join_family/widgets/join_family_hero_section.dart';
import 'package:monikid/shared/widgets/otp_input_row.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class JoinFamilyFormBody extends HookWidget {
  const JoinFamilyFormBody({
    required this.isDark,
    required this.state,
    required this.notifier,
    this.disabled = false,
    super.key,
  });

  final bool isDark;
  final JoinFamilyState state;
  final JoinFamilyNotifier notifier;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final heroCtrl = useAnimationController(duration: const Duration(milliseconds: 600));
    final sheetCtrl = useAnimationController(duration: const Duration(milliseconds: 600));
    final heroCurve = CurvedAnimation(parent: heroCtrl, curve: Curves.easeOutExpo);
    final sheetCurve = CurvedAnimation(parent: sheetCtrl, curve: Curves.easeOutExpo);

    useEffect(() {
      heroCtrl.forward();
      Future.delayed(const Duration(milliseconds: 80), sheetCtrl.forward);
      return null;
    }, const []);

    final otpKey = useMemoized(() => GlobalKey<OtpInputRowState>());
    final code = useState('');

    final isReady = code.value.length == 6;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),
                    FadeTransition(
                      opacity: heroCurve,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.96, end: 1.0).animate(heroCurve),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.04),
                            end: Offset.zero,
                          ).animate(heroCurve),
                          child: JoinFamilyHeroSection(isDark: isDark),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    FadeTransition(
                      opacity: sheetCurve,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.06),
                          end: Offset.zero,
                        ).animate(sheetCurve),
                        child: _SheetContent(
                          isDark: isDark,
                          otpKey: otpKey,
                          isBusy: state.isBusy,
                          disabled: disabled,
                          onOtpChanged: (v) => code.value = v,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12.h, 0, 16.h),
                  child: PrimaryButton(
                    title: context.l10n.joinFamilyJoinNow,
                    isLoading: state.isBusy,
                    onTap: (!disabled && isReady)
                        ? () => notifier.joinWithCode(code.value)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SheetContent extends StatelessWidget {
  const _SheetContent({
    required this.isDark,
    required this.otpKey,
    required this.isBusy,
    required this.disabled,
    required this.onOtpChanged,
  });

  final bool isDark;
  final GlobalKey<OtpInputRowState> otpKey;
  final bool isBusy;
  final bool disabled;
  final void Function(String) onOtpChanged;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white.withValues(alpha: 0.76),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            s.joinFamilyEnterCodeTitle,
            style: context.typo.subtitle.medium.copyWith(
              color: textColor,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            s.joinFamilyEnterCodeSubtitle,
            textAlign: TextAlign.center,
            style: context.typo.body.small.copyWith(color: mutedColor, height: 1.45),
          ),
          SizedBox(height: 16.h),
          OtpInputRow(
            key: otpKey,
            onCompleted: (_) {},
            onChanged: onOtpChanged,
            enabled: !isBusy && !disabled,
          ),
          SizedBox(height: 4.h),
          Text(
            disabled ? s.joinFamilyHostDisabledHint : s.joinFamilyCodeOnlyDigits,
            textAlign: TextAlign.center,
            style: context.typo.caption.big.copyWith(
              color: disabled ? AppTheme.warningText : mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}
