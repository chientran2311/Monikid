import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/router/router_config.dart';
import 'package:monikid/core/theme/theme.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // User Avatar
            const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.cardFill,
              child: Icon(Icons.person, color: AppColors.textGrey),
            ),
            // Notification Icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.cardFill,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.go(AppRoutes.home);
                    },
                    icon: Icon(Icons.notifications),
                    color: AppColors.textWhite,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.cardFill,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.go(AppRoutes.settings);
                    },
                    icon: Icon(Icons.settings),
                    color: AppColors.textWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Home Dashboard",
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
