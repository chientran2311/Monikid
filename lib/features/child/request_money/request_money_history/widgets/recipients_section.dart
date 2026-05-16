import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RecipientsSection extends StatelessWidget {
  const RecipientsSection({
    required this.recipients,
    required this.onRecipientToggled,
    required this.isDarkMode,
    required this.surfaceColor,
    required this.textColor,
    super.key,
  });

  final List<String> recipients;
  final void Function(String recipientId) onRecipientToggled;
  final bool isDarkMode;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Người nhận yêu cầu',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildRecipientAvatar(
                'dad',
                'Bố',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBCVUQGb4a6a4wUg9_b2rR9j6YPnOHJTin0okECJlEgHqrI27ZPAwsZqtac-_FjDjEQgQmeOtPMqJGWg5pmLXpjOygc8bb4ISaj3WD8YD3QK_ACZ_SjpEsvOxWrIxf3YQc5sr9dsYpTlEpYyDHHnKuOdtDuph6tBzjD-8WpRjMsrXghkgRCfsITem39Xu85TfZ6N__bF2o2JF4TVLsJvWFynbnGOdrRfpShJbITOZgO1lQadx41nUVAwC0d0dVHo30XtLVynPrXa8Y',
              ),
              const SizedBox(width: 16),
              _buildRecipientAvatar(
                'mom',
                'Mẹ',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBqFRSCpT4xBMH8bcmeI61Q3k9Ip0NRyIicmQ06kqdLoJRlTzsz5pKoBXEbS0o5UOvWNNzXfWdOAcBhx9jeWvgDNTvsi7M87OBuUN_Mtbsf4Jab2Yv6GTxfJ5Nv5tKo5HqG3I79dq6U0l1pO5jaHbSLyIlO8I1bjamFyRCjtvWcMALHEqciy7YScRJyxnb2HSH-Z5BIk1o5eV9qYAX-f0gyOOcXuciR2OEw4iorlgY2jC5l03mpwNYSiLsqPi8rRI3AAIAbowMeAR4',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientAvatar(String id, String label, String avatarUrl) {
    final isSelected = recipients.contains(id);
    return GestureDetector(
      onTap: () => onRecipientToggled(id),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: surfaceColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
