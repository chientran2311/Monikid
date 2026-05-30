import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AddCustomCategorySheet extends HookWidget {
  const AddCustomCategorySheet({
    super.key,
    required this.onAdded,
  });

  final Future<void> Function(String label) onAdded;

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
    final hasFocus = useState(false);

    useEffect(() {
      Future.microtask(() => focusNode.requestFocus());
      void listener() => hasFocus.value = focusNode.hasFocus;
      focusNode.addListener(listener);
      return () => focusNode.removeListener(listener);
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
        await onAdded(label);
        if (context.mounted) context.pop();
      } catch (_) {
        if (context.mounted) isLoading.value = false;
      }
    }

    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).padding.bottom;
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
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  s.customCategoryLabelHint,
                  style: context.typo.body.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textGrey,
                  ),
                ),
                SizedBox(height: 10.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 58.h,
                  decoration: BoxDecoration(
                    color: hasFocus.value
                        ? (isDark ? AppTheme.surfaceDark : Colors.white)
                        : (isDark ? AppTheme.surfaceDark : AppTheme.backgroundLight),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: hasFocus.value
                          ? AppTheme.primary
                          : (error.value != null
                              ? AppTheme.redAlert
                              : (isDark ? AppTheme.borderDark : AppTheme.borderLight)),
                      width: hasFocus.value || error.value != null ? 1.5 : 1,
                    ),
                    boxShadow: hasFocus.value
                        ? [
                            BoxShadow(
                              color: AppTheme.primary.withValues(alpha: 0.1),
                              blurRadius: 0,
                              spreadRadius: 4.r,
                            ),
                          ]
                        : null,
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    maxLength: 40,
                    textCapitalization: TextCapitalization.sentences,
                    style: context.typo.body.big.copyWith(color: textColor),
                    decoration: InputDecoration(
                      hintText: s.customCategoryLabelHint,
                      hintStyle: context.typo.body.big.copyWith(color: AppTheme.textMuted),
                      counterText: '',
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
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
                SizedBox(height: 32.h),
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
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
