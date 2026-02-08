import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/wallet/transaction.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';

part 'wallet_state.freezed.dart';

/// Wallet loading status
enum WalletStatus {
  initial,
  loading,
  loaded,
  error,
}

/// Main wallet state
@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletStatus.initial) WalletStatus status,
    WalletModel? wallet,
    MockBankAccount? bankAccount,
    @Default([]) List<Transaction> transactions,
    @Default([]) List<FamilyMemberWallet> familyMembers,
    @Default([]) List<MoneyRequest> pendingRequests,
    String? errorMessage,
    @Default(false) bool isTransferring,
  }) = _WalletState;

  const WalletState._();

  bool get isLoading => status == WalletStatus.loading;
  bool get isLoaded => status == WalletStatus.loaded;
  bool get hasError => status == WalletStatus.error;
  
  double get balance => wallet?.balance ?? 0;
  double get bankBalance => bankAccount?.balance ?? 0;
}

/// Transfer state for transfer screen
@freezed
abstract class TransferState with _$TransferState {
  const factory TransferState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
    Transaction? transaction,
  }) = _TransferState;
}
