import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Gradient nhẹ để tạo chiều sâu
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen,
            AppTheme.surface,
            AppTheme.surface.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(color: AppTheme.textGrey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "\$12,450.00",
                style: TextStyle(
                  color: AppTheme.textWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Icon mắt (ẩn hiện số dư)
              Icon(Icons.visibility_outlined, color: AppTheme .textGrey.withOpacity(0.5)),
            ],
          ),
          const SizedBox(height: 24),
          // Divider ảo
          Container(height: 1, color: Colors.white10),
          const SizedBox(height: 16),
          // Thông tin phụ
          Row(
            children: const [
              Icon(Icons.trending_up, color: AppTheme.primaryGreen, size: 16),
              SizedBox(width: 4),
              Text(
                "+ \$450.00 this month",
                style: TextStyle(color: AppTheme.primaryGreen, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}