import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/chooseAImodel/choose_ai_model_provider.dart';
import 'package:monikid/features/child/chooseAImodel/choose_ai_model_state.dart';
import 'package:monikid/features/child/chooseAImodel/widget/ai_model_selected_box.dart';
import 'package:monikid/l10n/app_localizations.dart';

class AIModelMarkDown extends HookConsumerWidget {
  const AIModelMarkDown({
    super.key,
    required this.modelName,
    required this.apiKeyHintText,
    required this.addApiKeyText,
    required this.removeApiKeyText,
    required this.promptHintText,
    required this.sendPromptText,
    required this.sessionKeyText,
    required this.responseTitleText,
  });

  final String modelName;
  final String apiKeyHintText;
  final String addApiKeyText;
  final String removeApiKeyText;
  final String promptHintText;
  final String sendPromptText;
  final String sessionKeyText;
  final String responseTitleText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final asyncState = ref.watch(chooseAiModelNotifierProvider);
    final state = asyncState.valueOrNull ?? const ChooseAiModelState();
    final notifier = ref.read(chooseAiModelNotifierProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpanded = useState(false);
    final obscureApiKey = useState(true);

    final apiKeyController = useTextEditingController(text: state.apiKeyInput);
    final promptController = useTextEditingController(text: state.promptInput);

    useEffect(() {
      if (apiKeyController.text != state.apiKeyInput) {
        apiKeyController.value = TextEditingValue(
          text: state.apiKeyInput,
          selection: TextSelection.collapsed(offset: state.apiKeyInput.length),
        );
      }
      return null;
    }, [state.apiKeyInput]);

    useEffect(() {
      if (promptController.text != state.promptInput) {
        promptController.value = TextEditingValue(
          text: state.promptInput,
          selection: TextSelection.collapsed(offset: state.promptInput.length),
        );
      }
      return null;
    }, [state.promptInput]);

    final errorText = _resolveErrorText(s, state.error);
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — expand/collapse
          InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      modelName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppTheme.textBlack,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: mutedColor,
                    size: 24.r,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded.value) ...[
            SizedBox(height: 16.h),

            // API key row — TextField + save/remove button, same height
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52.h,
                    child: TextField(
                      controller: apiKeyController,
                      onChanged: notifier.updateApiKeyInput,
                      obscureText: obscureApiKey.value,
                      decoration: InputDecoration(
                        hintText: apiKeyHintText,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              obscureApiKey.value = !obscureApiKey.value,
                          icon: Icon(
                            obscureApiKey.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 20.r,
                            color: mutedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  height: 52.h,
                  child: state.hasSavedApiKey
                      ? TextButton.icon(
                          onPressed: state.isSavingApiKey
                              ? null
                              : notifier.removeApiKey,
                          icon: state.isSavingApiKey
                              ? SizedBox(
                                  width: 18.r,
                                  height: 18.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(Icons.delete_outline_rounded, size: 20.r),
                          label: Text(
                            removeApiKeyText,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark
                                ? const Color(0xFFFCA5A5)
                                : const Color(0xFFDC2626),
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              side: BorderSide(
                                color: isDark
                                    ? const Color(0xFFFCA5A5)
                                    : const Color(0xFFDC2626),
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: state.isSavingApiKey
                              ? null
                              : notifier.saveApiKey,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
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
                                  addApiKeyText,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                ),
              ],
            ),

            if (state.hasSavedApiKey) ...[
              SizedBox(height: 8.h),
              Text(
                sessionKeyText,
                style: TextStyle(fontSize: 12.sp, color: mutedColor),
              ),
            ],

            SizedBox(height: 16.h),

            // Model selector
            Text(
              s.aiModelSelectModelLabel,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppTheme.textBlack,
              ),
            ),
            SizedBox(height: 8.h),
            AiModelSelectedBox(
              options: kGeminiModelOptions,
              selectedModel: state.selectedModel,
              enabled: !state.isBusy,
              onSelected: (option) =>
                  notifier.updateSelectedModelWithConfirmation(
                    context,
                    option.modelId,
                    option.displayName,
                  ),
            ),

            SizedBox(height: 16.h),

            // Prompt field
            TextField(
              controller: promptController,
              onChanged: notifier.updatePromptInput,
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: promptHintText,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Send prompt
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isSendingPrompt ? null : notifier.sendPrompt,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: state.isSendingPrompt
                    ? SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        sendPromptText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),

            if (errorText != null) ...[
              SizedBox(height: 12.h),
              Text(
                errorText,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFFFCA5A5)
                      : const Color(0xFFDC2626),
                ),
              ),
            ],

            if (state.hasResponse) ...[
              SizedBox(height: 16.h),
              Text(
                responseTitleText,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppTheme.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF111827)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  state.responseText ?? '',
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.5,
                    color: isDark ? Colors.white : AppTheme.textBlack,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  String? _resolveErrorText(AppLocalizations s, ChooseAiModelError? error) {
    switch (error) {
      case ChooseAiModelError.emptyApiKey:
        return s.aiModelApiKeyRequired;
      case ChooseAiModelError.emptyPrompt:
        return s.aiModelPromptRequired;
      case ChooseAiModelError.invalidApiKey:
        return s.aiModelInvalidApiKey;
      case ChooseAiModelError.timedOut:
        return s.aiModelRequestTimeout;
      case ChooseAiModelError.emptyResponse:
        return s.aiModelEmptyResponse;
      case ChooseAiModelError.requestFailed:
        return s.aiModelRequestFailed;
      case null:
        return null;
    }
  }
}
