import 'package:flutter/cupertino.dart';
import 'package:monikid/core/theme/theme.dart';

class AppIosSwitch extends StatelessWidget {
  const AppIosSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor = AppTheme.primary,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.85,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        inactiveTrackColor: const Color(0xFFE5E5EA),
      ),
    );
  }
}
