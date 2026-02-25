import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<Widget> children;
  final Color surfaceColor;
  final Color borderColor;
  final bool isDark;

  const SettingGroup({
    Key? key,
    required this.title,
    required this.titleColor,
    required this.children,
    required this.surfaceColor,
    required this.borderColor,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
