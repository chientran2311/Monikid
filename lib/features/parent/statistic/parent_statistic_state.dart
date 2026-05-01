enum ParentStatisticPeriod { week, month }

class ParentStatisticState {
  const ParentStatisticState({
    this.period = ParentStatisticPeriod.week,
  });

  final ParentStatisticPeriod period;

  ParentStatisticState copyWith({ParentStatisticPeriod? period}) {
    return ParentStatisticState(period: period ?? this.period);
  }
}
