/// Transaction types for wallet operations
enum TransactionType {
  deposit('deposit'),       // Top-up from bank
  withdraw('withdraw'),     // Withdraw to bank
  transferIn('transfer_in'),   // Received from another wallet
  transferOut('transfer_out'), // Sent to another wallet
  payment('payment'),       // QR payment (child)
  allowance('allowance');   // Scheduled allowance from parent

  final String value;
  const TransactionType(this.value);

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionType.deposit,
    );
  }
}

/// Transaction status
enum TransactionStatus {
  pending('pending'),
  completed('completed'),
  failed('failed'),
  cancelled('cancelled');

  final String value;
  const TransactionStatus(this.value);

  static TransactionStatus fromString(String value) {
    return TransactionStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionStatus.pending,
    );
  }
}

/// Transaction model for tracking all money movements
class TransactionModel {
  final String id;
  final String walletId;
  final TransactionType type;
  final double amount;
  final TransactionStatus status;
  final String? description;
  final String? fromId;      // Source wallet/bank ID
  final String? toId;        // Destination wallet/bank ID
  final String? fromName;    // Source name (for display)
  final String? toName;      // Destination name (for display)
  final String? referenceId; // External reference (e.g., payment QR)
  final DateTime createdAt;
  final DateTime? completedAt;

  const TransactionModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.status,
    this.description,
    this.fromId,
    this.toId,
    this.fromName,
    this.toName,
    this.referenceId,
    required this.createdAt,
    this.completedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      walletId: json['wallet_id'] as String,
      type: TransactionType.fromString(json['type'] as String),
      amount: (json['amount'] as num).toDouble(),
      status: TransactionStatus.fromString(json['status'] as String? ?? 'completed'),
      description: json['description'] as String?,
      fromId: json['from_id'] as String?,
      toId: json['to_id'] as String?,
      fromName: json['from_name'] as String?,
      toName: json['to_name'] as String?,
      referenceId: json['reference_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'type': type.value,
      'amount': amount,
      'status': status.value,
      'description': description,
      'from_id': fromId,
      'to_id': toId,
      'from_name': fromName,
      'to_name': toName,
      'reference_id': referenceId,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'wallet_id': walletId,
      'type': type.value,
      'amount': amount,
      'status': status.value,
      'description': description,
      'from_id': fromId,
      'to_id': toId,
      'from_name': fromName,
      'to_name': toName,
      'reference_id': referenceId,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? walletId,
    TransactionType? type,
    double? amount,
    TransactionStatus? status,
    String? description,
    String? fromId,
    String? toId,
    String? fromName,
    String? toName,
    String? referenceId,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      description: description ?? this.description,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      fromName: fromName ?? this.fromName,
      toName: toName ?? this.toName,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Check if this is an incoming transaction (money received)
  bool get isIncoming => type == TransactionType.deposit || 
                          type == TransactionType.transferIn || 
                          type == TransactionType.allowance;

  /// Check if this is an outgoing transaction (money sent)
  bool get isOutgoing => type == TransactionType.withdraw || 
                          type == TransactionType.transferOut || 
                          type == TransactionType.payment;

  /// Get signed amount (positive for incoming, negative for outgoing)
  double get signedAmount => isIncoming ? amount : -amount;

  /// Get display icon based on transaction type
  String get displayIcon {
    switch (type) {
      case TransactionType.deposit:
        return '💰';
      case TransactionType.withdraw:
        return '🏦';
      case TransactionType.transferIn:
        return '📥';
      case TransactionType.transferOut:
        return '📤';
      case TransactionType.payment:
        return '🛒';
      case TransactionType.allowance:
        return '🎁';
    }
  }

  /// Get display title based on transaction type
  String get displayTitle {
    switch (type) {
      case TransactionType.deposit:
        return 'Nạp tiền';
      case TransactionType.withdraw:
        return 'Rút tiền';
      case TransactionType.transferIn:
        return 'Nhận tiền';
      case TransactionType.transferOut:
        return 'Chuyển tiền';
      case TransactionType.payment:
        return 'Thanh toán';
      case TransactionType.allowance:
        return 'Tiền tiêu vặt';
    }
  }
}
