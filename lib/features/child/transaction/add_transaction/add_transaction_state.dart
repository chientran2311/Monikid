import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';

part 'add_transaction_state.freezed.dart';

@freezed
abstract class AddTransactionState with _$AddTransactionState {
  const factory AddTransactionState({
    @Default(TransactionStatus.initial) TransactionStatus status,
    String? errorMessage,
    Uint8List? evidenceImageBytes,
    String? evidenceImageFileName,
    String? evidenceImageMimeType,
    String? evidenceImageFilePath,
  }) = _AddTransactionState;

  const AddTransactionState._();

  bool get isLoading => status == TransactionStatus.loading;
  bool get isBusy => isLoading;
  bool get hasEvidenceImageSelection =>
      evidenceImageBytes != null &&
      evidenceImageFileName != null &&
      evidenceImageMimeType != null;
}
