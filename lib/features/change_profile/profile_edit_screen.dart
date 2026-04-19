import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/change_profile/change_profile_provider.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changeProfileProvider);
    final notifier = ref.read(changeProfileProvider.notifier);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC);
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final subTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.profileEditTitle, // "Chỉnh sửa hồ sơ"
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: state.isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        // Avatar Section
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: surfaceColor,
                                border: Border.all(
                                  color: AppTheme.primary.withOpacity(0.1),
                                  width: 4,
                                ),
                                image: state.profile?.avatarUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(state.profile!.avatarUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: state.profile?.avatarUrl == null
                                  ? Icon(Icons.person, size: 60, color: subTextColor)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  // TODO: Handle avatar change
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: bgColor,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          s.profileEditAvatarLabel, // "Thay đổi ảnh đại diện"
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Form Fields Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextField(
                                label: s.profileEditFullName, // "Họ và tên"
                                hint: s.profileEditFullNameHint, // "Nhập họ và tên của bạn"
                                initialValue: state.profile?.fullName,
                                onChanged: (value) {
                                  // Temporary update in state/controller (would normally use a controller or local state)
                                },
                                isDark: isDark,
                                surfaceColor: surfaceColor,
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                              const SizedBox(height: 24),
                              _buildTextField(
                                label: s.profileEditPhone, // "Số điện thoại"
                                hint: s.profileEditPhoneHint, // "Nhập số điện thoại"
                                initialValue: state.profile?.phone,
                                icon: Icons.call,
                                keyboardType: TextInputType.phone,
                                isDark: isDark,
                                surfaceColor: surfaceColor,
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                              const SizedBox(height: 24),
                              _buildTextField(
                                label: s.profileEditEmail, // "Email"
                                initialValue: state.profile?.email,
                                icon: Icons.mail,
                                keyboardType: TextInputType.emailAddress,
                                enabled: false, // Read-only
                                isDark: isDark,
                                surfaceColor: surfaceColor,
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 4),
                                child: Text(
                                  s.profileEditEmailWarning, // "Email không thể thay đổi để bảo mật tài khoản."
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: subTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildTextField(
                                label: s.profileEditDob, // "Ngày sinh"
                                hint: s.profileEditDobHint, // "DD/MM/YYYY"
                                initialValue: state.profile?.dob,
                                icon: Icons.calendar_today,
                                isDark: isDark,
                                surfaceColor: surfaceColor,
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48), // Bottom padding
                      ],
                    ),
                  ),
                ),
                // Action Buttons
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border(
                      top: BorderSide(color: borderColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            backgroundColor: surfaceColor,
                            foregroundColor: subTextColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            s.actionCancel, // "Hủy"
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.isSaving ? null : () {
                            notifier.updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            shadowColor: AppTheme.primary.withOpacity(0.4),
                          ),
                          child: state.isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  s.actionSaveChanges, // "Lưu thay đổi"
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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

  Widget _buildTextField({
    required String label,
    String? hint,
    String? initialValue,
    IconData? icon,
    bool enabled = true,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    required bool isDark,
    required Color surfaceColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: TextStyle(
            color: enabled ? textColor : Colors.grey[500],
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            filled: true,
            fillColor: enabled ? surfaceColor : (isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: icon != null 
              ? Icon(
                  icon,
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                  size: 20,
                )
              : null,
            suffixIcon: !enabled
              ? Icon(
                  Icons.lock,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 20,
                )
              : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
            ),
          ),
        ),
      ],
    );
  }
}
