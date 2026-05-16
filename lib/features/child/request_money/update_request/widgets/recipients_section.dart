import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RecipientsSection extends StatelessWidget {
  const RecipientsSection({
    super.key,
    required this.selectedRecipients,
    required this.textColor,
    required this.borderColor,
    required this.isDarkMode,
    required this.onToggle,
  });

  final List<String> selectedRecipients;
  final Color textColor;
  final Color borderColor;
  final bool isDarkMode;
  final void Function(String) onToggle;

  static const _recipients = [
    {
      'id': 'dad',
      'label': 'Bố',
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBCVUQGb4a6a4wUg9_b2rR9j6YPnOHJTin0okECJlEgHqrI27ZPAwsZqtac-_FjDjEQgQmeOtPMqJGWg5pmLXpjOygc8bb4ISaj3WD8YD3QK_ACZ_SjpEsvOxWrIxf3YQc5sr9dsYpTlEpYyDHHnKuOdtDuph6tBzjD-8WpRjMsrXghkgRCfsITem39Xu85TfZ6N__bF2o2JF4TVLsJvWFynbnGOdrRfpShJbITOZgO1lQadx41nUVAwC0d0dVHo30XtLVynPrXa8Y',
    },
    {
      'id': 'mom',
      'label': 'Mẹ',
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBqFRSCpT4xBMH8bcmeI61Q3k9Ip0NRyIicmQ06kqdLoJRlTzsz5pKoBXEbS0o5UOvWNNzXfWdOAcBhx9jeWvgDNTvsi7M87OBuUN_Mtbsf4Jab2Yv6GTxfJ5Nv5tKo5HqG3I79dq6U0l1pO5jaHbSLyIlO8I1bjamFyRCjtvWcMALHEqciy7YScRJyxnb2HSH-Z5BIk1o5eV9qYAX-f0gyOOcXuciR2OEw4iorlgY2jC5l03mpwNYSiLsqPi8rRI3AAIAbowMeAR4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Người nhận yêu cầu',
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: _recipients.map((r) {
              final isSelected = selectedRecipients.contains(r['id']);
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => onToggle(r['id']!),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppTheme.primary : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(r['url']!),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode ? AppTheme.backgroundDark : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(Icons.check, color: Colors.white, size: 10),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        r['label']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
