import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/student/request_money/request_money_history/request_money_history_state.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/repositories/request_money/request_money_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/App/app.dart';

part 'request_money_history_provider.g.dart';

@riverpod
class RequestMoneyHistory extends _$RequestMoneyHistory {
  @override
  RequestMoneyHistoryState build(RequestMoneyModel initialRequest) {
    return RequestMoneyHistoryState(request: initialRequest);
  }

  void updateAmount(double newAmount) {
    if (state.request == null) return;
    state = state.copyWith(
      request: state.request!.copyWith(amount: newAmount)
    );
  }

  void updateCategory(String category) {
    if (state.request == null) return;
    state = state.copyWith(
      request: state.request!.copyWith(category: category)
    );
  }

  void updateNote(String note) {
    if (state.request == null) return;
    state = state.copyWith(
      request: state.request!.copyWith(note: note)
    );
  }

  void toggleRecipient(String recipientId) {
    if (state.request == null) return;
    final currentRecipients = List<String>.from(state.request!.recipients);
    if (currentRecipients.contains(recipientId)) {
      currentRecipients.remove(recipientId);
    } else {
      currentRecipients.add(recipientId);
    }
    state = state.copyWith(
      request: state.request!.copyWith(recipients: currentRecipients)
    );
  }

  Future<void> submitUpdate() async {
    if (state.request == null) return;
    state = state.copyWith(isSaving: true, errorMessage: null, isSuccess: false);
    try {
      final repository = ref.read(requestMoneyRepositoryProvider);
      await repository.updateRequest(state.request!);
      state = state.copyWith(isSaving: false, isSuccess: true);
    } catch (e) {
      logger.e('Error updating request: $e');
      state = state.copyWith(
        isSaving: false,
        errorMessage: s.errorGeneric(e.toString()),
      );
    }
  }

  Future<void> deleteRequest() async {
    if (state.request == null) return;
    state = state.copyWith(isDeleting: true, errorMessage: null, isSuccess: false);
    try {
      final repository = ref.read(requestMoneyRepositoryProvider);
      await repository.deleteRequest(state.request!.id);
      state = state.copyWith(isDeleting: false, isSuccess: true);
    } catch (e) {
      logger.e('Error deleting request: $e');
      state = state.copyWith(
        isDeleting: false,
        errorMessage: s.errorGeneric(e.toString()),
      );
    }
  }
}
