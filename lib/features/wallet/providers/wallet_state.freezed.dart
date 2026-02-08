// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletState {

 WalletStatus get status; WalletModel? get wallet; MockBankAccount? get bankAccount; List<Transaction> get transactions; List<FamilyMemberWallet> get familyMembers; List<MoneyRequest> get pendingRequests; String? get errorMessage; bool get isTransferring;
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletStateCopyWith<WalletState> get copyWith => _$WalletStateCopyWithImpl<WalletState>(this as WalletState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletState&&(identical(other.status, status) || other.status == status)&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.bankAccount, bankAccount) || other.bankAccount == bankAccount)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.familyMembers, familyMembers)&&const DeepCollectionEquality().equals(other.pendingRequests, pendingRequests)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isTransferring, isTransferring) || other.isTransferring == isTransferring));
}


@override
int get hashCode => Object.hash(runtimeType,status,wallet,bankAccount,const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(familyMembers),const DeepCollectionEquality().hash(pendingRequests),errorMessage,isTransferring);

@override
String toString() {
  return 'WalletState(status: $status, wallet: $wallet, bankAccount: $bankAccount, transactions: $transactions, familyMembers: $familyMembers, pendingRequests: $pendingRequests, errorMessage: $errorMessage, isTransferring: $isTransferring)';
}


}

/// @nodoc
abstract mixin class $WalletStateCopyWith<$Res>  {
  factory $WalletStateCopyWith(WalletState value, $Res Function(WalletState) _then) = _$WalletStateCopyWithImpl;
@useResult
$Res call({
 WalletStatus status, WalletModel? wallet, MockBankAccount? bankAccount, List<Transaction> transactions, List<FamilyMemberWallet> familyMembers, List<MoneyRequest> pendingRequests, String? errorMessage, bool isTransferring
});


$WalletModelCopyWith<$Res>? get wallet;$MockBankAccountCopyWith<$Res>? get bankAccount;

}
/// @nodoc
class _$WalletStateCopyWithImpl<$Res>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._self, this._then);

  final WalletState _self;
  final $Res Function(WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? wallet = freezed,Object? bankAccount = freezed,Object? transactions = null,Object? familyMembers = null,Object? pendingRequests = null,Object? errorMessage = freezed,Object? isTransferring = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WalletStatus,wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as WalletModel?,bankAccount: freezed == bankAccount ? _self.bankAccount : bankAccount // ignore: cast_nullable_to_non_nullable
as MockBankAccount?,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,familyMembers: null == familyMembers ? _self.familyMembers : familyMembers // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberWallet>,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<MoneyRequest>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isTransferring: null == isTransferring ? _self.isTransferring : isTransferring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletModelCopyWith<$Res>? get wallet {
    if (_self.wallet == null) {
    return null;
  }

  return $WalletModelCopyWith<$Res>(_self.wallet!, (value) {
    return _then(_self.copyWith(wallet: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MockBankAccountCopyWith<$Res>? get bankAccount {
    if (_self.bankAccount == null) {
    return null;
  }

  return $MockBankAccountCopyWith<$Res>(_self.bankAccount!, (value) {
    return _then(_self.copyWith(bankAccount: value));
  });
}
}


/// @nodoc


class _WalletState extends WalletState {
  const _WalletState({this.status = WalletStatus.initial, this.wallet, this.bankAccount, final  List<Transaction> transactions = const [], final  List<FamilyMemberWallet> familyMembers = const [], final  List<MoneyRequest> pendingRequests = const [], this.errorMessage, this.isTransferring = false}): _transactions = transactions,_familyMembers = familyMembers,_pendingRequests = pendingRequests,super._();
  

@override@JsonKey() final  WalletStatus status;
@override final  WalletModel? wallet;
@override final  MockBankAccount? bankAccount;
 final  List<Transaction> _transactions;
@override@JsonKey() List<Transaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<FamilyMemberWallet> _familyMembers;
@override@JsonKey() List<FamilyMemberWallet> get familyMembers {
  if (_familyMembers is EqualUnmodifiableListView) return _familyMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_familyMembers);
}

 final  List<MoneyRequest> _pendingRequests;
@override@JsonKey() List<MoneyRequest> get pendingRequests {
  if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingRequests);
}

@override final  String? errorMessage;
@override@JsonKey() final  bool isTransferring;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletStateCopyWith<_WalletState> get copyWith => __$WalletStateCopyWithImpl<_WalletState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletState&&(identical(other.status, status) || other.status == status)&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.bankAccount, bankAccount) || other.bankAccount == bankAccount)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._familyMembers, _familyMembers)&&const DeepCollectionEquality().equals(other._pendingRequests, _pendingRequests)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isTransferring, isTransferring) || other.isTransferring == isTransferring));
}


