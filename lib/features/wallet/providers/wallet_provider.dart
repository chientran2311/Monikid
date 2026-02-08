import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/models/entities/wallet/transaction.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';
import 'package:monikid/repositories/wallet/wallet_repository.dart';
import 'package:monikid/repositories/wallet/wallet_repository_impl.dart';
import 'wallet_state.dart';

part 'wallet_provider.g.dart';

/// Repository provider
@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) {
  return WalletRepositoryImpl();
}

/// Main wallet provider
@Riverpod(keepAlive: true)
class Wallet extends _$Wallet {
  WalletRepository get _repository => ref.read(walletRepositoryProvider);

  @override
  WalletState build() {
    // Schedule async load after build completes
    Future.microtask(() => _loadWalletData());
    return const WalletState();
  }

  /// Load all wallet related data
  Future<void> _loadWalletData() async {
    state = state.copyWith(status: WalletStatus.loading);

    try {
      print('🔍 [WalletProvider] Loading wallet data...');
      final wallet = await _repository.getMyWallet();
      print('🔍 [WalletProvider] Wallet loaded: ${wallet?.balance ?? "NULL"}');
      
      final bankAccount = await _repository.getMyBankAccount();
      print('🔍 [WalletProvider] Bank account loaded: ${bankAccount?.balance ?? "NULL"}');
      
      List<FamilyMemberWallet> familyMembers = [];
      List<Transaction> transactions = [];
      List<MoneyRequest> pendingRequests = [];

      if (wallet != null) {
        // Load transactions
        transactions = await _repository.getTransactions(
          walletId: wallet.id,
          limit: 20,
        );

        // Load family members if has family
        if (wallet.familyId != null) {
          familyMembers = await _repository.getFamilyMembersWithWallets(
            wallet.familyId!,
          );
        }

        // Load pending requests for parent
        if (wallet.walletType == WalletType.parent) {
          pendingRequests = await _repository.getPendingRequests();
        }
      }

      state = state.copyWith(
        status: WalletStatus.loaded,
        wallet: wallet,
        bankAccount: bankAccount,
        transactions: transactions,
        familyMembers: familyMembers,
        pendingRequests: pendingRequests,
        errorMessage: null,
      );
      
      print('✅ [WalletProvider] State updated - Balance: ${state.balance}, Bank: ${state.bankBalance}');
    } catch (e) {
      print('❌ [WalletProvider] Error loading wallet: $e');
      state = state.copyWith(
        status: WalletStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Refresh wallet data
  Future<void> refresh() async {
    await _loadWalletData();
  }

  /// Deposit from bank
  Future<void> deposit({
    required double amount,
    String? description,
  }) async {
    state = state.copyWith(isTransferring: true);

    try {
      final transaction = await _repository.depositFromBank(
        amount: amount,
        description: description,
      );

      // Update local state
      final updatedWallet = state.wallet?.copyWith(
        balance: state.balance + amount,
      );
      final updatedBankAccount = state.bankAccount?.copyWith(
        balance: state.bankBalance - amount,
      );

      state = state.copyWith(
        isTransferring: false,
        wallet: updatedWallet,
        bankAccount: updatedBankAccount,
        transactions: [transaction, ...state.transactions],
      );
    } catch (e) {
      state = state.copyWith(
        isTransferring: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Withdraw to bank
  Future<void> withdraw({
    required double amount,
    String? description,
  }) async {
    state = state.copyWith(isTransferring: true);

    try {
      final transaction = await _repository.withdrawToBank(
        amount: amount,
        description: description,
      );

      // Update local state
      final updatedWallet = state.wallet?.copyWith(
        balance: state.balance - amount,
      );
      final updatedBankAccount = state.bankAccount?.copyWith(
        balance: state.bankBalance + amount,
      );

      state = state.copyWith(
        isTransferring: false,
        wallet: updatedWallet,
        bankAccount: updatedBankAccount,
        transactions: [transaction, ...state.transactions],
      );
    } catch (e) {
      state = state.copyWith(
        isTransferring: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Transfer to another wallet
  Future<void> transfer({
    required String toWalletId,
    required double amount,
    String? description,
  }) async {
    state = state.copyWith(isTransferring: true);

    try {
      final transaction = await _repository.transfer(
        toWalletId: toWalletId,
        amount: amount,
        description: description,
      );

      // Update local state
      final updatedWallet = state.wallet?.copyWith(
        balance: state.balance - amount,
      );

      state = state.copyWith(
        isTransferring: false,
        wallet: updatedWallet,
        transactions: [transaction, ...state.transactions],
      );
    } catch (e) {
      state = state.copyWith(
        isTransferring: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Request money (for child)
  Future<void> requestMoney({
    required String toWalletId,
    required double amount,
    String? reason,
  }) async {
    state = state.copyWith(isTransferring: true);

    try {
      await _repository.requestMoney(
        toWalletId: toWalletId,
        amount: amount,
        reason: reason,
      );

      state = state.copyWith(isTransferring: false);
    } catch (e) {
      state = state.copyWith(
        isTransferring: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Approve/deny money request (for parent)
  Future<void> respondToRequest({
    required String requestId,
    required bool approve,
  }) async {
    try {
      await _repository.respondToRequest(
        requestId: requestId,
        approve: approve,
      );

      // Refresh to get updated data
      await refresh();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      rethrow;
    }
  }

  /// Load more transactions
  Future<void> loadMoreTransactions() async {
    try {
      final moreTransactions = await _repository.getTransactions(
        walletId: state.wallet?.id,
        limit: 20,
        offset: state.transactions.length,
      );

      state = state.copyWith(
        transactions: [...state.transactions, ...moreTransactions],
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Create fake family with children
  Future<void> createFakeFamily() async {
    try {
      await _repository.createFakeFamily();
      // Refresh to load new family members
      await refresh();
    } catch (e) {
      print('❌ Error creating fake family: $e');
      rethrow;
    }
  }
}

/// Provider for transaction history with pagination
@riverpod
class TransactionHistory extends _$TransactionHistory {
  @override
  Future<List<Transaction>> build({int limit = 20, int offset = 0}) async {
    final repository = ref.read(walletRepositoryProvider);
    return repository.getTransactions(limit: limit, offset: offset);
  }
}
