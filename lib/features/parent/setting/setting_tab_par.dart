import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

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
                        _buildSettingGroup(
                          title: "Quản lý gia đình",
                          titleColor: textSubColor,
                          children: [
                            _buildSettingItem(
                              icon: Icons.supervisor_account,
                              iconColor: parentPrimary,
                              iconBgColor: parentPrimary.withOpacity(0.1),
                              title: "Quản lý tài khoản con",
                              subtitle: "Thêm hoặc xóa tài khoản",
                              textColor: textColor,
                              borderColor: borderColor,
                              showBorder: true,
                            ),
                            _buildSettingItem(
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

                        _buildSettingGroup(
                          title: "Thông báo",
                          titleColor: textSubColor,
                          children: [
                            _buildSwitchItem(
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
                            _buildSwitchItem(
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

                        _buildSettingGroup(
                          title: "Tài khoản",
                          titleColor: textSubColor,
                          children: [
                            _buildSettingItem(
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
                            _buildSettingItem(
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

  Widget _buildSettingGroup({
    required String title,
    required Color titleColor,
    required List<Widget> children,
    required Color surfaceColor,
    required Color borderColor,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String? subtitle,
    required Color textColor,
    required Color borderColor,
    required bool showBorder,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: borderColor))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color textColor,
    required Color borderColor,
    required Color parentPrimary,
    required bool showBorder,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: borderColor))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: parentPrimary,
          ),
        ],
      ),
    );
  }
}
