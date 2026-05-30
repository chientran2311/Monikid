import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class FQAContactSupportCard extends StatelessWidget {
  const FQAContactSupportCard({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
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
            style: context.typo.button.medium.copyWith(color: isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark),
          ),
          const SizedBox(height: 8),
          Text(
            s.helpContactSupportDesc, // "Nếu bạn không tìm thấy câu trả lời, hãy liên hệ..."
            textAlign: TextAlign.center,
            style: context.typo.body.medium.copyWith(color: isDark ? AppTheme.textMuted : AppTheme.textDark),
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
