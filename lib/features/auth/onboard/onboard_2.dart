import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/features/auth/onboard/widget/onboarding_indicator.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
class Onboard2Screen extends StatelessWidget {
  const Onboard2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // SKIP
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () { context.go(AppRoutes.login); },
                      child: const Text("Skip", style: TextStyle(color: AppTheme.textGrey)),
                    ),
                  ),

                  // IMAGE (Bản đồ/Vùng an toàn)
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        // Tạo hình chữ nhật bo góc lớn như ảnh mẫu
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.inputBackground,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Icon(Icons.location_on_rounded, size: 80, color: AppTheme.primaryGreen.withOpacity(0.8)),
                        // Thay bằng Image.asset('assets/img2.png', fit: BoxFit.cover)
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // INDICATOR
                  const OnboardingIndicator(activeIndex: 1), // Index 1

                  const SizedBox(height: 30),

                  // TEXT
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.3, color: AppTheme.textWhite),
                            children: [
                              TextSpan(text: "Keep Them "),
                              TextSpan(text: "Safe", style: TextStyle(color: AppTheme.primaryGreen)),
                              TextSpan(text: ",\nAlways"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Know where your children are in real-time. Set up Safe Zones like 'School' or 'Home'.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textGrey, fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  ),

                  // BUTTON
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: PrimaryButton(
                      text: "Next",
                      onPressed: () {
                        context.push(AppRoutes.onboard3);
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