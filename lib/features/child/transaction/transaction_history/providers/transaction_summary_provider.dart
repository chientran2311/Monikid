import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_summary_provider.g.dart';

@riverpod
Stream<({double totalIncome, double totalExpense})> streamSummaryCard(
  Ref ref, {
  DateTime? date,
  DateTime? month,
  String? categoryKey,
  String? type,
}) {
  final log = getIt<Logger>();
  final uid = ref.watch(authSessionProvider).user?.uid;

  log.i('Loading transaction summary. uid=$uid date=$date month=$month');

  if (uid == null) {
    log.w('No authenticated user found. Returning an empty summary stream.');
    return Stream.value((totalIncome: 0.0, totalExpense: 0.0));
  }

  return ref
      .watch(transactionRepositoryProvider)
      .watchSummary(
        uid,
        date: date,
        month: month,
        categoryKey: categoryKey,
        type: type,
      )
      .map((data) {
        log.d(
          'Transaction summary emitted. income=${data.totalIncome} expense=${data.totalExpense}',
        );
        return data;
      })
      .handleError((error, stackTrace) {
        log.e(
          'Failed to watch the transaction summary stream.',
          error: error,
          stackTrace: stackTrace,
        );
        throw error;
      });
}
