import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';

import 'widgets/onboarding_bottom_panel.dart';
import 'widgets/onboarding_page_card.dart';

class OnboardingData {
  const OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  bool _isFinishing = false;

  final List<OnboardingData> _pages = const [
    OnboardingData(
      icon: Icons.edit_document,
      title: 'Ghi chép\nthông minh',
      description: 'Ghi chép mọi khoản thu chi\ndễ dàng chỉ với vài chạm.',
    ),
    OnboardingData(
      icon: Icons.family_restroom_rounded,
      title: 'Kết nối\ngia đình',
      description: 'Phụ huynh dễ dàng theo dõi\nvà đồng hành cùng con.',
    ),
    OnboardingData(
      icon: Icons.savings_rounded,
      title: 'Tiết kiệm\nthông minh',
      description: 'Đặt mục tiêu, nuôi heo đất\nvà xây dựng tương lai.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) {
      return;
    }

    setState(() => _isFinishing = true);
    try {
      await ref.read(onboardingRepositoryProvider).markOnboardingComplete();
      if (mounted) {
        context.go(AppRoutes.login);
      }
    } finally {
      if (mounted) {
        setState(() => _isFinishing = false);
      }
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }

    _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentPageData = _pages[_currentPage];

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: TextButton(
                  onPressed: _isFinishing ? null : _finishOnboarding,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF94A3B8),
                  ),
                  child: Text('Bỏ qua', style: context.typo.subtitle.small),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPageCard(
                    icon: page.icon,
                    isDark: isDark,
                  );
                },
              ),
            ),
            OnboardingBottomPanel(
              title: currentPageData.title,
              description: currentPageData.description,
              currentPage: _currentPage,
              totalPages: _pages.length,
              isDark: isDark,
              isLoading: _isFinishing,
              onContinue: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
