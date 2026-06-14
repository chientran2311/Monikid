import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/shared/widgets/switchtab_three_item.dart';

class StatisticPeriodFilterSection extends StatelessWidget {
  const StatisticPeriodFilterSection({
    super.key,
    required this.selectedTabIndex,
    required this.onModeChanged,
  });

  final int selectedTabIndex;
  final ValueChanged<int> onModeChanged;

  @override
  Widget build(BuildContext context) {
    // Visual order: Month | Week | Year
    // Provider monthIndex mapping: Month=1, Week=0, Year=2
    final tabIndex = selectedTabIndex == 0 ? 1 : selectedTabIndex == 1 ? 0 : 2;

    return SwitchTabThreeItem(
      title1: context.l10n.statisticByMonth,
      title2: context.l10n.statisticByWeek,
      title3: context.l10n.statisticByYear,
      selectedIndex: tabIndex,
      onChanged: (i) => onModeChanged(i == 0 ? 1 : i == 1 ? 0 : 2),
    );
  }
}
