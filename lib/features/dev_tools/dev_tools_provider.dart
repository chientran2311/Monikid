import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/dev_tools/dev_tools_state.dart';
import 'package:monikid/repositories/dev_tools/dev_tools_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dev_tools_provider.g.dart';

@riverpod
class DevToolsNotifier extends _$DevToolsNotifier {
  late Logger _logger;
  late DevToolsRepository _repository;

  @override
  DevToolsState build() {
    _logger = getIt<Logger>();
    _repository = ref.read(devToolsRepositoryProvider);
    return const DevToolsState();
  }

  void updateDate(DateTime date) {
    if (date.isAfter(DateTime.now())) return;
    state = state.copyWith(selectedDate: date);
  }

  void updateTransactionType(String type) {
    final defaultCategoryId =
        type == 'expense' ? 'expense-an-uong' : 'income-tien-tieu-vat';
    state = state.copyWith(
      transactionType: type,
      selectedCategoryId: defaultCategoryId,
      txStatus: DevToolsOpStatus.initial,
      txMessage: null,
    );
  }

  void updateCategory(String categoryId) {
    state = state.copyWith(selectedCategoryId: categoryId);
  }

  Future<void> seedMockFaq() async {
    _logger.d('DevToolsNotifier.seedMockFaq: start.');
    state = state.copyWith(faqStatus: DevToolsOpStatus.loading, faqMessage: null);
    try {
      final count = await _repository.seedMockFaq();
      _logger.i('DevToolsNotifier.seedMockFaq: success. count=$count');
      state = state.copyWith(
        faqStatus: DevToolsOpStatus.success,
        faqMessage: '$count FAQ items seeded successfully.',
      );
    } catch (error, stackTrace) {
      _logger.e('DevToolsNotifier.seedMockFaq failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        faqStatus: DevToolsOpStatus.error,
        faqMessage: 'Failed to seed FAQ: $error',
      );
    }
  }

  Future<void> addMockTransaction() async {
    final userId = ref.read(authSessionProvider).user?.uid;
    if (userId == null) {
      state = state.copyWith(
        txStatus: DevToolsOpStatus.error,
        txMessage: 'No authenticated user.',
      );
      return;
    }

    final date = state.selectedDate ?? DateTime.now();
    final category = defaultCategories.firstWhere(
      (c) => c.id == state.selectedCategoryId,
      orElse: () => defaultCategories.first,
    );

    _logger.d('DevToolsNotifier.addMockTransaction: start. userId=$userId, type=${state.transactionType}');
    state = state.copyWith(txStatus: DevToolsOpStatus.loading, txMessage: null);
    try {
      await _repository.addMockTransaction(
        userId: userId,
        date: date,
        type: state.transactionType,
        category: category,
      );
      _logger.i('DevToolsNotifier.addMockTransaction: success.');
      state = state.copyWith(
        txStatus: DevToolsOpStatus.success,
        txMessage: 'Transaction added successfully.',
      );
    } catch (error, stackTrace) {
      _logger.e('DevToolsNotifier.addMockTransaction failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        txStatus: DevToolsOpStatus.error,
        txMessage: 'Failed to add transaction: $error',
      );
    }
  }
}
