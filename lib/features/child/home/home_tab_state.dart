import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_tab_state.freezed.dart';

enum HomeTabStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

@freezed
abstract class HomeTabState with _$HomeTabState {
  const factory HomeTabState({
    @Default(HomeTabStatus.initial) HomeTabStatus status,
    @Default(0) double monthlyIncome,
    @Default(0) double monthlyExpense,
    String? errorMessage,
  }) = _HomeTabState;

  const HomeTabState._();

  bool get isLoading => status == HomeTabStatus.loading;
  bool get isSuccess => status == HomeTabStatus.success;
  bool get isEmpty => status == HomeTabStatus.empty;
  bool get isError => status == HomeTabStatus.error;
}
