import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'update_transaction_state.freezed.dart';

@freezed
abstract class UpdateTransactionState with _$UpdateTransactionState {
  const factory UpdateTransactionState({
    String? currentTransactionId,
    TransactionModel? originalTransaction,
    @Default(TransactionStatus.initial) TransactionStatus status,
    @Default([]) List<CategoryModel> categories,
    @Default('') String selectedCategoryKey,
    @Default('') String selectedCategory,
    @Default('') String selectedCategoryEmoji,
    @Default('') String amountText,
    @Default('') String note,
    DateTime? selectedDate,
    @Default(TransactionType.expense) TransactionType transactionType,
    Uint8List? newEvidenceImageBytes,
    String? newEvidenceImageFileName,
    String? newEvidenceImageMimeType,
    String? newEvidenceImageFilePath,
    @Default(false) bool removeExistingEvidenceImage,
    String? errorMessage,
  }) = _UpdateTransactionState;

  const UpdateTransactionState._();

  bool get hasTransaction => originalTransaction != null;
  bool get isLoading => status == TransactionStatus.loading;
  bool get isSubmitting => status == TransactionStatus.submitting;
  bool get isSuccess => status == TransactionStatus.success;
  String get currentType => transactionType.value;
  DateTime get effectiveSelectedDate =>
      selectedDate ?? originalTransaction?.date ?? DateTime.now();
  bool get hasNewEvidenceImageSelection =>
      newEvidenceImageBytes != null &&
      newEvidenceImageFileName != null &&
      newEvidenceImageMimeType != null;
  bool get hasExistingEvidenceImage =>
      originalTransaction?.hasEvidenceImage == true && !removeExistingEvidenceImage;
  String? get effectiveEvidenceImageFileName =>
      newEvidenceImageFileName ?? (hasExistingEvidenceImage ? 'evidence.jpg' : null);
  bool get hasEvidenceUrl => hasExistingEvidenceImage;
  bool get canSubmit => !isLoading && !isSubmitting && hasTransaction;
}
