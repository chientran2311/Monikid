import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'widgets/setting_group.dart';
import 'widgets/setting_item.dart';
import 'widgets/switch_item.dart';

class SettingTabParent extends StatefulWidget {
  const SettingTabParent({Key? key}) : super(key: key);

  @override
  State<SettingTabParent> createState() => _SettingTabParentState();
}

class _SettingTabParentState extends State<SettingTabParent> {
  bool _pushNotification = true;
  bool _emailReport = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define base colors based on setting_par.html
    final bgColor = isDark ? const Color(0xFF141E15) : const Color(0xFFF6F8F6);
    final surfaceColor = isDark ? const Color(0xFF1C2B1E) : Colors.white;
    final parentPrimary = const Color(0xFF2F7F34); // text-secondary
    final textColor = isDark ? Colors.white : const Color(0xFF111811);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF5E8761);
    final borderColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: bgColor.withOpacity(0.9),
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Cài đặt",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 100.0,
              ), // Padding cho BottomNav
              child: Column(
                children: [
                  // Profile Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? const Color(0xFF334155)
                                    : const Color(0xFFE2E8F0),
                                border: Border.all(
                                  color: surfaceColor,
                                  width: 4,
                                ),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://i.pravatar.cc/150?img=11',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: parentPrimary,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nguyễn Văn An",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "nguyen.van.an@example.com",
                          style: TextStyle(fontSize: 14, color: textSubColor),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: parentPrimary,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Chỉnh sửa hồ sơ",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Setting Groups
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SettingGroup(
                          title: "Quản lý gia đình",
                          titleColor: textSubColor,
                          children: [
                            SettingItem(
                              icon: Icons.supervisor_account,
                              iconColor: parentPrimary,
                              iconBgColor: parentPrimary.withOpacity(0.1),
                              title: "Quản lý tài khoản con",
                              subtitle: "Thêm hoặc xóa tài khoản",
                              textColor: textColor,
                              borderColor: borderColor,
                              showBorder: true,
                            ),
                            SettingItem(
                              icon: Icons.account_balance_wallet,
                              iconColor: Colors.blue.shade600,
                              iconBgColor: Colors.blue.shade100,
                              title: "Hạn mức chi tiêu",
                              subtitle: "Thiết lập giới hạn tuần/tháng",
                              textColor: textColor,
                              borderColor: borderColor,
                              showBorder: false,
                            ),
                          ],
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 24),

                        SettingGroup(
                          title: "Thông báo",
                          titleColor: textSubColor,
                          children: [
                            SwitchItem(
                              icon: Icons.notifications_active,
                              iconColor: Colors.orange.shade600,
                              iconBgColor: Colors.orange.shade100,
                              title: "Thông báo tức thì",
                              subtitle: "Khi con thực hiện giao dịch",
                              value: _pushNotification,
                              onChanged: (val) =>
                                  setState(() => _pushNotification = val),
                              textColor: textColor,
                              borderColor: borderColor,
                              parentPrimary: parentPrimary,
                              showBorder: true,
                            ),
                            SwitchItem(
                              icon: Icons.mail,
                              iconColor: Colors.purple.shade600,
                              iconBgColor: Colors.purple.shade100,
                              title: "Báo cáo tuần qua Email",
                              subtitle: null,
                              value: _emailReport,
                              onChanged: (val) =>
                                  setState(() => _emailReport = val),
                              textColor: textColor,
                              borderColor: borderColor,
                              parentPrimary: parentPrimary,
                              showBorder: false,
                            ),
                          ],
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 24),

                        SettingGroup(
                          title: "Tài khoản",
                          titleColor: textSubColor,
                          children: [
                            SettingItem(
                              icon: Icons.lock_reset,
                              iconColor: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF475569),
                              iconBgColor: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF1F5F9),
                              title: "Đổi mật khẩu",
                              subtitle: null,
                              textColor: textColor,
                              borderColor: borderColor,
                              showBorder: true,
                            ),
                            SettingItem(
                              icon: Icons.help_outline,
                              iconColor: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF475569),
                              iconBgColor: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF1F5F9),
                              title: "Trợ giúp & Phản hồi",
                              subtitle: null,
                              textColor: textColor,
                              borderColor: borderColor,
                              showBorder: false,
                            ),
                          ],
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 32),

                        // Logout button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: surfaceColor,
                            foregroundColor: AppTheme.redAlert,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: AppTheme.redAlert.withOpacity(0.3),
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Đăng xuất",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            "Phiên bản 1.0.2",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
