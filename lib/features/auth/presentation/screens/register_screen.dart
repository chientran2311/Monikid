import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/shared/widgets/app_buttons.dart';
import 'package:monikid/shared/widgets/app_inputs.dart';
import 'package:monikid/features/auth/presentation/controllers/auth_controller.dart';
import 'package:monikid/features/auth/presentation/widgets/register/role_card.dart'; // Import Widget vừa tách
import 'package:monikid/features/auth/presentation/widgets/register/verify_phone_dialog.dart'; // Import Widget vừa tách

enum UserRole { parent, child }

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // State
  UserRole _selectedRole = UserRole.parent;
  bool _isPhoneVerified = false;
  bool _isVerifyingPhone = false;
  int _currentStep = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- Logic Handlers ---

  Future<void> _handleVerifyPhone() async {
    if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SĐT không hợp lệ')),
      );
      return;
    }

    setState(() => _isVerifyingPhone = true);

    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock API delay
      if (!mounted) return;

      final verified = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => VerifyPhoneDialog(phoneNumber: _phoneController.text),
      );

      if (verified == true) {
        setState(() => _isPhoneVerified = true);
      }
    } finally {
      if (mounted) setState(() => _isVerifyingPhone = false);
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_isPhoneVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng xác thực số điện thoại')),
      );
      return;
    }

    // Gọi Controller đăng ký
    // Chuyển enum UserRole thành String ('parent'/'child') cho Supabase
    final roleString = _selectedRole == UserRole.parent ? 'parent' : 'child';

    await ref.read(authControllerProvider.notifier).register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      role: roleString,
    );
  }

  // --- UI Build ---

  @override
  Widget build(BuildContext context) {
    // Lắng nghe state từ Controller để xử lý loading/error/success
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString()), backgroundColor: AppTheme.accentRed),
          );
        },
        data: (_) {
          // Thành công -> Điều hướng
          context.go(AppRoutes.parentBank); 
        },
      );
    });

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => _currentStep == 0 
              ? context.go(AppRoutes.welcome) 
              : setState(() => _currentStep = 0),
        ),
        title: const Text('Tạo tài khoản'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Progress Bar
                LinearProgressIndicator(
                  value: (_currentStep + 1) / 2,
                  backgroundColor: AppTheme.gray200,
                  color: AppTheme.primaryColor,
                  borderRadius: AppTheme.borderRadiusFull,
                ),
                const SizedBox(height: AppTheme.spacingLG),

                // Switch Step View
                if (_currentStep == 0) 
                  _buildRoleSelectionStep()
                else 
                  _buildAccountFormStep(isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bạn là ai?', style: AppTheme.displaySmall.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppTheme.spacingSM),
        Text('Chọn vai trò của bạn trong gia đình', style: AppTheme.bodyLarge.copyWith(color: AppTheme.textSecondaryLight)),
        const SizedBox(height: AppTheme.spacingXL),
        
        RoleCard(
          title: 'Phụ huynh',
          description: 'Quản lý tiền tiêu vặt, theo dõi chi tiêu',
          icon: Icons.supervisor_account,
          gradient: AppTheme.parentGradient,
          isSelected: _selectedRole == UserRole.parent,
          onTap: () => setState(() => _selectedRole = UserRole.parent),
        ),
        const SizedBox(height: AppTheme.spacingMD),
        RoleCard(
          title: 'Con cái',
          description: 'Nhận tiền tiêu vặt, thanh toán QR',
          icon: Icons.child_care,
          gradient: AppTheme.childGradient,
          isSelected: _selectedRole == UserRole.child,
          onTap: () => setState(() => _selectedRole = UserRole.child),
        ),
        const SizedBox(height: AppTheme.spacingXL),
        
        AppPrimaryButton(
          text: 'Tiếp tục',
          onPressed: () => setState(() => _currentStep = 1),
        ),
      ],
    );
  }

  Widget _buildAccountFormStep(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin tài khoản', style: AppTheme.headlineLarge.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppTheme.spacingLG),
        
        AppTextField(
          controller: _fullNameController,
          labelText: 'Họ và tên',
          prefixIcon: Icons.person_outline,
          validator: (v) => v!.isEmpty ? 'Nhập họ tên' : null,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        
        AppTextField(
          controller: _emailController,
          labelText: 'Email',
          prefixIcon: Icons.email_outlined,
          validator: (v) => !v!.contains('@') ? 'Email sai' : null,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        
        AppPhoneField(
          controller: _phoneController,
          isVerified: _isPhoneVerified,
          isVerifying: _isVerifyingPhone,
          onVerify: _handleVerifyPhone,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        
        AppPasswordField(
          controller: _passwordController,
          labelText: 'Mật khẩu',
          validator: (v) => v!.length < 6 ? 'Mật khẩu quá ngắn' : null,
        ),
        const SizedBox(height: AppTheme.spacingMD),
        
        AppPasswordField(
          controller: _confirmPasswordController,
          labelText: 'Xác nhận mật khẩu',
          validator: (v) => v != _passwordController.text ? 'Mật khẩu không khớp' : null,
        ),
        const SizedBox(height: AppTheme.spacingXL),
        
        AppPrimaryButton(
          text: 'Đăng ký',
          isLoading: isLoading,
          onPressed: _handleRegister,
        ),
      ],
    );
  }
}