import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RequestRecipientSection extends StatelessWidget {
  const RequestRecipientSection({
    required this.recipients,
    required this.isDark,
    required this.onToggleRecipient,
    super.key,
  });

  final List<String> recipients;
  final bool isDark;
  final void Function(String id) onToggleRecipient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RecipientAvatar(
                id: 'dad',
                name: 'Bố',
                url:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuADAs9JI_e4qPPm1HtjxzdGhjerJeZjW74Krn0v964K6zvUzlmgn4yFcu16o9BWbragxeIXR6RW4HRmrWG_BZpnflAPD_CFzcBBLto4FykvTIGvaF1nKdsw5nyIs2dN6cbVTe8E5__KgH6Xe-VGMHNXEMg-SqzmAARnqbE50l20OJijYf8RkQIkZmMqNXvT-J_Q88c7I6P8KEH_jqFaIdaf3_Awj8D3xeMkxZq7G_zIBT1gS_1qF4Su0xTgOrUTDPapE5diRAW1lEk',
                isSelected: recipients.contains('dad'),
                isDark: isDark,
                onTap: onToggleRecipient,
              ),
              const SizedBox(width: 8),
              _RecipientAvatar(
                id: 'mom',
                name: 'Mẹ',
                url:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDlLLNa77xAMLLEc9wLpw2FxDLDT-mu6GvbqQb1DIynyZlhV57Er7TpPEaPqs3Orsv01tgHWS7_MLTou4g-j3C4BZdECMKC0R__8TPBUjjnhAc6u5nqpE4z136Btx_4hv4sgxSOtLlbRyp9GYPpb_1o_Yr6KhQTdYqqIpHzVSB4nIfoazR45B0zvX8s5e5ZDQM3fxbvj9zfBZxM7IWi_eEdjYewWVIatKNp82WrpLMhRMlIU3CxrkgfWOhP5ct7-mxSbzx_gh1G-vo',
                isSelected: recipients.contains('mom'),
                isDark: isDark,
                onTap: onToggleRecipient,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Yêu cầu sẽ được gửi tới Bố và Mẹ.\nChờ một chút xíu để được duyệt nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey.shade400 : AppTheme.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipientAvatar extends StatelessWidget {
  const _RecipientAvatar({
    required this.id,
    required this.name,
    required this.url,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String id;
  final String name;
  final String url;
  final bool isSelected;
  final bool isDark;
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(id),
      child: Stack(
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
              radius: 24,
              backgroundColor: isDark ? AppTheme.surfaceVariant : Colors.white,
              backgroundImage: NetworkImage(url),
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
                    color: isDark ? AppTheme.backgroundDark : Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
