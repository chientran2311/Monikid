import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';

// Import Router và Widgets
import '../../../../app/router.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_inputs.dart';
import 'package:monikid/features/auth/presentation/widgets/login/social_button.dart'; // Import Widget mới tách

// Import Controller
import '../controllers/auth_controller.dart'; 

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Dùng late final để khởi tạo controller 
  // (Thực tế TextEditingController khởi tạo ngay cũng được, nhưng logic sạch thì nên dispose)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // 1. Validate Form
    if (!_formKey.currentState!.validate()) return;

    // 2. Gọi Controller để xử lý logic
    // authControllerProvider.notifier giúp truy cập vào class AuthController
    await ref.read(authControllerProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    // 3. Lắng nghe trạng thái (Loading/Error/Success)
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    // 4. Lắng nghe sự kiện để hiển thị Thông báo hoặc Chuyển trang
    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) {
          // Xử lý thông báo lỗi cho gọn
          final message = error is AsyncError && error.error is String 
              ? error.error 
              : error.toString().replaceAll('Exception: ', '');
              
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message.toString()),
              backgroundColor: AppTheme.accentRed,
            ),
          );
        },
        data: (_) {
          // Đăng nhập thành công -> Router sẽ tự động chuyển hướng nhờ AuthListener
          // Nhưng ta cứ go explicit cho chắc chắn UX
          context.go(AppRoutes.parentBank); // Hoặc AppRoutes.home tùy luồng
        },
      );
    });

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => context.go(AppRoutes.welcome),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppTheme.spacingMD),

                // --- Header ---
                Text(
                  'Đăng nhập',
                  style: AppTheme.displaySmall.copyWith(
                    color: AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSM),
                Text(
                  'Chào mừng bạn quay trở lại!',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // --- Inputs ---
                AppTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Nhập email của bạn',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Vui lòng nhập email';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) return 'Email không hợp lệ';
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingMD),

                AppPasswordField(
                  controller: _passwordController,
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu';
                    if (value.length < 6) return 'Mật khẩu phải từ 6 ký tự';
                    return null;
                  },
                ),

                const SizedBox(height: AppTheme.spacingSM),

                // --- Forgot Password ---
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.forgotPassword),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Quên mật khẩu?',
                      style: AppTheme.labelLarge.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingLG),

                // --- Main Button ---
                AppPrimaryButton(
                  text: 'Đăng nhập',
                  isLoading: isLoading,
                  onPressed: _handleLogin,
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // --- Divider ---
                Row(
                  children: [
                    Expanded(child: Divider(color: AppTheme.gray300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMD),
                      child: Text(
                        'hoặc',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textTertiaryLight,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppTheme.gray300)),
                  ],
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // --- Social Buttons (Đã tách Widget) ---
                SocialButton(
                  icon: Icons.g_mobiledata, // Hoặc icon Google SVG nếu có
                  text: 'Tiếp tục với Google',
                  onPressed: () {
                    // TODO: Implement Google Sign In
                  },
                ),

                const SizedBox(height: AppTheme.spacingMD),

                // --- Register Link ---
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản? ',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.register),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Đăng ký ngay',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMD),
              ],
            ),
          ),
        ),
      ),
    );
  }
}