import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';

class ChangeLanguageDialog extends ConsumerWidget {
  const ChangeLanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;

    // Defaultly hardcoding 2 supported locales for now.
    // In a real app, this might be tied to a Riverpod Provider that manages Locale state
    final languages = [
      {'code': 'vi', 'label': s.vietnamese},
      {'code': 'en', 'label': s.english},
    ];
    // Current locale from Riverpod Provider
    final currentLocaleCode = ref.watch(changeLanguageProvider).localeCode;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // iOS Style Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.borderDark
                      : AppTheme.borderLight,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.language,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.close,
                      color: isDark
                          ? AppTheme.textMuted
                          : AppTheme.textGrey,
                    ),
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Language List
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: languages.map((lang) {
                    final isSelected = currentLocaleCode == lang['code'];
                    return GestureDetector(
                      onTap: () async {
                        await ref.read(changeLanguageProvider.notifier).setLanguage(lang['code']!);
                        if (context.mounted) {
                          context.pop(lang['code']);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : isDark
                                  ? AppTheme.borderDark
                                  : AppTheme.borderLight,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lang['label']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : textColor,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              )
                            else 
                              Icon(
                                Icons.circle_outlined,
                                color: isDark
                                  ? AppTheme.textGrey
                                  : AppTheme.textMuted,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Footer Action
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppTheme.borderDark
                      : AppTheme.surfaceVeryDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  s.close,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
