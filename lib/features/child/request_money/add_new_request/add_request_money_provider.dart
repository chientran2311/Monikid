import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/request_money/add_new_request/add_request_money_state.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/repositories/request_money/request_money_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/app/app.dart';
import 'package:uuid/uuid.dart';

part 'add_request_money_provider.g.dart';

@riverpod
class AddRequestMoney extends _$AddRequestMoney {
  @override
  AddRequestMoneyState build() {
    return const AddRequestMoneyState();
  }

  void updateAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateNote(String note) {
    state = state.copyWith(note: note);
  }

  void toggleRecipient(String recipientId) {
    final currentRecipients = List<String>.from(state.recipients);
    if (currentRecipients.contains(recipientId)) {
      currentRecipients.remove(recipientId);
    } else {
      currentRecipients.add(recipientId);
    }
    state = state.copyWith(recipients: currentRecipients);
  }

  Future<void> submitRequest() async {
    if (state.amount <= 0) {
      state = state.copyWith(errorMessage: 'Số tiền phải lớn hơn 0');
      return;
    }
    if (state.recipients.isEmpty) {
      state = state.copyWith(errorMessage: 'Vui lòng chọn người nhận');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    try {
      final repository = ref.read(requestMoneyRepositoryProvider);
      final authState = ref.read(authSessionProvider);
      
      final studentId = authState.user?.uid ?? '';
      // Fetch linkedParentId from Firestore as familyCode
      String familyCode = '';
      if (studentId.isNotEmpty) {
        try {
          final doc = await getIt<FirebaseFirestore>()
              .collection('users')
              .doc(studentId)
              .get();
          familyCode = (doc.data()?['linkedParentId'] as String?) ?? '';
        } catch (e) {
          logger.w('Could not fetch linkedParentId: $e');
        }
      }
      
      final newRequest = RequestMoneyModel(
        id: const Uuid().v4(),
        amount: state.amount,
        category: state.category,
        note: state.note.isNotEmpty ? state.note : null,
        recipients: state.recipients,
        status: 'pending',
        createdAt: DateTime.now(),
        familyCode: familyCode,
        studentId: studentId,
      );

      await repository.createRequest(newRequest);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      logger.e('Error creating request: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: s.errorGeneric(e.toString()),
      );
    }
  }
}
