import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';

import 'home_tab_state.dart';

part 'home_tab_provider.g.dart';

@riverpod
class HomeTabNotifier extends _$HomeTabNotifier {
  @override
  FutureOr<HomeTabState> build() async {
    final txs = await _fetchPage();
    return HomeTabState(transactions: txs, isLoading: false);
  }

  Future<List<TransactionModel>> _fetchPage() async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return [];
    }

    final repo = getIt<TransactionRepository>();
    return await repo.getRecentTransactionsPaginated(
      authState.user!.uid,
      limit: 4,
    );
  }

  Future<void> refresh() async {
    final currentState = state.valueOrNull;

    // Nếu đang loading thì không load thêm nữa
    if (currentState != null && currentState.isLoading) return;

    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(isLoading: true));
    } else {
      state = const AsyncLoading();
    }

    try {
      final txs = await _fetchPage();
      state = AsyncValue.data(
        HomeTabState(transactions: txs, isLoading: false),
      );
    } catch (e, stack) {
      print('Error refreshing transactions: $e');
      if (currentState != null) {
        state = AsyncValue.data(currentState.copyWith(isLoading: false));
      } else {
        state = AsyncValue.error(e, stack);
      }
    }
  }
}

@riverpod
Stream<List<TransactionModel>> transactionStream(TransactionStreamRef ref) {
  final authState = ref.watch(authProvider);
  if (authState.isAuthenticated && authState.user != null) {
    return getIt<TransactionRepository>()
        .getTransactionsByMonth(authState.user!.uid, DateTime.now(), limit: 4)
        .map((record) => record.transactions)
        .handleError((error) {
          print('❌ Firebase Index Error (Click link below to create):');
          print(error.toString());
        });
  }
  return const Stream.empty();
}
