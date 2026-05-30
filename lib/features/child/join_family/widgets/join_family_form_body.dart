import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/features/child/join_family/widgets/code_input_row.dart';
import 'package:monikid/features/child/join_family/widgets/join_family_hero_section.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class JoinFamilyFormBody extends HookWidget {
  const JoinFamilyFormBody({
    required this.isDark,
    required this.state,
    required this.notifier,
    super.key,
  });

  final bool isDark;
  final JoinFamilyState state;
  final JoinFamilyNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    // Entry animations
    final heroCtrl = useAnimationController(duration: const Duration(milliseconds: 600));
    final sheetCtrl = useAnimationController(duration: const Duration(milliseconds: 600));
    final heroCurve = CurvedAnimation(parent: heroCtrl, curve: Curves.easeOutExpo);
    final sheetCurve = CurvedAnimation(parent: sheetCtrl, curve: Curves.easeOutExpo);

    useEffect(() {
      heroCtrl.forward();
      Future.delayed(const Duration(milliseconds: 80), sheetCtrl.forward);
      return null;
    }, const []);

    // Code input — same logic as before
    final controller = useTextEditingController();
    final code = useState('');
    final focusNode = useFocusNode();

    useEffect(() {
      void onChanged() => code.value = controller.text;
      controller.addListener(onChanged);
      return () => controller.removeListener(onChanged);
    }, [controller]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        // Hero card — popIn animation
        FadeTransition(
          opacity: heroCurve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(heroCurve),
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
                  .animate(heroCurve),
              child: JoinFamilyHeroSection(isDark: isDark),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Sheet — fade + slight slide up
        Expanded(
          child: FadeTransition(
            opacity: sheetCurve,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
                  .animate(sheetCurve),
              child: _SheetSection(
                isDark: isDark,
                surfaceColor: surfaceColor,
                borderColor: borderColor,
                code: code.value,
                isReady: code.value.length == 6,
                isBusy: state.isBusy,
                controller: controller,
                focusNode: focusNode,
                onJoin: () => notifier.joinWithCode(code.value),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SheetSection extends StatelessWidget {
  const _SheetSection({
    required this.isDark,
    required this.surfaceColor,
    required this.borderColor,
    required this.code,
    required this.isReady,
    required this.isBusy,
    required this.controller,
    required this.focusNode,
    required this.onJoin,
  });

  final bool isDark;
  final Color surfaceColor;
  final Color borderColor;
  final String code;
  final bool isReady;
  final bool isBusy;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onJoin;

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
          CodeInputRow(
            code: code,
            isDark: isDark,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            textColor: textColor,
            onTap: () => focusNode.requestFocus(),
            onLongPress: () async {
              final data = await Clipboard.getData(Clipboard.kTextPlain);
              if (data?.text == null) return;
              final digits = data!.text!.replaceAll(RegExp(r'[^0-9]'), '');
              final limited = digits.length > 6 ? digits.substring(0, 6) : digits;
              controller.text = limited;
              controller.selection = TextSelection.collapsed(offset: limited.length);
            },
          ),
          SizedBox(
            width: 0,
            height: 0,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              autofocus: true,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            s.joinFamilyCodeOnlyDigits,
            style: context.typo.caption.big.copyWith(color: mutedColor),
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            title: s.joinFamilyJoinNow,
            isLoading: isBusy,
            onTap: isReady ? onJoin : null,
          ),
          const Spacer(),
          TextButton(
            onPressed: null,
            child: Text(
              s.joinFamilyNoCode,
              style: context.typo.body.small.copyWith(
                color: mutedColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
