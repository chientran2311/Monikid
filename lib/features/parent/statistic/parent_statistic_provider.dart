import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';

final parentStatisticProvider =
    StateNotifierProvider<ParentStatisticNotifier, ParentStatisticState>(
  (_) => ParentStatisticNotifier(),
);

class ParentStatisticNotifier extends StateNotifier<ParentStatisticState> {
  ParentStatisticNotifier() : super(const ParentStatisticState());

  void setPeriod(ParentStatisticPeriod period) {
    state = state.copyWith(period: period);
  }
}
