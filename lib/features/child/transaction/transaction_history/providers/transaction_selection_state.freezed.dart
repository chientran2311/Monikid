// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionSelectionState {

 String? get selectedTransactionId; TransactionModel? get selectedTransaction; bool get isResolvingSelection; String? get selectionErrorMessage;
/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionSelectionStateCopyWith<TransactionSelectionState> get copyWith => _$TransactionSelectionStateCopyWithImpl<TransactionSelectionState>(this as TransactionSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionSelectionState&&(identical(other.selectedTransactionId, selectedTransactionId) || other.selectedTransactionId == selectedTransactionId)&&(identical(other.selectedTransaction, selectedTransaction) || other.selectedTransaction == selectedTransaction)&&(identical(other.isResolvingSelection, isResolvingSelection) || other.isResolvingSelection == isResolvingSelection)&&(identical(other.selectionErrorMessage, selectionErrorMessage) || other.selectionErrorMessage == selectionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedTransactionId,selectedTransaction,isResolvingSelection,selectionErrorMessage);

@override
String toString() {
  return 'TransactionSelectionState(selectedTransactionId: $selectedTransactionId, selectedTransaction: $selectedTransaction, isResolvingSelection: $isResolvingSelection, selectionErrorMessage: $selectionErrorMessage)';
}


}

/// @nodoc
abstract mixin class $TransactionSelectionStateCopyWith<$Res>  {
  factory $TransactionSelectionStateCopyWith(TransactionSelectionState value, $Res Function(TransactionSelectionState) _then) = _$TransactionSelectionStateCopyWithImpl;
@useResult
$Res call({
 String? selectedTransactionId, TransactionModel? selectedTransaction, bool isResolvingSelection, String? selectionErrorMessage
});


$TransactionModelCopyWith<$Res>? get selectedTransaction;

}
/// @nodoc
class _$TransactionSelectionStateCopyWithImpl<$Res>
    implements $TransactionSelectionStateCopyWith<$Res> {
  _$TransactionSelectionStateCopyWithImpl(this._self, this._then);

  final TransactionSelectionState _self;
  final $Res Function(TransactionSelectionState) _then;

/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedTransactionId = freezed,Object? selectedTransaction = freezed,Object? isResolvingSelection = null,Object? selectionErrorMessage = freezed,}) {
  return _then(_self.copyWith(
selectedTransactionId: freezed == selectedTransactionId ? _self.selectedTransactionId : selectedTransactionId // ignore: cast_nullable_to_non_nullable
as String?,selectedTransaction: freezed == selectedTransaction ? _self.selectedTransaction : selectedTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,isResolvingSelection: null == isResolvingSelection ? _self.isResolvingSelection : isResolvingSelection // ignore: cast_nullable_to_non_nullable
as bool,selectionErrorMessage: freezed == selectionErrorMessage ? _self.selectionErrorMessage : selectionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.selectedTransaction!, (value) {
    return _then(_self.copyWith(selectedTransaction: value));
  });
}
}


/// @nodoc


class _TransactionSelectionState extends TransactionSelectionState {
  const _TransactionSelectionState({this.selectedTransactionId, this.selectedTransaction, this.isResolvingSelection = false, this.selectionErrorMessage}): super._();
  

@override final  String? selectedTransactionId;
@override final  TransactionModel? selectedTransaction;
@override@JsonKey() final  bool isResolvingSelection;
@override final  String? selectionErrorMessage;

/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionSelectionStateCopyWith<_TransactionSelectionState> get copyWith => __$TransactionSelectionStateCopyWithImpl<_TransactionSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionSelectionState&&(identical(other.selectedTransactionId, selectedTransactionId) || other.selectedTransactionId == selectedTransactionId)&&(identical(other.selectedTransaction, selectedTransaction) || other.selectedTransaction == selectedTransaction)&&(identical(other.isResolvingSelection, isResolvingSelection) || other.isResolvingSelection == isResolvingSelection)&&(identical(other.selectionErrorMessage, selectionErrorMessage) || other.selectionErrorMessage == selectionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedTransactionId,selectedTransaction,isResolvingSelection,selectionErrorMessage);

@override
String toString() {
  return 'TransactionSelectionState(selectedTransactionId: $selectedTransactionId, selectedTransaction: $selectedTransaction, isResolvingSelection: $isResolvingSelection, selectionErrorMessage: $selectionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$TransactionSelectionStateCopyWith<$Res> implements $TransactionSelectionStateCopyWith<$Res> {
  factory _$TransactionSelectionStateCopyWith(_TransactionSelectionState value, $Res Function(_TransactionSelectionState) _then) = __$TransactionSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 String? selectedTransactionId, TransactionModel? selectedTransaction, bool isResolvingSelection, String? selectionErrorMessage
});


@override $TransactionModelCopyWith<$Res>? get selectedTransaction;

}
/// @nodoc
class __$TransactionSelectionStateCopyWithImpl<$Res>
    implements _$TransactionSelectionStateCopyWith<$Res> {
  __$TransactionSelectionStateCopyWithImpl(this._self, this._then);

  final _TransactionSelectionState _self;
  final $Res Function(_TransactionSelectionState) _then;

/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedTransactionId = freezed,Object? selectedTransaction = freezed,Object? isResolvingSelection = null,Object? selectionErrorMessage = freezed,}) {
  return _then(_TransactionSelectionState(
selectedTransactionId: freezed == selectedTransactionId ? _self.selectedTransactionId : selectedTransactionId // ignore: cast_nullable_to_non_nullable
as String?,selectedTransaction: freezed == selectedTransaction ? _self.selectedTransaction : selectedTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,isResolvingSelection: null == isResolvingSelection ? _self.isResolvingSelection : isResolvingSelection // ignore: cast_nullable_to_non_nullable
as bool,selectionErrorMessage: freezed == selectionErrorMessage ? _self.selectionErrorMessage : selectionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TransactionSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.selectedTransaction!, (value) {
    return _then(_self.copyWith(selectedTransaction: value));
  });
}
}

// dart format on
