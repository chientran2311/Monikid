import 'package:flutter/cupertino.dart'; // Dùng cho Switch giống iOS
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/share/widgets/setting_section.dart';
import 'package:monikid/share/widgets/setting_tile.dart';
import 'package:monikid/share/widgets/user_profile_tile.dart';
import 'package:monikid/repository/post_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State giả lập
  bool _enableNotifications = true;
  bool _isDarkMode = true; // Default dark theo HTML mẫu
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    // Ép kiểu theme dựa trên state _isDarkMode để demo đổi theme ngay tại màn hình
    // Trong thực tế bạn sẽ dùng Provider/Riverpod/Bloc để quản lý theme toàn app
    final themeData = _isDarkMode ? AppColors.darkTheme : AppColors.lightTheme;
    final isDark = _isDarkMode;

    return Theme(
      data: themeData,
      child: Builder(
        // Cần Builder để context bên dưới nhận được Theme mới
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true, // Hiệu ứng blur header
            appBar: AppBar(
              flexibleSpace: ClipRect(),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () {},
                style: IconButton.styleFrom(
                  hoverColor: isDark ? Colors.white10 : Colors.black12,
                ),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                const SizedBox(height: 80), // Space cho AppBar
                // --- SECTION: PREFERENCES ---
                SettingsSection(
                  title: 'Preferences',
                  children: [
                    SettingsTile(
                      icon: Icons.notifications_outlined,
                      iconColor: isDark
                          ? const Color(0xFF60A5FA)
                          : AppColors.blueText,
                      iconBgColor: isDark
                          ? AppColors.blueDark
                          : AppColors.blueLight,
                      title: 'Enable Notifications',
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: _enableNotifications,
                          activeColor: AppColors.primary,
                          onChanged: (val) =>
                              setState(() => _enableNotifications = val),
                        ),
                      ),
                    ),
                    SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      iconColor: isDark
                          ? const Color(0xFF818CF8)
                          : AppColors.indigoText,
                      iconBgColor: isDark
                          ? AppColors.indigoDark
                          : AppColors.indigoLight,
                      title: 'Dark Mode',
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: _isDarkMode,
                          activeColor: AppColors.primary,
                          onChanged: (val) => setState(() => _isDarkMode = val),
                        ),
                      ),
                    ),
                    SettingsTile(
                      icon: Icons.translate,
                      iconColor: isDark
                          ? const Color(0xFF2DD4BF)
                          : AppColors.tealText,
                      iconBgColor: isDark
                          ? AppColors.tealDark
                          : AppColors.tealLight,
                      title: 'Language',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButton<String>(
                            value: _selectedLanguage,
                            dropdownColor: themeData.cardColor,
                            underline: const SizedBox(), // Xóa gạch chân
                            icon: const SizedBox(), // Ẩn icon mặc định
                            alignment: Alignment.centerRight,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'es',
                                child: Text('Spanish'),
                              ),
                              DropdownMenuItem(
                                value: 'fr',
                                child: Text('French'),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedLanguage = val!),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.expand_more_rounded,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // --- SECTION: ACCOUNT ---
                SettingsSection(
                  title: 'Account',
                  children: [
                    UserProfileTile(
                      name: 'Leanne Graham',
                      email: 'Sincere@april.biz',
                      imageUrl:
                          'https://i.pravatar.cc/150?u=10', // Placeholder image
                      onTap: () {},
                    ),
                    SettingsTile(
                      icon: Icons.security_outlined,
                      iconColor: isDark
                          ? const Color(0xFFFBBF24)
                          : AppColors.amberText,
                      iconBgColor: isDark
                          ? AppColors.amberDark
                          : AppColors.amberLight,
                      title: 'Security & Password',
                      onTap: () {},
                    ),
                  ],
                ),

                // --- SECTION: ABOUT ---
                SettingsSection(
                  title: 'About',
                  children: [
                    SettingsTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: isDark
                          ? Colors.grey.shade300
                          : AppColors.grayText,
                      iconBgColor: isDark
                          ? AppColors.grayDark
                          : AppColors.grayLight,
                      title: 'Version',
                      trailing: Text(
                        '2.4.1 (102)',
                        style: themeData.textTheme.bodyMedium,
                      ),
                    ),
                    SettingsTile(
                      icon: Icons.description_outlined,
                      iconColor: isDark
                          ? Colors.grey.shade300
                          : AppColors.grayText,
                      iconBgColor: isDark
                          ? AppColors.grayDark
                          : AppColors.grayLight,
                      title: 'Terms of Service',
                      onTap: () {},
                    ),
                  ],
                ),

                // --- LOGOUT BUTTON ---
                const SizedBox(height: 24),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: themeData.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: themeData.dividerColor,
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.redAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Social Data Explorer • Made with JSONPlaceholder',
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),

            // --- BOTTOM NAVIGATION BAR (Fake UI to match HTML) ---
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: themeData.cardColor.withOpacity(0.8),
                border: Border(top: BorderSide(color: themeData.dividerColor)),
              ),
              child: ClipRect(
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: 3, // Settings Tab
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined),
                      label: 'Explorer',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_outline),
                      label: 'Saved',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
