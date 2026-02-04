import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/home/widgets/dashboard_header.dart';
import 'package:monikid/features/home/widgets/data_explorer_grid.dart';
import 'package:monikid/features/home/widgets/quick_actions_grid.dart';
import 'package:monikid/features/home/widgets/section_title.dart';
import 'package:monikid/features/home/widgets/system_status_card.dart';
import 'package:monikid/share/widgets/floating_navbar.dart' show FloatingNavBar;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    ),
  );
}

// ==========================================
// 1. MAIN SCREEN
// ==========================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable Content
          SafeArea(
            bottom: false, // Để nội dung chìm xuống dưới navbar
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                100,
              ), // Bottom padding cho navbar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  // 1. Header
                  DashboardHeader(),
                  SizedBox(height: 24),

                  // 2. System Status
                  SystemStatusCard(),
                  SizedBox(height: 32),

                  // 3. Data Explorer Section
                  SectionTitle(title: "Data Explorer"),
                  SizedBox(height: 16),
                  DataExplorerGrid(),
                  SizedBox(height: 32),

                  // 4. Quick Actions Section
                  SectionTitle(title: "Quick Actions"),
                  SizedBox(height: 16),
                  QuickActionsGrid(),
                ],
              ),
            ),
          ),

          // Floating Navigation Bar (Positioned at bottom)
          const Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
