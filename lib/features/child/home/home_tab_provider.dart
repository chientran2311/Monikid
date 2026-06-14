import 'dart:async';

import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_state.dart';
import 'package:monikid/features/notification_settings/notification_settings_provider.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';
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
    if (state.status == HomeTabStatus.loading ||
        state.status == HomeTabStatus.success) {
      return;
    }
    // Chạy song song: test Gemini không block việc fetch data
    unawaited(_testGeminiConnection());
    await refresh();
  }

  Future<void> _testGeminiConnection() async {
    _logger.i('Testing Gemini AI connection on home tab init.');
    try {
      final result = await _geminiService.testConnection();
      if (result != null) {
        _logger.d('Gemini connection test successful. Response: $result');
      } else {
        _logger.d(
          'Gemini connection test returned null (no API key or failed).',
        );
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
      _logger.w('HomeTabNotifier.refresh() aborted: no authenticated user.');
      state = const HomeTabState(
        status: HomeTabStatus.error,
        errorMessage: 'Missing authenticated user.',
      );
      return;
    }

    _logger.i('HomeTabNotifier.refresh() start. userId=${user.uid}');
    state = state.copyWith(status: HomeTabStatus.loading, errorMessage: null);

    try {
      final repository = ref.read(transactionRepositoryProvider);

      // Bước 1: subscribe stream giao dịch tháng hiện tại
      await ref
          .read(transactionHistoryProvider.notifier)
          .refreshSharedTransactions();
      final sharedState = ref.read(transactionHistoryProvider);
      _logger.d(
        'HomeTab shared tx status=${sharedState.sharedStatus.name} '
        'monthlyCount=${sharedState.monthlyTransactions.length}',
      );

      if (sharedState.sharedStatus == TransactionHistorySharedStatus.error) {
        final sharedError = sharedState.sharedErrorMessage;
        _logger.e(
          'HomeTab shared transaction load failed. userId=${user.uid} '
          'sharedError=$sharedError',
        );
        state = state.copyWith(
          status: HomeTabStatus.error,
          errorMessage: sharedError ?? 'Unable to load recent transactions.',
        );
        return;
      }

      // Bước 2: one-shot query tổng thu/chi tháng này
      final summary = await repository.getSummary(
        user.uid,
        month: DateTime.now(),
      );
      _logger.i(
        'HomeTab getSummary result: '
        'income=${summary?.totalIncome} expense=${summary?.totalExpense} '
        'userId=${user.uid} month=${DateTime.now().year}-${DateTime.now().month}',
      );

      if (summary == null) {
        _logger.e('HomeTab getSummary returned null → setting error state.');
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
      _logger.i(
        'HomeTabNotifier.refresh() done. '
        'income=${summary.totalIncome} expense=${summary.totalExpense}',
      );
      unawaited(_syncNotificationData(
        expenseMinor: summary.totalExpense.round(),
        limitMinor: ref.read(authSessionProvider).account?.monthlyLimit ?? 0,
      ));
    } catch (error, stackTrace) {
      _logger.e(
        'HomeTabNotifier.refresh() failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: HomeTabStatus.error,
        errorMessage: 'Unable to load home dashboard data.',
      );
    }
  }

  Future<void> _syncNotificationData({
    required int expenseMinor,
    required int limitMinor,
  }) async {
    try {
      await getIt<NotificationRepository>().saveChildData(
        expenseMinor: expenseMinor,
        limitMinor: limitMinor,
      );
      await ref
          .read(notificationSettingsNotifierProvider.notifier)
          .rescheduleIfEnabled();
    } catch (error, stackTrace) {
      _logger.w(
        'HomeTabNotifier._syncNotificationData failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
