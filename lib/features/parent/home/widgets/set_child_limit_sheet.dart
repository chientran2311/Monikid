import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';

class SetChildLimitSheet extends HookConsumerWidget {
  const SetChildLimitSheet({
    super.key,
    required this.childUid,
    required this.childName,
  });

  final String childUid;
  final String childName;

  static const _quickAmounts = <int>[1000000, 2000000, 5000000];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final controller = useTextEditingController();
    final isLoading = useState(false);

    Future<void> confirm() async {
      final digitsOnly =
          controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = int.tryParse(digitsOnly);
      if (amount == null || amount <= 0) return;
      isLoading.value = true;
      try {
        await ref
            .read(parentHomeNotifierProvider.notifier)
            .setChildLimit(childUid: childUid, amountMinor: amount);
        if (context.mounted) Navigator.of(context).pop(true);
      } catch (_) {
        if (context.mounted) {
          context.showErrorSnackBar(s.setMoneyLimitSaveFailed);
          Navigator.of(context).pop(false);
        }
      } finally {
        isLoading.value = false;
      }
    }

    void addPreset(int presetMinor) {
      final digitsOnly =
          controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final current = int.tryParse(digitsOnly) ?? 0;
      controller.text = (current + presetMinor).toString();
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              s.parentSetLimitTitle,
              style: context.typo.subtitle.small.copyWith(
              color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
            ),
            ),
            SizedBox(height: 4.h),
            Text(
              s.parentSetLimitDescription,
              style: context.typo.body.small.copyWith(color: AppTheme.textGrey),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: context.typo.title.medium.copyWith(
                color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
              ),
              decoration: InputDecoration(
                hintText: '0',
                suffixText: 'đ',
                labelText: childName,
                suffixStyle: context.typo.subtitle.small.copyWith(
                  color: AppTheme.textGrey,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              children: _quickAmounts.map((amount) {
                return _PresetChip(
                  label: s.setMoneyLimitQuickAmount(amount ~/ 1000000),
                  onTap: () => addPreset(amount),
                );
              }).toList(growable: false),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        isLoading.value ? null : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textDark,
                      side: BorderSide(
                        color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      s.setMoneyLimitSkipAction,
                      style: context.typo.body.big.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilledButton(
                    onPressed: isLoading.value ? null : confirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      disabledBackgroundColor:
                          AppTheme.primary.withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: isLoading.value
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
                            style: context.typo.subtitle.small.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.label, required this.onTap});

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
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            label,
            style: context.typo.body.small.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
