import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/repositories/set_money_limit/set_money_limit_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'set_money_limit_state.dart';

part 'set_money_limit_provider.g.dart';

@Riverpod(keepAlive: true)
class SetMoneyLimitNotifier extends _$SetMoneyLimitNotifier {
  late final Logger _logger;
  late final NumberFormat _numberFormat;

  @override
  SetMoneyLimitState build() {
    _logger = getIt<Logger>();
    _numberFormat = NumberFormat.decimalPattern('vi_VN');
    return const SetMoneyLimitState();
  }

  Future<void> onInit() async {
    final currentUserId = ref.read(authSessionProvider).user?.uid;
    if (currentUserId == null) {
      state = state.copyWith(
        status: SetMoneyLimitStatus.error,
        userId: null,
        storedLimitMinor: null,
        amountInput: '',
        validationError: SetMoneyLimitValidationError.unauthenticated,
      );
      return;
    }

    if (state.userId == currentUserId && state.isReady) {
      return;
    }

    await loadCurrentLimit();
  }

  Future<void> loadCurrentLimit() async {
    final currentUserId = ref.read(authSessionProvider).user?.uid;
    if (currentUserId == null) {
      state = state.copyWith(
        status: SetMoneyLimitStatus.error,
        userId: null,
        storedLimitMinor: null,
        amountInput: '',
        validationError: SetMoneyLimitValidationError.unauthenticated,
      );
      return;
    }

    state = state.copyWith(
      status: SetMoneyLimitStatus.loading,
      userId: currentUserId,
      validationError: null,
    );

    try {
      final repository = ref.read(setMoneyLimitRepositoryProvider);
      final storedLimitMinor = await repository.readMonthlyLimitMinor(
        currentUserId,
      );

      state = state.copyWith(
        status: SetMoneyLimitStatus.ready,
        userId: currentUserId,
        storedLimitMinor: storedLimitMinor,
        amountInput: storedLimitMinor == null
            ? ''
            : _formatPlainNumber(storedLimitMinor),
        validationError: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load the set money limit state.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: SetMoneyLimitStatus.error,
        validationError: SetMoneyLimitValidationError.saveFailed,
      );
    }
  }

  void prepareDraft() {
    state = state.copyWith(
      status: SetMoneyLimitStatus.ready,
      amountInput: state.storedLimitMinor == null
          ? ''
          : _formatPlainNumber(state.storedLimitMinor!),
      validationError: null,
    );
  }

  void updateAmountInput(String rawValue) {
    final normalizedValue = _normalizeInput(rawValue);
    state = state.copyWith(
      status: SetMoneyLimitStatus.ready,
      amountInput: normalizedValue,
      validationError: null,
    );
  }

  void addQuickAmount(int incrementMinor) {
    final currentAmount = _parseAmountMinor(state.amountInput) ?? 0;
    final nextAmount = currentAmount + incrementMinor;
    state = state.copyWith(
      status: SetMoneyLimitStatus.ready,
      amountInput: _formatPlainNumber(nextAmount),
      validationError: null,
    );
  }

  Future<bool> save() async {
    final authState = ref.read(authSessionProvider);
    final currentUserId = authState.user?.uid;
    if (currentUserId == null) {
      state = state.copyWith(
        status: SetMoneyLimitStatus.error,
        validationError: SetMoneyLimitValidationError.unauthenticated,
      );
      return false;
    }

    if (authState.account?.familyId != null) {
      _logger.w('Child attempted to self-set limit while in family — blocked.');
      return false;
    }

    final parsedAmountMinor = _parseAmountMinor(state.amountInput);
    if (parsedAmountMinor == null) {
      state = state.copyWith(
        status: SetMoneyLimitStatus.ready,
        validationError: SetMoneyLimitValidationError.empty,
      );
      return false;
    }

    if (parsedAmountMinor <= 0) {
      state = state.copyWith(
        status: SetMoneyLimitStatus.ready,
        validationError: SetMoneyLimitValidationError.nonPositive,
      );
      return false;
    }

    state = state.copyWith(
      status: SetMoneyLimitStatus.saving,
      validationError: null,
    );

    try {
      final repository = ref.read(setMoneyLimitRepositoryProvider);
      await repository.saveMonthlyLimitMinor(
        userId: currentUserId,
        amountMinor: parsedAmountMinor,
      );

      state = state.copyWith(
        status: SetMoneyLimitStatus.success,
        userId: currentUserId,
        storedLimitMinor: parsedAmountMinor,
        amountInput: _formatPlainNumber(parsedAmountMinor),
        validationError: null,
      );
      return true;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to save the set money limit value.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: SetMoneyLimitStatus.error,
        validationError: SetMoneyLimitValidationError.saveFailed,
      );
      return false;
    }
  }

  int? _parseAmountMinor(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }

    return int.tryParse(digitsOnly);
  }

  String _normalizeInput(String rawValue) {
    final parsedAmountMinor = _parseAmountMinor(rawValue);
    if (parsedAmountMinor == null) {
      return '';
    }

    return _formatPlainNumber(parsedAmountMinor);
  }

  String _formatPlainNumber(int amountMinor) {
    return _numberFormat.format(amountMinor);
  }
}
