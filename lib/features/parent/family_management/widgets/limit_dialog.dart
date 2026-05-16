import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/family_management/family_management_notifier.dart';

class LimitDialog extends HookWidget {
  const LimitDialog({
    super.key,
    required this.childUid,
    required this.childName,
    required this.currentLimitMinor,
    required this.notifier,
  });

  final String childUid;
  final String childName;
  final int? currentLimitMinor;
  final FamilyManagementNotifier notifier;

  static const _quickAmounts = <int>[500000, 1000000, 2000000, 5000000];

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final controller = useTextEditingController(
      text: (currentLimitMinor != null && currentLimitMinor! > 0)
          ? currentLimitMinor.toString()
          : '',
    );
    final inputValue = useState<String>(controller.text);
    final isSaving = useState(false);
    final screenSize = MediaQuery.sizeOf(context);
    final dialogMaxWidth =
        screenSize.width > 600 ? 420.w : screenSize.width * 0.9;
    final dialogMaxHeight = screenSize.height * 0.6;

    useEffect(() {
      void listener() => inputValue.value = controller.text;
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final parsedValue = int.tryParse(inputValue.value.trim()) ?? 0;
    final canSave = parsedValue > 0;
    final hasCurrentLimit = currentLimitMinor != null && currentLimitMinor! > 0;

    void addQuickAmount(int amount) {
      final current = int.tryParse(controller.text.trim()) ?? 0;
      final next = current + amount;
      controller.text = next.toString();
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }

    return Dialog(
      elevation: 0,
      insetPadding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
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
                        SizedBox(height: 12.h),
                        Text(
                          s.familyManagementLimitDialogTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.r,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          childName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          controller: controller,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                        SizedBox(height: 20.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: _quickAmounts.map((amount) {
                            return _QuickAmountChip(
                              label: _formatQuickLabel(amount),
                              onTap: () => addQuickAmount(amount),
                            );
                          }).toList(growable: false),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: canSave && !isSaving.value
                        ? () async {
                            isSaving.value = true;
                            await notifier.setChildLimit(childUid, parsedValue);
                            isSaving.value = false;
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(s.familyManagementLimitSetSuccess),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            }
                          }
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      disabledBackgroundColor:
                          AppTheme.primary.withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: isSaving.value
                        ? SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            s.familyManagementSave,
                            style: TextStyle(
                              fontSize: 16.r,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                if (hasCurrentLimit) ...[
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: isSaving.value
                          ? null
                          : () async {
                              isSaving.value = true;
                              await notifier.removeChildLimit(childUid);
                              isSaving.value = false;
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        s.familyManagementLimitRemovedSuccess),
                                    backgroundColor: AppTheme.primary,
                                  ),
                                );
                              }
                            },
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.redAlert,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        textStyle: TextStyle(
                          fontSize: 14.r,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(s.familyManagementRemoveLimit),
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed:
                        isSaving.value ? null : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      s.familyManagementCancel,
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

  String _formatQuickLabel(int amountMinor) {
    if (amountMinor >= 1000000) {
      final millions = amountMinor ~/ 1000000;
      return '$millions tr';
    }
    final thousands = amountMinor ~/ 1000;
    return '${thousands}K';
  }
}

class _QuickAmountChip extends StatelessWidget {
  const _QuickAmountChip({required this.label, required this.onTap});

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
