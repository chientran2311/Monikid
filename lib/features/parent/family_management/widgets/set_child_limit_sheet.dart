import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/family_management/family_management_notifier.dart';
import 'package:monikid/shared/widgets/amount_input_box.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

/// Bottom sheet for a host parent to set a child's monthly spending limit.
/// Persists via [FamilyManagementNotifier.setChildLimit].
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
      final digitsOnly = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = int.tryParse(digitsOnly);
      if (amount == null || amount <= 0) return;
      isLoading.value = true;
      try {
        await ref
            .read(familyManagementNotifierProvider.notifier)
            .setChildLimit(childUid, amount);
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
      final digitsOnly = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final current = int.tryParse(digitsOnly) ?? 0;
      controller.text = (current + presetMinor).toString();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
            AmountInputBox(
              controller: controller,
              label: childName,
              autofocus: true,
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
                  child: PrimaryButton.secondary(
                    title: s.setMoneyLimitSkipAction,
                    height: 52.h,
                    onTap: isLoading.value
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: PrimaryButton(
                    title: s.actionConfirm,
                    height: 52.h,
                    isLoading: isLoading.value,
                    onTap: confirm,
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
