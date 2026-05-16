import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/fqa/fqa_provider.dart';
import 'package:monikid/features/fqa/widgets/fqa_contact_support_card.dart';
import 'package:monikid/features/fqa/widgets/fqa_item.dart';
import 'package:monikid/features/fqa/widgets/fqa_skeleton_list.dart';

class FQAScreen extends ConsumerWidget {
  const FQAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final state = ref.watch(fQAProvider);
    final notifier = ref.read(fQAProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF141E15) : const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor:
            isDark ? const Color(0xFF141E15) : const Color(0xFFF6F8F6),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.settingFQA, // "Câu hỏi thường gặp"
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppTheme.primary.withValues(alpha: 0.1),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (state.isLoading)
              const Expanded(child: FQASkeletonList())
            else if (state.fqaList.isEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: notifier.refresh,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.help_outline,
                              size: 64,
                              color: isDark
                                  ? AppTheme.borderDark
                                  : AppTheme.iconLight,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              s.msgNoData, // Adjust string key as appropriate
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? AppTheme.iconLight
                                    : AppTheme.textGrey,
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
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        state.fqaList.length +
                        1, // +1 for the Contact Support Card at the bottom
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      if (index == state.fqaList.length) {
                        return FQAContactSupportCard(isDark: isDark);
                      }
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
