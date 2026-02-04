import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Model dữ liệu cho Grid
class ExplorerItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? tag;

  const ExplorerItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.tag,
  });
}

/// Lưới Data Explorer (Posts, Comments...)
class DataExplorerGrid extends StatelessWidget {
  const DataExplorerGrid({super.key});

  static const List<ExplorerItem> _defaultItems = [
    ExplorerItem(
      title: "Posts (100)",
      subtitle: "Explore community feeds",
      icon: Icons.description,
      color: AppColors.accentBlue,
      tag: "#JSON",
    ),
    ExplorerItem(
      title: "Comments",
      subtitle: "View discussions",
      icon: Icons.chat_bubble,
      color: AppColors.accentPurple,
      tag: "500",
    ),
    ExplorerItem(
      title: "Albums (100)",
      subtitle: "Curated collections",
      icon: Icons.photo_library,
      color: AppColors.accentPink,
    ),
    ExplorerItem(
      title: "Photos (5k)",
      subtitle: "Full image gallery",
      icon: Icons.image,
      color: AppColors.accentOrange,
    ),
    ExplorerItem(
      title: "Todos (200)",
      subtitle: "Task lists",
      icon: Icons.checklist,
      color: AppColors.accentGreen,
    ),
    ExplorerItem(
      title: "Users (10)",
      subtitle: "User profiles",
      icon: Icons.people,
      color: AppColors.accentTeal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: _defaultItems.length,
      itemBuilder: (context, index) {
        return ExplorerCard(item: _defaultItems[index]);
      },
    );
  }
}

/// Widget hiển thị từng ô trong Grid
class ExplorerCard extends StatelessWidget {
  final ExplorerItem item;

  const ExplorerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: item.color, size: 18),
              ),
              // Tag (nếu có)
              if (item.tag != null)
                Text(
                  item.tag!,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            item.title,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 11,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
