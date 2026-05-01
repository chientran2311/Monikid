import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'home_tab_state.dart';

part 'home_tab_provider.g.dart';

@riverpod
class HomeTabNotifier extends _$HomeTabNotifier {
  late final Logger _logger;
  late final GeminiAiService _geminiService;

  @override
  HomeTabState build() {
    _logger = getIt<Logger>();
    _geminiService = getIt<GeminiAiService>();
    return const HomeTabState();
  }

  Future<void> onInit() async {
    if (state.status != HomeTabStatus.initial) {
      return;
    }
    await _testGeminiConnection();
    await refresh();
  }

  Future<void> _testGeminiConnection() async {
    _logger.i('Testing Gemini AI connection on home tab init.');
    try {
      final result = await _geminiService.testConnection();
      if (result != null) {
        _logger.d('Gemini connection test successful. Response: $result');
      } else {
        _logger.d('Gemini connection test returned null (no API key or failed).');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Gemini connection test failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> refresh() async {
    final authState = ref.read(authSessionProvider);
    final user = authState.user;
    if (user == null) {
      state = const HomeTabState(
        status: HomeTabStatus.error,
        errorMessage: 'Missing authenticated user.',
      );
      return;
    }

    state = state.copyWith(
      status: HomeTabStatus.loading,
      errorMessage: null,
    );

    try {
      final repository = ref.read(transactionRepositoryProvider);
      await ref.read(transactionHistoryProvider.notifier).refreshSharedTransactions();
      final summary = await repository.getSummary(
        user.uid,
        month: DateTime.now(),
      );

      if (summary == null) {
        state = state.copyWith(
          status: HomeTabStatus.error,
          errorMessage: 'Unable to load home dashboard data.',
        );
        return;
      }

      state = state.copyWith(
        status: HomeTabStatus.success,
        monthlyIncome: summary.totalIncome,
        monthlyExpense: summary.totalExpense,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to refresh home tab data.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: HomeTabStatus.error,
        errorMessage: 'Unable to load home dashboard data.',
      );
    }
  }
}