@override
int get hashCode => Object.hash(runtimeType,status,wallet,bankAccount,const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_familyMembers),const DeepCollectionEquality().hash(_pendingRequests),errorMessage,isTransferring);

@override
String toString() {
  return 'WalletState(status: $status, wallet: $wallet, bankAccount: $bankAccount, transactions: $transactions, familyMembers: $familyMembers, pendingRequests: $pendingRequests, errorMessage: $errorMessage, isTransferring: $isTransferring)';
}


}

/// @nodoc
abstract mixin class _$WalletStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletStateCopyWith(_WalletState value, $Res Function(_WalletState) _then) = __$WalletStateCopyWithImpl;
@override @useResult
$Res call({
 WalletStatus status, WalletModel? wallet, MockBankAccount? bankAccount, List<Transaction> transactions, List<FamilyMemberWallet> familyMembers, List<MoneyRequest> pendingRequests, String? errorMessage, bool isTransferring
});


@override $WalletModelCopyWith<$Res>? get wallet;@override $MockBankAccountCopyWith<$Res>? get bankAccount;

}
/// @nodoc
class __$WalletStateCopyWithImpl<$Res>
    implements _$WalletStateCopyWith<$Res> {
  __$WalletStateCopyWithImpl(this._self, this._then);

  final _WalletState _self;
  final $Res Function(_WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? wallet = freezed,Object? bankAccount = freezed,Object? transactions = null,Object? familyMembers = null,Object? pendingRequests = null,Object? errorMessage = freezed,Object? isTransferring = null,}) {
  return _then(_WalletState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WalletStatus,wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as WalletModel?,bankAccount: freezed == bankAccount ? _self.bankAccount : bankAccount // ignore: cast_nullable_to_non_nullable
as MockBankAccount?,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,familyMembers: null == familyMembers ? _self._familyMembers : familyMembers // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberWallet>,pendingRequests: null == pendingRequests ? _self._pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<MoneyRequest>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isTransferring: null == isTransferring ? _self.isTransferring : isTransferring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletModelCopyWith<$Res>? get wallet {
    if (_self.wallet == null) {
    return null;
  }

  return $WalletModelCopyWith<$Res>(_self.wallet!, (value) {
    return _then(_self.copyWith(wallet: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MockBankAccountCopyWith<$Res>? get bankAccount {
    if (_self.bankAccount == null) {
    return null;
  }

  return $MockBankAccountCopyWith<$Res>(_self.bankAccount!, (value) {
    return _then(_self.copyWith(bankAccount: value));
  });
}
}

/// @nodoc
mixin _$TransferState {

 bool get isLoading; bool get isSuccess; String? get errorMessage; Transaction? get transaction;
/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferStateCopyWith<TransferState> get copyWith => _$TransferStateCopyWithImpl<TransferState>(this as TransferState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.transaction, transaction) || other.transaction == transaction));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSuccess,errorMessage,transaction);

@override
String toString() {
  return 'TransferState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class $TransferStateCopyWith<$Res>  {
  factory $TransferStateCopyWith(TransferState value, $Res Function(TransferState) _then) = _$TransferStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSuccess, String? errorMessage, Transaction? transaction
});


$TransactionCopyWith<$Res>? get transaction;

}
/// @nodoc
class _$TransferStateCopyWithImpl<$Res>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._self, this._then);

  final TransferState _self;
  final $Res Function(TransferState) _then;

/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSuccess = null,Object? errorMessage = freezed,Object? transaction = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as Transaction?,
  ));
}
/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $TransactionCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// @nodoc


class _TransferState implements TransferState {
  const _TransferState({this.isLoading = false, this.isSuccess = false, this.errorMessage, this.transaction});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override final  String? errorMessage;
@override final  Transaction? transaction;

/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferStateCopyWith<_TransferState> get copyWith => __$TransferStateCopyWithImpl<_TransferState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.transaction, transaction) || other.transaction == transaction));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSuccess,errorMessage,transaction);

@override
String toString() {
  return 'TransferState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class _$TransferStateCopyWith<$Res> implements $TransferStateCopyWith<$Res> {
  factory _$TransferStateCopyWith(_TransferState value, $Res Function(_TransferState) _then) = __$TransferStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSuccess, String? errorMessage, Transaction? transaction
});


@override $TransactionCopyWith<$Res>? get transaction;

}
/// @nodoc
class __$TransferStateCopyWithImpl<$Res>
    implements _$TransferStateCopyWith<$Res> {
  __$TransferStateCopyWithImpl(this._self, this._then);

  final _TransferState _self;
  final $Res Function(_TransferState) _then;

/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSuccess = null,Object? errorMessage = freezed,Object? transaction = freezed,}) {
  return _then(_TransferState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as Transaction?,
  ));
}

/// Create a copy of TransferState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $TransactionCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}

// dart format on
