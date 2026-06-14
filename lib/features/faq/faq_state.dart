import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/faq/faq_model.dart';

part 'faq_state.freezed.dart';

@freezed
abstract class FAQState with _$FAQState {
  const factory FAQState({
    @Default([]) List<FAQModel> faqList,
    @Default(true) bool isLoading,
    String? selectedItemId,
    String? errorMessage,
  }) = _FAQState;

  const FAQState._();
}
