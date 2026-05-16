import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
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

    useEffect(() {
      void listener() => inputValue.value = controller.text;
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final parsedValue = int.tryParse(inputValue.value.trim()) ?? 0;
    final canSave = parsedValue > 0;
    final hasCurrentLimit = currentLimitMinor != null && currentLimitMinor! > 0;

    final previewText = inputValue.value.trim().isEmpty
        ? '= 0 ₫'
        : '= ${CurrencyFormatter.format(parsedValue)}';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.familyManagementLimitDialogTitle,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.textBlack,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: s.familyManagementLimitInputHint,
                hintStyle: TextStyle(fontSize: 14.sp, color: AppTheme.textGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppTheme.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppTheme.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppTheme.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              previewText,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppTheme.textGrey,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                if (hasCurrentLimit)
                  TextButton(
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
                                  content: Text(s.familyManagementLimitRemovedSuccess),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            }
                          },
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.redAlert,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text(s.familyManagementRemoveLimit),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.textGrey,
                    textStyle: TextStyle(fontSize: 13.sp),
                  ),
                  child: Text(s.familyManagementCancel),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: canSave && !isSaving.value
                      ? () async {
                          isSaving.value = true;
                          await notifier.setChildLimit(childUid, parsedValue);
                          isSaving.value = false;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(s.familyManagementLimitSetSuccess),
                                backgroundColor: AppTheme.primary,
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canSave ? AppTheme.primary : AppTheme.borderLight,
                    foregroundColor:
                        canSave ? Colors.white : AppTheme.textMuted,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: isSaving.value
                      ? SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(s.familyManagementSave),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
