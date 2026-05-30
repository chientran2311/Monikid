import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_provider.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

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
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final errorColor = isDark ? AppTheme.redLight : AppTheme.redDark;
    final apiBoxBg = isDark ? AppTheme.surfaceDark : AppTheme.surfaceVeryLight;
    final apiBoxBorder = isDark ? AppTheme.borderDark : AppTheme.borderLight;

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

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: Offset(0, 12.h),
                ),
              ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(
              isDark: isDark,
              icon: Icons.auto_awesome,
              title: s.aiModelGeminiSectionTitle,
              description: s.aiModelGeminiCardDescription,
              badgeLabel: s.aiModelRecommendedBadge,
              isActive: state.activeAiSource == AiSource.gemini,
            ),
            SizedBox(height: 14.h),
            Divider(height: 1, thickness: 1, color: borderColor),
            // Toggle row
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      s.aiModelEnableGemini,
                      style: context.typo.body.medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        fontSize: 15.sp,
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
            // API box
            Container(
              decoration: BoxDecoration(
                color: apiBoxBg,
                border: Border.all(color: apiBoxBorder, width: 1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.aiModelApiKeyLabel.toUpperCase(),
                    style: context.typo.body.small.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: mutedColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  if (state.hasSavedApiKey) ...[
                    // Masked key field container
                    Container(
                      constraints: BoxConstraints(minHeight: 48.h),
                      padding: EdgeInsets.only(
                          left: 14.w, right: 10.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                            color: AppTheme.primaryLight, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: apiKeyController,
                              onChanged: notifier.updateApiKeyInput,
                              obscureText: obscureApiKey.value,
                              style: context.typo.body.medium
                                  .copyWith(color: textColor),
                              decoration: InputDecoration(
                                hintText: s.aiModelApiKeyHint,
                                hintStyle: context.typo.body.medium
                                    .copyWith(color: mutedColor),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 14.h),
                              ),
                            ),
                          ),
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
                    ),
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
                            style: context.typo.body.medium.copyWith(
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
                      style: context.typo.caption.big.copyWith(color: mutedColor),
                    ),
                  ] else ...[
                    // Plain text field
                    TextField(
                      controller: apiKeyController,
                      onChanged: notifier.updateApiKeyInput,
                      obscureText: obscureApiKey.value,
                      style: context.typo.body.medium.copyWith(color: textColor),
                      decoration: InputDecoration(
                        hintText: s.aiModelApiKeyHint,
                        hintStyle:
                            context.typo.body.medium.copyWith(color: mutedColor),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: GestureDetector(
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
                      ),
                    ),
                    SizedBox(height: 12.h),
                    PrimaryButton(
                      title: s.aiModelAddApiKey,
                      onTap: state.isSavingApiKey ? null : notifier.saveApiKey,
                      isLoading: state.isSavingApiKey,
                    ),
                  ],
                  if (errorText != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      errorText,
                      style:
                          context.typo.caption.big.copyWith(color: errorColor),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 4.h),
            // Model picker row
            Divider(height: 1, thickness: 1, color: borderColor),
            InkWell(
              onTap: state.isBusy ? null : showModelPicker,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(24.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.aiModelSelectModelLabel,
                            style: context.typo.caption.big
                                .copyWith(color: mutedColor),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            selectedModelName,
                            style: context.typo.subtitle.small.copyWith(
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

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.isDark,
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeLabel,
    required this.isActive,
  });

  final bool isDark;
  final IconData icon;
  final String title;
  final String description;
  final String badgeLabel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22.r),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.typo.title.small.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: context.typo.body.small.copyWith(
                  color: mutedColor,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        if (isActive)
          Icon(Icons.check_circle_rounded,
              color: AppTheme.primary, size: 20.r)
        else
          _BadgePill(label: badgeLabel),
      ],
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppTheme.primaryLight, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: context.typo.caption.medium.copyWith(
          fontWeight: FontWeight.w800,
          color: AppTheme.primary,
          fontSize: 11.sp,
        ),
      ),
    );
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
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

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
              style: context.typo.subtitle.small.copyWith(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option.displayName,
                            style: context.typo.body.big.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected ? AppTheme.primary : textColor,
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
                  style: context.typo.body.medium.copyWith(
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
