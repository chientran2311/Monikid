import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import '../../../../app/router.dart';
import '../../../../shared/widgets/app_buttons.dart';

/// Welcome screen with role selection
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppTheme.backgroundLight,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Section with Illustration
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacingLG),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hero Illustration
                      Container(
                        width: size.width * 0.7,
                        height: size.width * 0.7,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primarySurface,
                              AppTheme.secondaryLight.withValues(alpha: 0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.35),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background circles
                            Positioned(
                              top: 20,
                              right: 30,
                              child: _buildCircle(
                                  40, AppTheme.accentGreen.withValues(alpha: 0.3)),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 20,
                              child: _buildCircle(
                                  25, AppTheme.accentOrange.withValues(alpha: 0.4)),
                            ),
                            Positioned(
                              top: 60,
                              left: 40,
                              child: _buildCircle(
                                  15, AppTheme.primaryLight.withValues(alpha: 0.5)),
                            ),

                            // Main icons
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildFeatureCard(
                                      Icons.family_restroom,
                                      'Gia đình',
                                      AppTheme.primaryGradient,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildFeatureCard(
                                      Icons.account_balance_wallet,
                                      'Ví tiền',
                                      AppTheme.walletGradient,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildFeatureCard(
                                      Icons.qr_code_scanner,
                                      'Thanh toán',
                                      AppTheme.childGradient,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildFeatureCard(
                                      Icons.bar_chart,
                                      'Thống kê',
                                      AppTheme.moneyInGradient,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingXL),

                      // Title
                      Text(
                        'Chào mừng đến với',
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppTheme.heroGradient.createShader(bounds),
                        child: Text(
                          'MoniKid',
                          style: AppTheme.displayLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingSM),
                      Text(
                        'Quản lý tiền tiêu vặt thông minh\ncho cả gia đình',
                        textAlign: TextAlign.center,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondaryLight,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section with Buttons
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusXXL),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Login Button
                    AppPrimaryButton(
                      text: 'Đăng nhập',
                      icon: Icons.login,
                      onPressed: () => context.go(AppRoutes.login),
                    ),
                    const SizedBox(height: AppTheme.spacingMD),

                    // Register Button
                    AppSecondaryButton(
                      text: 'Tạo tài khoản mới',
                      icon: Icons.person_add_outlined,
                      onPressed: () => context.go(AppRoutes.register),
                    ),

                    const SizedBox(height: AppTheme.spacingLG),

                    // Terms text
                    Text.rich(
                      TextSpan(
                        text: 'Bằng việc tiếp tục, bạn đồng ý với ',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textTertiaryLight,
                        ),
                        children: [
                          TextSpan(
                            text: 'Điều khoản sử dụng',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: ' và '),
                          TextSpan(
                            text: 'Chính sách bảo mật',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String label, Gradient gradient) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: AppTheme.borderRadiusMD,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
