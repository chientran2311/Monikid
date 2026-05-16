import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_provider.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/features/child/choose_ai_model/widget/gemini_section_card.dart';
import 'package:monikid/features/child/choose_ai_model/widget/gemma_section_card.dart';
import 'package:monikid/shared/widgets/loading_screen.dart';

class ChooseAiModelScreen extends ConsumerWidget {
  const ChooseAiModelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

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
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textColor,
                size: 20.r,
              ),
            ),
            title: Text(
              s.chooseAiModelTitle,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            children: [
             
              SizedBox(height: 24.h),
              GeminiSectionCard(isDark: isDark),
              SizedBox(height: 24.h),
              GemmaSectionCard(
                gemmaStatus:
                    state?.gemmaStatus ?? GemmaDownloadStatus.readyToDownload,
                gemmaProgress: state?.gemmaDownloadProgress ?? 0.0,
                gemmaError: state?.gemmaDownloadError,
                isDark: isDark,
                onDownloadConfirmed: notifier.downloadLocalModel,
                onCancel: notifier.cancelModelDownload,
                onDelete: notifier.deleteLocalModel,
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
