import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_state.dart';

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

  static const _quickAmounts = <int>[
    1000000,
    2000000,
    5000000,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final state = ref.watch(setMoneyLimitNotifierProvider);
    final notifier = ref.read(setMoneyLimitNotifierProvider.notifier);
    final amountController = useTextEditingController(text: state.amountInput);
    final errorText = _buildErrorText(context, state.validationError);
    final screenSize = MediaQuery.sizeOf(context);
    final dialogMaxWidth = screenSize.width > 600 ? 420.w : screenSize.width * 0.9;
    final dialogMaxHeight = screenSize.height * 0.5;

    useEffect(() {
      if (amountController.text == state.amountInput) {
        return null;
      }

      amountController.value = TextEditingValue(
        text: state.amountInput,
        selection: TextSelection.collapsed(offset: state.amountInput.length),
      );
      return null;
    }, [state.amountInput, amountController]);

    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogMaxWidth,
          maxHeight: dialogMaxHeight,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: const Color(0xFFF1F5F9)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x24000000),
                blurRadius: 32.r,
                offset: Offset(0, 12.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 52.r,
                          height: 52.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.track_changes,
                            color: AppTheme.primary,
                            size: 28.r,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s.setMoneyLimitTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.r,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        TextField(
                          controller: amountController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: TextStyle(
                            fontSize: 34.r,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF166534),
                            letterSpacing: -0.8,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(
                              fontSize: 34.r,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF86EFAC),
                            ),
                            suffixText: 'đ',
                            suffixStyle: TextStyle(
                              fontSize: 22.r,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          onChanged: notifier.updateAmountInput,
                        ),
                        Container(
                          width: 128.w,
                          height: 2.h,
                          margin: EdgeInsets.only(top: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                        ),
                        if (errorText != null) ...[
                          SizedBox(height: 12.h),
                          Text(
                            errorText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.r,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.redAlert,
                            ),
                          ),
                        ],
                        SizedBox(height: 20.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: _quickAmounts.map((amountMinor) {
                            return _QuickAmountChip(
                              label: s.setMoneyLimitQuickAmount(
                                amountMinor ~/ 1000000,
                              ),
                              onTap: () => notifier.addQuickAmount(amountMinor),
                            );
                          }).toList(growable: false),
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          s.setMoneyLimitDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.r,
                            height: 1.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isSaving
                        ? null
                        : () async {
                            final isSaved = await notifier.save();
                            if (!context.mounted || !isSaved) {
                              return;
                            }
                            Navigator.of(context).pop();
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      disabledBackgroundColor: AppTheme.primary.withValues(
                        alpha: 0.5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: state.isSaving
                        ? SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            s.actionConfirm,
                            style: TextStyle(
                              fontSize: 16.r,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: state.isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      s.setMoneyLimitSkipAction,
                      style: TextStyle(
                        fontSize: 15.r,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

class _QuickAmountChip extends StatelessWidget {
  const _QuickAmountChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.r,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }
}
