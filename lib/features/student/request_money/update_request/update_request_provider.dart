import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/student/request_money/update_request/update_request_state.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/repositories/request_money/request_money_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_request_provider.g.dart';

@riverpod
class UpdateRequest extends _$UpdateRequest {
  @override
  UpdateRequestState build(RequestMoneyModel initialRequest) {
    return const UpdateRequestState.initial();
  }

  Future<void> submitUpdate(RequestMoneyModel updatedRequest) async {
    state = const UpdateRequestState.loading();
    try {
      final repository = ref.read(requestMoneyRepositoryProvider);
      await repository.updateRequest(updatedRequest);
      state = const UpdateRequestState.success();
    } catch (e, stackTrace) {
      logger.e('Error updating request money', error: e, stackTrace: stackTrace);
      state = UpdateRequestState.error(e.toString());
    }
  }

  Future<void> deleteRequest() async {
    state = const UpdateRequestState.loading();
    try {
      final repository = ref.read(requestMoneyRepositoryProvider);
      await repository.deleteRequest(initialRequest.id);
      state = const UpdateRequestState.deleted();
    } catch (e, stackTrace) {
      logger.e('Error deleting request money', error: e, stackTrace: stackTrace);
      state = UpdateRequestState.error(e.toString());
    }
  }
}
