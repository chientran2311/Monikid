import 'package:flutter/cupertino.dart';
import 'package:monikid/core/theme/theme.dart';

class AppIosSwitch extends StatelessWidget {
  const AppIosSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor = AppTheme.primary,
    this.scale = 0.85,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        inactiveTrackColor: AppTheme.iosSystemGrey,
      ),
    );
  }
}
