import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/fqa/fqa_model.dart';

part 'fqa_state.freezed.dart';

@freezed
abstract class FQAState with _$FQAState {
  const factory FQAState({
    @Default([]) List<FQAModel> fqaList,
    @Default(true) bool isLoading,
    String? selectedItemId,
    String? errorMessage,
  }) = _FQAState;

  const FQAState._();
}
