import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'transaction_selection_state.freezed.dart';

@freezed
abstract class TransactionSelectionState with _$TransactionSelectionState {
  const factory TransactionSelectionState({
    String? selectedTransactionId,
    TransactionModel? selectedTransaction,
    @Default(false) bool isResolvingSelection,
    String? selectionErrorMessage,
  }) = _TransactionSelectionState;

  const TransactionSelectionState._();

  bool get hasSelectedTransaction =>
      selectedTransactionId != null && selectedTransaction != null;
}
