import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_provider.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';

class GeminiSectionCard extends HookConsumerWidget {
  const GeminiSectionCard({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final asyncState = ref.watch(chooseAiModelNotifierProvider);
    final state = asyncState.valueOrNull ?? const ChooseAiModelState();
    final notifier = ref.read(chooseAiModelNotifierProvider.notifier);

    final obscureApiKey = useState(true);
    final apiKeyController = useTextEditingController(text: state.apiKeyInput);

    useEffect(() {
      if (apiKeyController.text != state.apiKeyInput) {
        apiKeyController.value = TextEditingValue(
          text: state.apiKeyInput,
          selection: TextSelection.collapsed(offset: state.apiKeyInput.length),
        );
      }
      return null;
    }, [state.apiKeyInput]);

    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final errorColor = isDark ? const Color(0xFFFCA5A5) : const Color(0xFFDC2626);

    final selectedModelName = kGeminiModelOptions
        .firstWhere(
          (o) => o.modelId == state.selectedModel,
          orElse: () => kGeminiModelOptions.first,
        )
        .displayName;

    void showModelPicker() {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (sheetCtx) => _ModelPickerSheet(
          selectedModelId: state.selectedModel,
          isDark: isDark,
          onSelected: (option) {
            sheetCtx.pop();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              notifier.updateSelectedModelWithConfirmation(
                context,
                option.modelId,
                option.displayName,
              );
            });
          },
        ),
      );
    }

    final errorText = _resolveErrorText(s, state.error);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Row(
            children: [
              Text(
                s.aiModelGeminiSectionTitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: mutedColor,
                ),
              ),
              if (state.activeAiSource == AiSource.gemini) ...[
                SizedBox(width: 6.w),
                Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.primary,
                  size: 16.r,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 0.5),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.aiModelUseApiKeyModel,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                    if (state.isSavingApiKey)
                      SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppTheme.primary,
                        ),
                      )
                    else
                      AppIosSwitch(
                        value: state.hasSavedApiKey,
                        // disabled when no key in storage — add key first via button
                        onChanged: (state.isBusy || !state.hasKeyInStorage)
                            ? null
                            : (v) => v
                                ? notifier.enableApiKey()
                                : notifier.disableApiKey(),
                        scale: 0.6,
                      ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 0.5, color: borderColor),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.aiModelApiKeyLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: apiKeyController,
                            onChanged: notifier.updateApiKeyInput,
                            obscureText: obscureApiKey.value,
                            style: TextStyle(fontSize: 14.sp, color: textColor),
                            decoration: InputDecoration(
                              hintText: s.aiModelApiKeyHint,
                              hintStyle:
                                  TextStyle(fontSize: 14.sp, color: mutedColor),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () =>
                              obscureApiKey.value = !obscureApiKey.value,
                          child: Icon(
                            obscureApiKey.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 20.r,
                            color: mutedColor,
                          ),
                        ),
                      ],
                    ),
                    if (state.hasSavedApiKey) ...[
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: state.isSavingApiKey ? null : notifier.removeApiKey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.isSavingApiKey)
                              SizedBox(
                                width: 16.r,
                                height: 16.r,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: errorColor,
                                ),
                              )
                            else
                              Icon(Icons.delete_outline_rounded,
                                  size: 18.r, color: errorColor),
                            SizedBox(width: 4.w),
                            Text(
                              s.aiModelRemoveApiKey,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: errorColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        s.aiModelApiKeySessionNote,
                        style: TextStyle(fontSize: 12.sp, color: mutedColor),
                      ),
                    ] else ...[
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              state.isSavingApiKey ? null : notifier.saveApiKey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: state.isSavingApiKey
                              ? SizedBox(
                                  width: 18.r,
                                  height: 18.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  s.aiModelAddApiKey,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                    if (errorText != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        errorText,
                        style: TextStyle(fontSize: 12.sp, color: errorColor),
                      ),
                    ],
                  ],
                ),
              ),
              Divider(height: 1, thickness: 0.5, color: borderColor),
              InkWell(
                onTap: state.isBusy ? null : showModelPicker,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12.r)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.aiModelSelectModelLabel,
                              style:
                                  TextStyle(fontSize: 12.sp, color: mutedColor),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              selectedModelName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          size: 20.r, color: mutedColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? _resolveErrorText(AppLocalizations s, ChooseAiModelError? error) {
    switch (error) {
      case ChooseAiModelError.emptyApiKey:
        return s.aiModelApiKeyRequired;
      case ChooseAiModelError.invalidApiKey:
        return s.aiModelInvalidApiKey;
      case ChooseAiModelError.requestFailed:
        return s.aiModelRequestFailed;
      case null:
      default:
        return null;
    }
  }
}

class _ModelPickerSheet extends StatelessWidget {
  const _ModelPickerSheet({
    required this.selectedModelId,
    required this.isDark,
    required this.onSelected,
  });

  final String selectedModelId;
  final bool isDark;
  final ValueChanged<GeminiModelOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Container(
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Text(
              s.aiModelSelectModelLabel,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: borderColor),
          ...kGeminiModelOptions.map((option) {
            final isSelected = option.modelId == selectedModelId;
            return Column(
              children: [
                InkWell(
                  onTap: () => onSelected(option),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option.displayName,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color:
                                  isSelected ? AppTheme.primary : textColor,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_rounded,
                              size: 20.r, color: AppTheme.primary),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 0.5, color: borderColor),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: mutedColor,
                  side: BorderSide(color: borderColor),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  s.actionCancel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
