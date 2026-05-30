import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_provider.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/features/child/choose_ai_model/widget/ai_model_hero_card.dart';
import 'package:monikid/features/child/choose_ai_model/widget/gemini_section_card.dart';
import 'package:monikid/features/child/choose_ai_model/widget/gemma_section_card.dart';
import 'package:monikid/shared/widgets/loading_screen.dart';

class ChooseAiModelScreen extends ConsumerWidget {
  const ChooseAiModelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    ref.listen(chooseAiModelNotifierProvider, (previous, next) {
      final prev = previous?.valueOrNull;
      final curr = next.valueOrNull;
      if (curr == null || !context.mounted) return;

      final wasValidating = prev?.status == ChooseAiModelStatus.savingApiKey;

      if (wasValidating && curr.status == ChooseAiModelStatus.apiKeyReady) {
        context.showSuccessSnackBar(s.aiModelApiKeyAddSuccess);
      } else if (wasValidating && curr.status == ChooseAiModelStatus.error) {
        final msg = curr.error == ChooseAiModelError.invalidApiKey
            ? s.aiModelApiKeyInvalid
            : s.aiModelApiKeyTestFailed;
        context.showErrorSnackBar(msg);
      }
    });

    final asyncState = ref.watch(chooseAiModelNotifierProvider);
    final state = asyncState.valueOrNull;
    final notifier = ref.read(chooseAiModelNotifierProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 1),
              ),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor,
                  size: 16.r,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
            title: Text(
              s.chooseAiModelTitle,
              style: context.typo.subtitle.small.copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
            children: [
              AiModelHeroCard(isDark: isDark),
              SizedBox(height: 14.h),
              GeminiSectionCard(isDark: isDark),
              SizedBox(height: 14.h),
              GemmaSectionCard(
                gemmaStatus:
                    state?.gemmaStatus ?? GemmaDownloadStatus.readyToDownload,
                gemmaProgress: state?.gemmaDownloadProgress ?? 0.0,
                gemmaError: state?.gemmaDownloadError,
                isDark: isDark,
                activeAiSource: state?.activeAiSource ?? AiSource.none,
                useLocalModel: state?.useLocalModel ?? false,
                onDownloadConfirmed: notifier.downloadLocalModel,
                onCancel: notifier.cancelModelDownload,
                onDelete: notifier.deleteLocalModel,
                onToggleLocalModel: notifier.toggleLocalModel,
              ),
              SizedBox(height: 24.h),
              Text(
                s.aiModelFooterNote,
                textAlign: TextAlign.center,
                style: context.typo.body.small.copyWith(
                  color: mutedColor,
                  height: 1.45,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (state?.isSelectingModel == true)
          Positioned.fill(
            child: LoadingScreen(message: s.aiModelSavingModelSelection),
          ),
      ],
    );
  }
}
