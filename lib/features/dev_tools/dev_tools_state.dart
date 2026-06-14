import 'package:freezed_annotation/freezed_annotation.dart';

part 'dev_tools_state.freezed.dart';

enum DevToolsOpStatus { initial, loading, success, error }

@freezed
abstract class DevToolsState with _$DevToolsState {
  const factory DevToolsState({
    @Default(DevToolsOpStatus.initial) DevToolsOpStatus faqStatus,
    String? faqMessage,
    @Default(DevToolsOpStatus.initial) DevToolsOpStatus txStatus,
    String? txMessage,
    DateTime? selectedDate,
    @Default('expense') String transactionType,
    @Default('expense-an-uong') String selectedCategoryId,
  }) = _DevToolsState;

  const DevToolsState._();

  bool get isFaqBusy => faqStatus == DevToolsOpStatus.loading;
  bool get isTxBusy => txStatus == DevToolsOpStatus.loading;
}
