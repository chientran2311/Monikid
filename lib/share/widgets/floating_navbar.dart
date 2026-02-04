import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: AppColors.primary, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textGrey, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.bar_chart,
              color: AppColors.textGrey,
              size: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.textGrey, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
