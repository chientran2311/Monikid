import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'home_tab_state.freezed.dart';

@freezed
abstract class HomeTabState with _$HomeTabState {
  const HomeTabState._();

  const factory HomeTabState({
    required List<TransactionModel> transactions,
    @Default(false) bool isLoading,
  }) = _HomeTabState;

  bool get isEmpty => transactions.isEmpty;
}
