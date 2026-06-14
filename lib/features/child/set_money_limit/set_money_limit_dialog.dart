import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_state.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

Future<void> showSetMoneyLimitDialog(BuildContext context, WidgetRef ref) async {
  ref.read(setMoneyLimitNotifierProvider.notifier).prepareDraft();
  await showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const SetMoneyLimitDialog(),
  );
}

class SetMoneyLimitDialog extends HookConsumerWidget {
  const SetMoneyLimitDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final state = ref.watch(setMoneyLimitNotifierProvider);
    final notifier = ref.read(setMoneyLimitNotifierProvider.notifier);
    final isManagedByParent =
        ref.watch(authSessionProvider).account?.familyId != null;
    final amountController = useTextEditingController(text: state.amountInput);
    final focusNode = useFocusNode();
    final hasFocus = useState(false);
    final errorText = _buildErrorText(context, state.validationError);
    final screenSize = MediaQuery.sizeOf(context);
    final dialogMaxWidth =
        screenSize.width > 600 ? 420.w : screenSize.width * 0.9;

    useEffect(() {
      if (amountController.text == state.amountInput) return null;
      amountController.value = TextEditingValue(
        text: state.amountInput,
        selection: TextSelection.collapsed(offset: state.amountInput.length),
      );
      return null;
    }, [state.amountInput, amountController]);

    useEffect(() {
      void listener() => hasFocus.value = focusNode.hasFocus;
      focusNode.addListener(listener);
      return () => focusNode.removeListener(listener);
    }, [focusNode]);

    final hasError = errorText != null;

    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogMaxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x2E111811),
                blurRadius: 64.r,
                offset: Offset(0, 26.h),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 14.h),
                child: Column(
                  children: [
                    Text(
                      s.setMoneyLimitTitle,
                      textAlign: TextAlign.center,
                      style: context.typo.headline.small.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.44,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      s.setMoneyLimitSubtitle,
                      textAlign: TextAlign.center,
                      style: context.typo.body.small.copyWith(
                        color: AppTheme.textGrey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // ── Body ────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isManagedByParent) ...[
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppTheme.amberFill,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppTheme.amberBorder),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppTheme.amberText,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                s.setMoneyLimitManagedByParent,
                                style: context.typo.body.small.copyWith(
                                  color: AppTheme.amberText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                    Text(
                      s.setMoneyLimitFieldLabel.toUpperCase(),
                      style: context.typo.caption.big.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.72,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.ease,
                      constraints: BoxConstraints(minHeight: 80.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: hasError
                            ? AppTheme.dangerSurface
                            : isDark
                                ? AppTheme.darkSurfaceVariant
                                : AppTheme.surfaceVeryLight,
                        border: Border.all(
                          color: hasError
                              ? AppTheme.redAlert
                              : hasFocus.value
                                  ? AppTheme.primary.withValues(alpha: 0.5)
                                  : isDark
                                      ? AppTheme.borderDark
                                      : AppTheme.borderLight,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                        boxShadow: hasError
                            ? [
                                BoxShadow(
                                  spreadRadius: 4.r,
                                  color: AppTheme.redAlert.withValues(
                                    alpha: 0.12,
                                  ),
                                ),
                              ]
                            : hasFocus.value
                            ? [
                                BoxShadow(
                                  spreadRadius: 4.r,
                                  color: AppTheme.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              focusNode: focusNode,
                              autofocus: !isManagedByParent,
                              enabled: !isManagedByParent,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: context.typo.display.small.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.8,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: '0',
                                hintStyle: context.typo.display.small.copyWith(
                                  color: isDark
                                      ? AppTheme.borderDark
                                      : AppTheme.borderLight,
                                  letterSpacing: -0.8,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.h),
                              ),
                              onChanged: notifier.updateAmountInput,
                            ),
                          ),
                          Text(
                            'đ',
                            style: context.typo.subtitle.small.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      hasError ? errorText : s.setMoneyLimitDescription,
                      style: context.typo.caption.big.copyWith(
                        color: hasError ? AppTheme.redAlert : AppTheme.textGrey,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              // ── Actions ─────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton.secondary(
                        title: s.actionCancel,
                        height: 48.h,
                        onTap: state.isSaving ? null : () => context.pop(),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: PrimaryButton(
                        title: s.actionConfirm,
                        height: 48.h,
                        isLoading: state.isSaving,
                        onTap: state.isSaving || isManagedByParent
                            ? null
                            : () async {
                                final isSaved = await notifier.save();
                                if (!context.mounted || !isSaved) return;
                                context.pop();
                              },
                      ),
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

  String? _buildErrorText(
    BuildContext context,
    SetMoneyLimitValidationError? validationError,
  ) {
    final s = context.l10n;

    return switch (validationError) {
      SetMoneyLimitValidationError.empty => s.validationEnterAmount,
      SetMoneyLimitValidationError.nonPositive =>
        s.validationAmountGreaterThanZero,
      SetMoneyLimitValidationError.unauthenticated =>
        s.setMoneyLimitUnauthenticated,
      SetMoneyLimitValidationError.saveFailed => s.setMoneyLimitSaveFailed,
      null => null,
    };
  }
}
