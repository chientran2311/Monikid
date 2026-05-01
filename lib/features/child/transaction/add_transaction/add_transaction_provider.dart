import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_evidence_storage.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'add_transaction_state.dart';

part 'add_transaction_provider.g.dart';

@riverpod
class AddTransactionNotifier extends _$AddTransactionNotifier {
  late final TransactionRepository _repository;
  late final Logger _logger;

  @override
  AddTransactionState build() {
    _repository = ref.read(transactionRepositoryProvider);
    _logger = getIt<Logger>();
    return const AddTransactionState();
  }

  void setEvidenceImage({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) {
    state = state.copyWith(
      evidenceImageBytes: bytes,
      evidenceImageFileName: fileName,
      evidenceImageMimeType: mimeType,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  void clearEvidenceImage() {
    state = state.copyWith(
      evidenceImageBytes: null,
      evidenceImageFileName: null,
      evidenceImageMimeType: null,
      status: TransactionStatus.ready,
      errorMessage: null,
    );
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    state = state.copyWith(
      status: TransactionStatus.loading,
      errorMessage: null,
    );

    try {
      _logger.i('Adding transaction ${transaction.transactionId}');
      final evidenceUpload = state.hasEvidenceImageSelection
          ? TransactionEvidenceUploadPayload(
              bytes: state.evidenceImageBytes!,
              fileName: state.evidenceImageFileName!,
              mimeType: state.evidenceImageMimeType!,
              categoryKey: transaction.categoryKey,
            )
          : null;
      await _repository.addTransaction(
        transaction,
        evidenceUpload: evidenceUpload,
      );
      state = state.copyWith(
        status: TransactionStatus.success,
        errorMessage: null,
      );
    } on TimeoutException catch (error, stackTrace) {
      _logger.e(
        'Add transaction evidence upload timed out.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.transactionEvidenceUploadTimeout,
      );
    } on FirebaseException catch (error, stackTrace) {
      _logger.e(
        'Add transaction firebase failure.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: _resolveFirebaseErrorMessage(error),
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Add transaction failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: TransactionStatus.error,
        errorMessage: s.addTransactionFailed,
      );
    }
  }

  String _resolveFirebaseErrorMessage(FirebaseException error) {
    if (error.code == 'permission-denied') {
      if (state.hasEvidenceImageSelection) {
        return s.transactionEvidencePermissionDenied;
      }
      return s.transactionPermissionDenied;
    }

    if (error.message != null && error.message!.trim().isNotEmpty) {
      return error.message!;
    }

    return s.addTransactionFailed;
  }
}
