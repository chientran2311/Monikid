
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;

  const SocialButton({Key? key, required this.icon, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.inputBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: 28,
        ),
      ),
    );
  }
}