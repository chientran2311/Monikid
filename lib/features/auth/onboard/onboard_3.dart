import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/onboard/widget/onboarding_indicator.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class Onboard3Screen extends StatelessWidget {
  const Onboard3Screen({Key? key}) : super(key: key);

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
                  // Spacer bù cho nút Skip (Trang cuối không cần nút Skip ở góc)
                  const SizedBox(height: 48),

                  // IMAGE (Em bé nhảy/Coins)
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Container(
                        width: size.width * 0.9,
                        height: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: AppTheme.inputBackground,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Icon(Icons.emoji_events_rounded, size: 100, color: Colors.orangeAccent),
                        // Thay bằng Image.asset('assets/img3.png')
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // INDICATOR
                  const OnboardingIndicator(activeIndex: 2), // Index 2

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
                              TextSpan(text: "Learning Through "),
                              TextSpan(text: "Fun", style: TextStyle(color: AppTheme.primaryGreen)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Turn daily chores into exciting missions. Kids earn rewards for completing tasks.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textGrey, fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  ),

                  // FOOTER (Button + Login Text)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        PrimaryButton(
                          text: "Get Started",
                          onPressed: () {
                            context.go(AppRoutes.register);
                          },
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            context.go(AppRoutes.login);
                          },
                          child: const Text(
                            "Already have an account? Login",
                            style: TextStyle(color: AppTheme.textGrey, fontSize: 13),
                          ),
                        )
                      ],
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