import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/features/child/join_family/widgets/code_input_row.dart';
import 'package:monikid/shared/widgets/common_buttons.dart';

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
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    final controller = useTextEditingController();
    final code = useState('');
    final focusNode = useFocusNode();

    useEffect(() {
      void listener() => code.value = controller.text;
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32.h),
        Container(
          width: 64.r,
          height: 64.r,
          decoration: const BoxDecoration(
            color: AppTheme.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.group_add_rounded,
            size: 32.r,
            color: AppTheme.primary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          s.joinFamilyTitle,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          s.joinFamilySubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: mutedColor, height: 1.5),
        ),
        SizedBox(height: 40.h),
        CodeInputRow(
          code: code.value,
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
            controller.selection =
                TextSelection.collapsed(offset: limited.length);
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
        SizedBox(height: 36.h),
        AppPrimaryButton(
          label: s.joinFamilyButton,
          isLoading: state.isBusy,
          onPressed: code.value.length == 6
              ? () => notifier.joinWithCode(code.value)
              : null,
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
