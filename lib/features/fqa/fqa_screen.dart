import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/models/entities/fqa/fqa_model.dart';
import 'package:monikid/features/fqa/widgets/fqa_skeleton_list.dart';
import 'package:monikid/features/fqa/fqa_provider.dart';

class FQAScreen extends ConsumerWidget {
  const FQAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fQAProvider);
    final notifier = ref.read(fQAProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF141E15)
          : const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF141E15)
            : const Color(0xFFF6F8F6),
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
          child: Container(color: AppTheme.primary.withOpacity(0.1), height: 1),
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
                                  ? Colors.grey[700]
                                  : Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              s.msgNoData, // Adjust string key as appropriate
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
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
                        return _ContactSupportCard(isDark: isDark);
                      }
                      final fqa = state.fqaList[index];
                      return _FQAItem(
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

class _FQAItem extends StatelessWidget {
  const _FQAItem({
    required this.item,
    required this.isExpanded,
    required this.onTap,
  });

  final FQAModel item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF475569);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isExpanded
                ? AppTheme.primary.withOpacity(0.2)
                : AppTheme.primary.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.expand_more,
                      color: AppTheme.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        top: 4,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFF1F5F9),
                            ),
                          ),
                        ),
                        child: Text(
                          item.answer,
                          style: TextStyle(
                            color: textSubColor,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactSupportCard extends StatelessWidget {
  const _ContactSupportCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.headset_mic, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            s.helpStillNeedHelp, // "Vẫn cần trợ giúp?"
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.helpContactSupportDesc, // "Nếu bạn không tìm thấy câu trả lời, hãy liên hệ..."
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle contact support action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                s.actionChatWithUs,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ), // "Chat với chúng tôi"
            ),
          ),
        ],
      ),
    );
  }
}
