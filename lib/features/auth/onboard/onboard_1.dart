import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/features/auth/onboard/widget/onboarding_indicator.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
class Onboard1Screen extends StatelessWidget {
  const Onboard1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // 1. SKIP BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () { context.go(AppRoutes.login); },
                      child: const Text("Skip", style: TextStyle(color: AppTheme.textGrey)),
                    ),
                  ),

                  // 2. IMAGE AREA (Responsive flex)
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Container(
                        width: size.width * 0.85,
                        height: size.width * 0.85, // Giữ tỷ lệ vuông
                        decoration: BoxDecoration(
                          color: AppTheme.inputBackground,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        // Thay Icon bằng Image.asset('assets/img1.png')
                        child: Icon(Icons.savings_rounded, size: 100, color: AppTheme.primaryGreen.withOpacity(0.8)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 3. INDICATOR
                  const OnboardingIndicator(activeIndex: 0), // Index 0

                  const SizedBox(height: 30),

                  // 4. TEXT CONTENT
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.3, color: AppTheme.textWhite),
                            children: [
                              TextSpan(text: "Empower Your Kids'\n"),
                              TextSpan(text: "Financial Future", style: TextStyle(color: AppTheme.primaryGreen)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Teach them the value of money with interactive lessons and safe spending limits.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textGrey, fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  ),

                  // 5. BUTTON
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: PrimaryButton(
                      text: "Next",
                      onPressed: () {
                        context.push(AppRoutes.onboard2);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}