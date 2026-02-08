import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'package:monikid/models/entities/wallet/transaction.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';
import 'wallet_repository.dart';

/// Wallet repository implementation using Firebase Firestore
class WalletRepositoryImpl implements WalletRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  WalletRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  // ============================================================================
  // WALLET OPERATIONS (Firebase Firestore)
  // ============================================================================

  @override
  Future<WalletModel?> getMyWallet() async {
    final userId = _currentUserId;
    if (userId == null) {
      _logger.w('⚠️ User not logged in');
      return null;
    }

    try {
      _logger.i('💰 Fetching wallet for user: $userId');
      
      // Lấy document user từ Firestore
      final userDoc = await _firestore.collection('users').doc(userId).get();
      
      if (!userDoc.exists) {
        _logger.w('⚠️ User document not found');
        return null;
      }

      final userData = userDoc.data();
      if (userData == null) {
        _logger.w('⚠️ User data is null');
        return null;
      }

      // Lấy wallet data từ nested field
      final walletData = userData['wallet'] as Map<String, dynamic>?;
      if (walletData == null) {
        _logger.w('⚠️ Wallet data not found in user document');
        return null;
      }

      // Lấy role để xác định wallet type
      final role = userData['role'] as String? ?? 'child';
      final walletType = role == 'parent' ? WalletType.parent : WalletType.child;

      // Convert balance to double
      final balance = (walletData['balance'] as num?)?.toDouble() ?? 0.0;
      final isLocked = walletData['is_locked'] as bool? ?? false;

      // Get statistics
      final statsData = userData['statistics'] as Map<String, dynamic>? ?? {};
      final totalTransferred = (statsData['total_transferred'] as num?)?.toDouble() ?? 0.0;
      final totalSpent = (statsData['total_spent'] as num?)?.toDouble() ?? 0.0;
      final totalWithdrawn = (statsData['total_withdrawn'] as num?)?.toDouble() ?? 0.0;
      final totalDeposited = (statsData['total_deposited'] as num?)?.toDouble() ?? 0.0;

      _logger.i('✅ Wallet fetched - Balance: $balance VND');

      // Tạo WalletModel từ data
      return WalletModel(
        id: userId, // Dùng userId làm wallet ID
        ownerId: userId,
        familyId: userData['family_id'] as String?,
        walletType: walletType,
        balance: balance,
        isLocked: isLocked,
        totalTransferred: totalTransferred,
        totalSpent: totalSpent,
        totalWithdrawn: totalWithdrawn,
        totalDeposited: totalDeposited,
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching wallet', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  @override
  Future<WalletModel?> getWalletById(String walletId) async {
    try {
      _logger.i('🔍 Fetching wallet by ID: $walletId');
      
      final userDoc = await _firestore.collection('users').doc(walletId).get();
      
      if (!userDoc.exists) {
        _logger.w('⚠️ Wallet not found');
        return null;
      }

      final userData = userDoc.data();
      if (userData == null) return null;

      final walletData = userData['wallet'] as Map<String, dynamic>?;
      if (walletData == null) return null;

      final role = userData['role'] as String? ?? 'child';
      final walletType = role == 'parent' ? WalletType.parent : WalletType.child;
      final balance = (walletData['balance'] as num?)?.toDouble() ?? 0.0;
      final isLocked = walletData['is_locked'] as bool? ?? false;

      return WalletModel(
        id: walletId,
        ownerId: walletId,
        familyId: userData['family_id'] as String?,
        walletType: walletType,
        balance: balance,
        isLocked: isLocked,
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching wallet by ID', error: e, stackTrace: stackTrace);
      return null;
    }
  }


 
  // ============================================================================
  // TRANSACTION OPERATIONS (Direct Supabase RPC)
  // ============================================================================


  // ============================================================================
  // WALLET OPERATIONS
  // ============================================================================

  @override
  Future<MockBankAccount?> getMyBankAccount() async {
    final userId = _currentUserId;
    if (userId == null) {
      _logger.w('⚠️ User not logged in');
      return null;
    }

    try {
      _logger.i('🏦 Fetching bank account for user: $userId');
      
      final userDoc = await _firestore.collection('users').doc(userId).get();
      
      if (!userDoc.exists) {
        _logger.w('⚠️ User document not found');
        return null;
      }

      final userData = userDoc.data();
      if (userData == null) return null;

      // Lấy bank account data từ nested field
      final bankData = userData['bank_account'] as Map<String, dynamic>?;
      if (bankData == null) {
        _logger.w('⚠️ Bank account not found (might be a child user)');
        return null;
      }

      final accountNumber = bankData['account_number'] as String? ?? '';
      final balance = (bankData['bank_balance'] as num?)?.toDouble() ?? 0.0;
      final isVerified = bankData['is_verified'] as bool? ?? false;

      _logger.i('✅ Bank account fetched - Balance: $balance VND');

      return MockBankAccount(
        id: userId,
        userId: userId,
        accountNumber: accountNumber,
        balance: balance,
        isVerified: isVerified,
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching bank account', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  // ============================================================================
  // FAMILY MEMBERS
  // ============================================================================

  @override
  Future<List<FamilyMemberWallet>> getFamilyMembersWithWallets(String familyId) async {
    try {
      _logger.i('👨‍👩‍👧‍👦 Fetching family members with wallets for family: $familyId');

      // Query tất cả users trong family này với role = 'child'
      final membersSnapshot = await _firestore
          .collection('users')
          .where('family_id', isEqualTo: familyId)
          .where('role', isEqualTo: 'child')
          .get();

      _logger.i('✅ Found ${membersSnapshot.docs.length} family members');

      final members = <FamilyMemberWallet>[];

      for (final doc in membersSnapshot.docs) {
        final data = doc.data();
        final walletData = data['wallet'] as Map<String, dynamic>?;

        if (walletData != null) {
          members.add(FamilyMemberWallet(
            id: doc.id,
            userId: doc.id,
            fullName: data['full_name'] as String? ?? 'Unknown',
            avatarUrl: data['avatar_url'] as String?,
            role: data['role'] as String? ?? 'child',
            walletId: doc.id, // Wallet ID = User ID
            balance: (walletData['balance'] as num?)?.toDouble() ?? 0.0,
          ));
        }
      }

      return members;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching family members', error: e, stackTrace: stackTrace);
      return [];
    }
  }
  // ============================================================================
  // TRANSACTION OPERATIONS (Firebase Firestore Transactions)
  // ============================================================================

  @override
  Future<Transaction> depositFromBank({
    required double amount,
    String? description,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Chưa đăng nhập');

    try {
      _logger.i('💳 Deposit from bank - Amount: $amount VND');

      // Sử dụng Firestore transaction để đảm bảo atomic operation
      final transactionDoc = await _firestore.runTransaction((transaction) async {
        final userRef = _firestore.collection('users').doc(userId);
        final userSnapshot = await transaction.get(userRef);

        if (!userSnapshot.exists) {
          throw Exception('User không tồn tại');
        }

        final userData = userSnapshot.data()!;
        final walletData = userData['wallet'] as Map<String, dynamic>? ?? {};
        final bankData = userData['bank_account'] as Map<String, dynamic>? ?? {};

        final currentWalletBalance = (walletData['balance'] as num?)?.toDouble() ?? 0.0;
        final currentBankBalance = (bankData['bank_balance'] as num?)?.toDouble() ?? 0.0;

        // Kiểm tra số dư ngân hàng
        if (currentBankBalance < amount) {
          throw Exception('Số dư ngân hàng không đủ');
        }

        // Cập nhật balances
        final newWalletBalance = currentWalletBalance + amount;
        final newBankBalance = currentBankBalance - amount;

        transaction.update(userRef, {
          'wallet.balance': newWalletBalance,
          'bank_account.bank_balance': newBankBalance,
        });

        // Tạo transaction record
        final transactionRef = _firestore.collection('transactions').doc();
        final transactionData = {
          'id': transactionRef.id,
          'user_id': userId,
          'type': 'bank_deposit',
          'amount': amount,
          'description': description ?? 'Nạp tiền từ ngân hàng',
          'status': 'completed',
          'created_at': FieldValue.serverTimestamp(),
          'from': 'bank',
          'to': 'wallet',
        };

        transaction.set(transactionRef, transactionData);

        _logger.i('✅ Deposit successful - New wallet balance: $newWalletBalance VND');

        return transactionData;
      });

      // Update statistics after successful deposit
      await _updateStatistics(userId, amount, 'deposited');

      // Convert map to Transaction object
      return Transaction(
        id: transactionDoc['id'] as String,
        type: TransactionType.bankDeposit,
        amount: amount,
        description: description ?? 'Nạp tiền từ ngân hàng',
        status: TransactionStatus.completed,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Deposit failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<Transaction> withdrawToBank({
    required double amount,
    String? description,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Chưa đăng nhập');

    try {
      _logger.i('💸 Withdraw to bank - Amount: $amount VND');

      final transactionDoc = await _firestore.runTransaction((transaction) async {
        final userRef = _firestore.collection('users').doc(userId);
        final userSnapshot = await transaction.get(userRef);

        if (!userSnapshot.exists) {
          throw Exception('User không tồn tại');
        }

        final userData = userSnapshot.data()!;
        final walletData = userData['wallet'] as Map<String, dynamic>? ?? {};
        final bankData = userData['bank_account'] as Map<String, dynamic>? ?? {};

        final currentWalletBalance = (walletData['balance'] as num?)?.toDouble() ?? 0.0;
        final currentBankBalance = (bankData['bank_balance'] as num?)?.toDouble() ?? 0.0;

        // Kiểm tra số dư ví
        if (currentWalletBalance < amount) {
          throw Exception('Số dư ví không đủ');
        }

        // Cập nhật balances
        final newWalletBalance = currentWalletBalance - amount;
        final newBankBalance = currentBankBalance + amount;

        transaction.update(userRef, {
          'wallet.balance': newWalletBalance,
          'bank_account.bank_balance': newBankBalance,
        });

        // Tạo transaction record
        final transactionRef = _firestore.collection('transactions').doc();
        final transactionData = {
          'id': transactionRef.id,
          'user_id': userId,
          'type': 'bank_withdraw',
          'amount': amount,
          'description': description ?? 'Rút tiền về ngân hàng',
          'status': 'completed',
          'created_at': FieldValue.serverTimestamp(),
          'from': 'wallet',
          'to': 'bank',
        };

        transaction.set(transactionRef, transactionData);

        _logger.i('✅ Withdraw successful - New wallet balance: $newWalletBalance VND');

        return transactionData;
      });

      // Update statistics after successful withdraw
      await _updateStatistics(userId, amount, 'withdrawn');

      return Transaction(
        id: transactionDoc['id'] as String,
        type: TransactionType.bankWithdraw,
        amount: amount,
        description: description ?? 'Rút tiền về ngân hàng',
        status: TransactionStatus.completed,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Withdraw failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<Transaction> transfer({
    required String toWalletId,
    required double amount,
    String? description,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Chưa đăng nhập');

    try {
      _logger.i('💸 Transfer - Amount: $amount VND to wallet: $toWalletId');

      final transactionDoc = await _firestore.runTransaction((transaction) async {
        final fromUserRef = _firestore.collection('users').doc(userId);
        final toUserRef = _firestore.collection('users').doc(toWalletId);

        final fromSnapshot = await transaction.get(fromUserRef);
        final toSnapshot = await transaction.get(toUserRef);

        if (!fromSnapshot.exists) throw Exception('Ví nguồn không tồn tại');
        if (!toSnapshot.exists) throw Exception('Ví đích không tồn tại');

        final fromData = fromSnapshot.data()!;
        final toData = toSnapshot.data()!;

        final fromWallet = fromData['wallet'] as Map<String, dynamic>? ?? {};
        final toWallet = toData['wallet'] as Map<String, dynamic>? ?? {};

        final fromBalance = (fromWallet['balance'] as num?)?.toDouble() ?? 0.0;
        final toBalance = (toWallet['balance'] as num?)?.toDouble() ?? 0.0;

        if (fromBalance < amount) {
          throw Exception('Số dư không đủ để chuyển');
        }

        // Update balances
        transaction.update(fromUserRef, {'wallet.balance': fromBalance - amount});
        transaction.update(toUserRef, {'wallet.balance': toBalance + amount});

        // Create transaction record
        final transactionRef = _firestore.collection('transactions').doc();
        final transactionData = {
          'id': transactionRef.id,
          'from_user_id': userId,
          'to_user_id': toWalletId,
          'type': 'allowance',
          'amount': amount,
          'description': description ?? 'Chuyển tiền',
          'status': 'completed',
          'created_at': FieldValue.serverTimestamp(),
        };

        transaction.set(transactionRef, transactionData);

        _logger.i('✅ Transfer successful');

        return transactionData;
      });

      // Update statistics after successful transfer
      await _updateStatistics(userId, amount, 'transferred');

      return Transaction(
        id: transactionDoc['id'] as String,
        type: TransactionType.allowance,
        amount: amount,
        description: description ?? 'Chuyển tiền',
        status: TransactionStatus.completed,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Transfer failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  // ============================================================================
  // TRANSACTION HISTORY
  // ============================================================================

  @override
  Future<List<Transaction>> getTransactions({
    String? walletId,
    int limit = 20,
    int offset = 0,
  }) async {
    final userId = walletId ?? _currentUserId;
    if (userId == null) return [];

    try {
      _logger.i('📜 Fetching transactions for user: $userId');

      final querySnapshot = await _firestore
          .collection('transactions')
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .limit(limit)
          .get();

      final transactions = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final typeStr = data['type'] as String? ?? 'bank_deposit';
        TransactionType type;
        
        switch (typeStr) {
          case 'bank_deposit':
            type = TransactionType.bankDeposit;
            break;
          case 'bank_withdraw':
            type = TransactionType.bankWithdraw;
            break;
          case 'allowance':
            type = TransactionType.allowance;
            break;
          case 'payment':
            type = TransactionType.payment;
            break;
          case 'request_transfer':
            type = TransactionType.requestTransfer;
            break;
          default:
            type = TransactionType.bankDeposit;
        }

        final statusStr = data['status'] as String? ?? 'completed';
        TransactionStatus status;
        switch (statusStr) {
          case 'pending':
            status = TransactionStatus.pending;
            break;
          case 'failed':
            status = TransactionStatus.failed;
            break;
          case 'cancelled':
            status = TransactionStatus.cancelled;
            break;
          default:
            status = TransactionStatus.completed;
        }

        return Transaction(
          id: doc.id,
          type: type,
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          description: data['description'] as String?,
          status: status,
          createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();

      _logger.i('✅ Found ${transactions.length} transactions');
      return transactions;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching transactions', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  @override
  Future<Transaction?> getTransactionById(String transactionId) async {
    try {
      final doc = await _firestore.collection('transactions').doc(transactionId).get();
      
      if (!doc.exists) return null;

      final data = doc.data()!;
      final typeStr = data['type'] as String? ?? 'bank_deposit';
      TransactionType type;
      
      switch (typeStr) {
        case 'bank_deposit':
          type = TransactionType.bankDeposit;
          break;
        case 'bank_withdraw':
          type = TransactionType.bankWithdraw;
          break;
        case 'allowance':
          type = TransactionType.allowance;
          break;
        case 'payment':
          type = TransactionType.payment;
          break;
        case 'request_transfer':
          type = TransactionType.requestTransfer;
          break;
        default:
          type = TransactionType.bankDeposit;
      }

      final statusStr = data['status'] as String? ?? 'completed';
      TransactionStatus status;
      switch (statusStr) {
        case 'pending':
          status = TransactionStatus.pending;
          break;
        case 'failed':
          status = TransactionStatus.failed;
          break;
        case 'cancelled':
          status = TransactionStatus.cancelled;
          break;
        default:
          status = TransactionStatus.completed;
      }

      return Transaction(
        id: doc.id,
        type: type,
        amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
        description: data['description'] as String?,
        status: status,
        createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching transaction', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  // ============================================================================
  // MONEY REQUEST OPERATIONS
  // ============================================================================

  @override
  Future<List<MoneyRequest>> getPendingRequests() async {
    final userId = _currentUserId;
    if (userId == null) return [];

    try {
      _logger.i('📬 Fetching pending money requests');

      final querySnapshot = await _firestore
          .collection('money_requests')
          .where('to_user_id', isEqualTo: userId)
          .where('status', isEqualTo: 'pending')
          .orderBy('created_at', descending: true)
          .get();

      final requests = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MoneyRequest(
          id: doc.id,
          fromWalletId: data['from_user_id'] as String,
          toWalletId: data['to_user_id'] as String,
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          reason: data['reason'] as String?,
          status: data['status'] as String? ?? 'pending',
          createdAt: (data['created_at'] as Timestamp?)?.toDate(),
        );
      }).toList();

      _logger.i('✅ Found ${requests.length} pending requests');
      return requests;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching pending requests', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  @override
  Future<MoneyRequest> requestMoney({
    required String toWalletId,
    required double amount,
    String? reason,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('Chưa đăng nhập');

    try {
      _logger.i('💰 Creating money request - Amount: $amount VND to: $toWalletId');

      final requestRef = _firestore.collection('money_requests').doc();
      final requestData = {
        'id': requestRef.id,
        'from_user_id': userId,
        'to_user_id': toWalletId,
        'amount': amount,
        'reason': reason,
        'status': 'pending',
        'created_at': FieldValue.serverTimestamp(),
      };

      await requestRef.set(requestData);

      _logger.i('✅ Money request created successfully');

      return MoneyRequest(
        id: requestRef.id,
        fromWalletId: userId,
        toWalletId: toWalletId,
        amount: amount,
        reason: reason,
        status: 'pending',
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error creating money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<MoneyRequest> respondToRequest({
    required String requestId,
    required bool approve,
  }) async {
    try {
      _logger.i('📝 Responding to money request: $requestId - Approve: $approve');

      // Get the request first
      final requestDoc = await _firestore.collection('money_requests').doc(requestId).get();
      
      if (!requestDoc.exists) {
        throw Exception('Money request không tồn tại');
      }

      final requestData = requestDoc.data()!;
      final fromUserId = requestData['from_user_id'] as String;
      final amount = (requestData['amount'] as num).toDouble();
      final reason = requestData['reason'] as String?;

      if (approve) {
        // Create transfer transaction
        await transfer(
          toWalletId: fromUserId,
          amount: amount,
          description: 'Approved request: ${reason ?? ""}',
        );
      }

      // Update request status
      await _firestore.collection('money_requests').doc(requestId).update({
        'status': approve ? 'approved' : 'denied',
        'responded_at': FieldValue.serverTimestamp(),
      });

      _logger.i('✅ Money request ${approve ? "approved" : "denied"}');

      return MoneyRequest(
        id: requestId,
        fromWalletId: fromUserId,
        toWalletId: requestData['to_user_id'] as String,
        amount: amount,
        reason: reason,
        status: approve ? 'approved' : 'denied',
        respondedAt: DateTime.now(),
        createdAt: (requestData['created_at'] as Timestamp?)?.toDate(),
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error responding to request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // ============================================================================
  // FAKE DATA OPERATIONS
  // ============================================================================

  @override
  Future<void> createFakeFamily() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        _logger.e('❌ No user logged in to create family');
        throw Exception('User not logged in');
      }

      _logger.i('👨‍👩‍👧‍👦 Creating fake family for user: $userId');

      // Tạo family ID
      final familyId = 'family_${DateTime.now().millisecondsSinceEpoch}';

      // Update parent user với family_id
      await _firestore.collection('users').doc(userId).update({
        'family_id': familyId,
      });

      _logger.i('✅ Updated parent with family_id: $familyId');

      // Tạo family document
      await _firestore.collection('families').doc(familyId).set({
        'family_id': familyId,
        'parent_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      });

      _logger.i('✅ Created family document');

      // Tạo 3 children accounts
      final childrenData = [
        {'name': 'Sarah Tran', 'email': 'sarah_child@monikid.com', 'avatar': 'https://i.pravatar.cc/150?img=1'},
        {'name': 'Tommy Nguyen', 'email': 'tommy_child@monikid.com', 'avatar': 'https://i.pravatar.cc/150?img=2'},
        {'name': 'Emma Le', 'email': 'emma_child@monikid.com', 'avatar': 'https://i.pravatar.cc/150?img=3'},
      ];

      for (var i = 0; i < childrenData.length; i++) {
        final childData = childrenData[i];
        
        // Tạo child document (không tạo Firebase Auth account)
        final childId = 'child_${DateTime.now().millisecondsSinceEpoch}_$i';
        
        await _firestore.collection('users').doc(childId).set({
          'uid': childId,
          'email': childData['email'],
          'full_name': childData['name'],
          'phone': '',
          'role': 'child',
          'avatar_url': childData['avatar'],
          'family_id': familyId,
          'parent_id': userId,
          'created_at': FieldValue.serverTimestamp(),
          'wallet': {
            'balance': 0.0, // Mặc định 0 đồng
            'currency': 'VND',
            'is_locked': false,
          },
        });

        _logger.i('✅ Created child account: ${childData['name']} with 0 VND');
      }

      _logger.i('🎉 Fake family created successfully with 3 children!');
    } catch (e, stackTrace) {
      _logger.e('❌ Error creating fake family', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // ============================================================================
  // STATISTICS HELPER
  // ============================================================================

  Future<void> _updateStatistics(String userId, double amount, String type) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        
        if (!snapshot.exists) return;
        
        final data = snapshot.data()!;
        final stats = data['statistics'] as Map<String, dynamic>? ?? {};
        
        final currentTransferred = (stats['total_transferred'] as num?)?.toDouble() ?? 0.0;
        final currentSpent = (stats['total_spent'] as num?)?.toDouble() ?? 0.0;
        final currentWithdrawn = (stats['total_withdrawn'] as num?)?.toDouble() ?? 0.0;
        final currentDeposited = (stats['total_deposited'] as num?)?.toDouble() ?? 0.0;
        
        Map<String, dynamic> updates = {};
        
        switch (type) {
          case 'transferred':
            updates['statistics.total_transferred'] = currentTransferred + amount;
            break;
          case 'spent':
            updates['statistics.total_spent'] = currentSpent + amount;
            break;
          case 'withdrawn':
            updates['statistics.total_withdrawn'] = currentWithdrawn + amount;
            break;
          case 'deposited':
            updates['statistics.total_deposited'] = currentDeposited + amount;
            break;
        }
        
        transaction.update(userRef, updates);
      });
      
      _logger.i('✅ Statistics updated: $type = $amount');
    } catch (e) {
      _logger.e('❌ Failed to update statistics', error: e);
      // Don't rethrow - statistics update shouldn't break the main flow
    }
  }
}
