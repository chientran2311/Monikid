import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/chooseAImodel/choose_ai_model_state.dart';

class AiModelSelectedBox extends StatelessWidget {
  const AiModelSelectedBox({
    super.key,
    required this.options,
    required this.selectedModel,
    required this.enabled,
    required this.onSelected,
  });

  final List<GeminiModelOption> options;
  final String selectedModel;
  final bool enabled;
  final ValueChanged<GeminiModelOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final selectedOption = _selectedOption;

    return MenuAnchor(
      builder: (context, controller, child) {
        return InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: enabled
              ? () {
                  if (controller.isOpen) {
                    controller.close();
                    return;
                  }
                  controller.open();
                }
              : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 18.r,
                  color: enabled ? AppTheme.primary : AppTheme.textGrey,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    selectedOption.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: enabled ? textColor : AppTheme.textGrey,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22.r,
                  color: enabled ? AppTheme.textGrey : borderColor,
                ),
              ],
            ),
          ),
        );
      },
      menuChildren: options.map((option) {
        final isSelected = option.modelId == selectedModel;
        return MenuItemButton(
          onPressed: enabled ? () => onSelected(option) : null,
          leadingIcon: Icon(
            isSelected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 18.r,
            color: isSelected ? AppTheme.primary : AppTheme.textGrey,
          ),
          child: Text(
            option.displayName,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: textColor,
            ),
          ),
        );
      }).toList(growable: false),
    );
  }

  GeminiModelOption get _selectedOption {
    for (final option in options) {
      if (option.modelId == selectedModel) {
        return option;
      }
    }
    return options.first;
  }
}
