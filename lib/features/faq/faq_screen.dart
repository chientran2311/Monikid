import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/faq/faq_provider.dart';
import 'package:monikid/features/faq/widgets/faq_item.dart';
import 'package:monikid/features/faq/widgets/faq_skeleton_list.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class FAQScreen extends ConsumerWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fAQProvider);
    final notifier = ref.read(fAQProvider.notifier);

    // Surface load errors via snackbar (non-form error rule).
    ref.listen(fAQProvider, (previous, next) {
      if (next.errorMessage != null &&
          previous?.errorMessage != next.errorMessage) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: s.settingFAQ),
      body: AppBackground(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 12.h),

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
              const Expanded(child: FAQSkeletonList())
            else if (state.faqList.isEmpty)
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
                    itemCount: state.faqList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final faq = state.faqList[index];
                      return FAQItem(
                        item: faq,
                        isExpanded: state.selectedItemId == faq.id,
                        onTap: () {
                          if (state.selectedItemId == faq.id) {
                            notifier.selectedItem(null); // Collapse
                          } else {
                            notifier.selectedItem(faq.id); // Expand
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
      ),
    );
  }
}
