import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'dart:async'; // Dùng cho Timer chuyển trang
import 'package:monikid/core/theme/theme.dart';
// --- PHẦN 2: MÀN HÌNH SPLASH ---

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // Đợi 3 giây để hiển thị splash, sau đó check auth và navigate
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateBasedOnAuth();
      }
    });
  }
  
  void _navigateBasedOnAuth() {
    final authState = ref.read(authProvider);
    
    if (authState.isAuthenticated) {
      // Đã đăng nhập -> đi tới Home
      context.go(AppRoutes.parentHome);
    } else {
      // Chưa đăng nhập -> đi tới Onboarding hoặc Login
      // TODO: Check first time user để show onboarding
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình để responsive logo
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.background,
      // Sử dụng SafeArea để version không bị đè bởi thanh điều hướng cử chỉ
      body: SafeArea(
        child: Column(
          children: [
            
            // --- PHẦN CHÍNH: LOGO & APP NAME ---
            // Dùng Expanded như bạn yêu cầu để đẩy nội dung này chiếm phần lớn không gian
            Expanded(
              flex: 4, // Chiếm 4 phần không gian (đẩy nội dung footer xuống)
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.inputBackground,
                        borderRadius: BorderRadius.circular(24),
                        // Hiệu ứng đổ bóng Glow nhẹ phía sau logo
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryGreen.withOpacity(0.15),
                            blurRadius: 40,
                            spreadRadius: 10,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      // Icon con heo đất (Savings)
                      child: const Icon(
                        Icons.savings_rounded, 
                        color: AppTheme.primaryGreen, 
                        size: 50
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Tên App
                    const Text(
                      "MoniKid",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textWhite,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Slogan
                    Text(
                      "SMART FINANCE FOR FAMILY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textGrey.withOpacity(0.8),
                        letterSpacing: 2.0, // Giãn chữ ra cho sang trọng
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- PHẦN CHÂN: LOADING & VERSION ---
            // Dùng Expanded flex nhỏ hơn hoặc Container để chứa phần đáy
            Expanded(
              flex: 1, // Chiếm 1 phần không gian phía dưới
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Căn về đáy
                children: [
                  // Text Loading
                  const Text(
                    "Securing environment...",
                    style: TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Custom Loading Bar
                  // Dùng SizedBox để giới hạn chiều rộng của thanh loading cho đẹp
                  SizedBox(
                    width: size.width * 0.6, // Rộng 60% màn hình
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        minHeight: 6, // Độ dày thanh loading
                        backgroundColor: AppTheme.inputBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                        // value: 0.7, // Nếu muốn chỉnh % cụ thể, bỏ comment dòng này
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Version Text
                  Text(
                    "v1.0.0",
                    style: TextStyle(
                      color: AppTheme.textGrey.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 20), // Padding đáy một chút
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}