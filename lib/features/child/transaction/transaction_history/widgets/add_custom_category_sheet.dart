import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/switch_two_item.dart';

class AddCustomCategorySheet extends HookWidget {
  const AddCustomCategorySheet({
    super.key,
    required this.onAdded,
    this.initialType = 'expense',
  });

  /// Returns (label, icon, type) — type is 'expense' or 'income'.
  final Future<void> Function(String label, String icon, String type) onAdded;
  final String initialType;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final isLoading = useState(false);
    final error = useState<String?>(null);
    final selectedIcon = useState<String>('📦');
    final typeIndex = useState<int>(initialType == 'income' ? 1 : 0); // 0=expense,1=income
    final showEmojiPicker = useState<bool>(false);

    useEffect(() {
      Future.microtask(() => focusNode.requestFocus());
      return null;
    }, const []);

    Future<void> submit() async {
      final label = controller.text.trim();
      if (label.isEmpty) {
        error.value = s.customCategoryLabelHint;
        return;
      }
      isLoading.value = true;
      error.value = null;
      try {
        await onAdded(
          label,
          selectedIcon.value,
          typeIndex.value == 0 ? 'expense' : 'income',
        );
        if (context.mounted) context.pop();
      } catch (_) {
        if (context.mounted) isLoading.value = false;
      }
    }

    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final bottomPadding = viewInsets + (viewInsets > 0 ? 16.h : safeBottom + 16.h);

    return Container(
      decoration: BoxDecoration(
        color: sheetColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.textMuted.withValues(alpha: 0.4)
                    : AppTheme.textGrey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(99.r),
              ),
            ),
          ),
          // Header: title centered, "Hủy" button right
          SizedBox(
            height: 56.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    s.customCategoryAdd,
                    style: context.typo.subtitle.small.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      s.customCategoryCancel,
                      style: context.typo.subtitle.small.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
          // Form body
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Type switch (expense / income)
                  SwitchTwoItem(
                    title1: s.transactionExpenseTab,
                    title2: s.transactionIncomeTab,
                    selectedIndex: typeIndex.value,
                    onChanged: (i) {
                      typeIndex.value = i;
                      showEmojiPicker.value = false;
                    },
                  ),
                  SizedBox(height: 24.h),
                  // Label field
                  Text(
                    s.customCategoryLabelHint,
                    style: context.typo.body.small.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 58.h,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      maxLength: 40,
                      textCapitalization: TextCapitalization.sentences,
                      textAlignVertical: TextAlignVertical.center,
                      onTap: () => showEmojiPicker.value = false,
                      style: context.typo.body.big.copyWith(color: textColor),
                      decoration: InputDecoration(
                        hintText: s.customCategoryLabelHint,
                        hintStyle: context.typo.body.big.copyWith(color: AppTheme.textMuted),
                        counterText: '',
                        filled: true,
                        fillColor: isDark ? AppTheme.surfaceDark : AppTheme.backgroundLight,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: error.value != null
                                ? AppTheme.redAlert
                                : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
                            width: error.value != null ? 1.5 : 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: AppTheme.redAlert, width: 1.5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: AppTheme.redAlert, width: 1.5),
                        ),
                      ),
                      onSubmitted: (_) => submit(),
                    ),
                  ),
                  if (error.value != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      error.value!,
                      style: context.typo.caption.big.copyWith(color: AppTheme.redAlert),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  // Icon picker
                  Text(
                    s.customCategoryIconHint,
                    style: context.typo.body.small.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        showEmojiPicker.value = !showEmojiPicker.value;
                      },
                      child: Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.surfaceDark : AppTheme.backgroundLight,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: showEmojiPicker.value
                                ? AppTheme.primary
                                : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
                            width: showEmojiPicker.value ? 1.5 : 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(selectedIcon.value, style: context.typo.title.big),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: showEmojiPicker.value
                        ? SizedBox(
                            height: 260.h,
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                selectedIcon.value = emoji.emoji;
                                showEmojiPicker.value = false;
                              },
                              config: Config(
                                height: 260,
                                emojiViewConfig: EmojiViewConfig(
                                  backgroundColor: isDark ? AppTheme.surfaceDark : Colors.white,
                                  columns: 8,
                                  emojiSizeMax: 28,
                                ),
                                categoryViewConfig: const CategoryViewConfig(
                                  indicatorColor: AppTheme.primary,
                                ),
                                bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
                                searchViewConfig: const SearchViewConfig(),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(height: 8.h),
                  // Submit button
                  Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(AppTheme.primary, Colors.white, 0.02)!,
                          Color.lerp(AppTheme.primary, Colors.black, 0.18)!,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withValues(alpha: 0.24),
                          blurRadius: 28.r,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading.value ? null : submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        minimumSize: Size(double.infinity, 56.h),
                        padding: EdgeInsets.zero,
                      ),
                      child: isLoading.value
                          ? SizedBox(
                              width: 22.r,
                              height: 22.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              s.customCategoryConfirm,
                              style: context.typo.subtitle.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
