import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/features/child/setting/widgets/setting_item.dart';
import 'package:monikid/features/child/setting/widgets/setting_group.dart';
import 'package:monikid/features/change_language/change_language_dialog.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';

class SettingTabStudent extends ConsumerWidget {
  const SettingTabStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF141E15) : const Color(0xFFF6F8F6);
    final surfaceColor = isDark ? const Color(0xFF1A261B) : Colors.white;
    final primaryColor = AppTheme.primary; // #2f7f34
    final primaryLightBg = isDark
        ? primaryColor.withOpacity(0.2)
        : const Color(0xFFEAF5EA);
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Sticky Header
            SliverAppBar(
              pinned: true,
              backgroundColor: surfaceColor.withOpacity(0.95),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: textColor,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              title: Text(
                "Cài đặt tài khoản",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: isDark
                      ? const Color(0xFF1F2937)
                      : const Color(0xFFF3F4F6),
                ),
              ),
            ),

            // Main content
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // ===== Profile Section =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Avatar + Edit button
                        Stack(
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryLightBg,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://i.pravatar.cc/150?img=3',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: surfaceColor,
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          "Nguyễn Văn A",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Email
                        Text(
                          "nguyen.van.a@example.com",
                          style: TextStyle(fontSize: 14, color: textSubColor),
                        ),
                      ],
                    ),
                  ),

                  // ===== Settings Groups =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Group 1: Features
                        SettingGroup(
                          children: [
                            SettingItem(
                              icon: Icons.language,
                              iconColor: primaryColor,
                              iconBgColor: primaryLightBg,
                              title: s.language,
                              showBorder: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ref.watch(changeLanguageProvider).localeCode == 'vi' ? s.vietnamese : s.english,
                                    style: TextStyle(
                                      color: textSubColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: isDark
                                        ? const Color(0xFF64748B)
                                        : const Color(0xFF94A3B8),
                                  ),
                                ],
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const ChangeLanguageDialog(),
                                );
                              },
                            ),
                            SettingItem(
                              icon: Icons.account_balance_wallet,
                              iconColor: primaryColor,
                              iconBgColor: primaryLightBg,
                              title: "Thiết lập ngân sách",
                              showBorder: true,
                              onTap: () {},
                            ),
                            SettingItem(
                              icon: Icons.family_restroom,
                              iconColor: primaryColor,
                              iconBgColor: primaryLightBg,
                              title: "Mã liên kết gia đình",
                              showBorder: false,
                              trailing: Icon(
                                Icons.qr_code_2,
                                size: 20,
                                color: isDark
                                    ? const Color(0xFF64748B)
                                    : const Color(0xFF94A3B8),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Group 2: Security
                        SettingGroup(
                          children: [
                            SettingItem(
                              icon: Icons.lock_reset,
                              iconColor: primaryColor,
                              iconBgColor: primaryLightBg,
                              title: "Đổi mật khẩu",
                              showBorder: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Group 3: Logout Button
                        SettingGroup(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // TODO: Xử lý đăng xuất
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: isDark
                                            ? const Color(0xFFF87171)
                                            : const Color(0xFFDC2626),
                                        size: 22,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Đăng xuất",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? const Color(0xFFF87171)
                                              : const Color(0xFFDC2626),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Version
                        Text(
                          "Phiên bản 2.4.0",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? const Color(0xFF4B5563)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 100), // padding cho bottom nav
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
