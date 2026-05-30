import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/fqa/fqa_provider.dart';
import 'package:monikid/features/fqa/widgets/fqa_item.dart';
import 'package:monikid/features/fqa/widgets/fqa_skeleton_list.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class FQAScreen extends ConsumerWidget {
  const FQAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fQAProvider);
    final notifier = ref.read(fQAProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.settingFQA, // "Câu hỏi thường gặp"
          style: context.typo.subtitle.small.copyWith(
            fontWeight: FontWeight.w800,
            color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          
          // Section Label
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                s.faqCommonQuestions,
                style: context.typo.caption.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textMuted,
                  letterSpacing: 0.05,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 12.h),
          
          // Content
          if (state.isLoading)
            const Expanded(child: FQASkeletonList())
          else if (state.fqaList.isEmpty)
            Expanded(
              child: RefreshIndicator(
                onRefresh: notifier.refresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.help_outline,
                            size: 64.sp,
                            color: isDark ? AppTheme.borderDark : AppTheme.iconLight,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            s.msgNoData,
                            style: context.typo.body.medium.copyWith(
                              color: isDark ? AppTheme.iconLight : AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: notifier.refresh,
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
                  itemCount: state.fqaList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final fqa = state.fqaList[index];
                    return FQAItem(
                      item: fqa,
                      isExpanded: state.selectedItemId == fqa.id,
                      onTap: () {
                        if (state.selectedItemId == fqa.id) {
                          notifier.selectedItem(null); // Collapse
                        } else {
                          notifier.selectedItem(fqa.id); // Expand
                        }
                      },
                      animationDelay: Duration(milliseconds: 100 + (index * 50)),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
