import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/router/router_config.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/share/widgets/custom_input_widget.dart';
import 'package:monikid/share/widgets/primary_buttons.dart';
import 'package:monikid/share/widgets/soicial_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [_appbarWidget(context), _bodyWidget(context)]),
      ),
    );
  }

  Widget _appbarWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          Center(
            child: Expanded(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.inputFill,
            ),
            child: const Icon(Icons.hub, color: AppColors.primary, size: 40),
          ),
          const SizedBox(height: 30),
          const Text(
            'Welcome Back',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explore Json data seamlessly',
            style: TextStyle(color: AppColors.textGrey, fontSize: 16),
          ),
          const SizedBox(height: 40),
          CustomLabelInput(
            label: "Email or Username",
            hintText: "name@example.com",
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          CustomLabelInput(
            label: "Password",
            hintText: "••••••••",
            isPassword: true,
          ),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Main Button
          PrimaryButton(
            text: "Login",
            onPressed: () => context.go(AppRoutes.home),
          ),

          const SizedBox(height: 30),

          // Divider
          const OrDivider(),

          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: SocialButton(
                  text: "Apple",
                  icon: Icons.apple,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SocialButton(
                  text: "Google",
                  // Dùng icon tạm vì không có assets, thực tế dùng SVG
                  icon: Icons.g_mobiledata,
                  isGoogle: true,
                  onPressed: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: AppColors.textGrey),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: Colors.white10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "OR CONTINUE WITH",
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white10)),
      ],
    );
  }
}
