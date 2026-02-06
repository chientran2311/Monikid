import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Container với decoration để tạo hiệu ứng mờ nền (giả lập iOS blur)
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight.withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.dividerLight, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Navigation Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Title
                const Text(
                  "Posts",
                  style: TextStyle(
                    color: AppColors.textMainLight,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // More Button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, color: AppColors.primary),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.inputBgLight.withOpacity(0.5),
                hintText: "Search posts...",
                hintStyle: const TextStyle(color: AppColors.textSubLight),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSubLight,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
