// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateTransactionState {

 TransactionModel get originalTransaction; TransactionStatus get status; List<CategoryModel> get categories; String get selectedCategory; String get selectedCategoryEmoji; String get amountText; String get note; DateTime? get selectedDate; TransactionType get transactionType; String? get errorMessage;
/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTransactionStateCopyWith<UpdateTransactionState> get copyWith => _$UpdateTransactionStateCopyWithImpl<UpdateTransactionState>(this as UpdateTransactionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTransactionState&&(identical(other.originalTransaction, originalTransaction) || other.originalTransaction == originalTransaction)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryEmoji, selectedCategoryEmoji) || other.selectedCategoryEmoji == selectedCategoryEmoji)&&(identical(other.amountText, amountText) || other.amountText == amountText)&&(identical(other.note, note) || other.note == note)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,originalTransaction,status,const DeepCollectionEquality().hash(categories),selectedCategory,selectedCategoryEmoji,amountText,note,selectedDate,transactionType,errorMessage);

@override
String toString() {
  return 'UpdateTransactionState(originalTransaction: $originalTransaction, status: $status, categories: $categories, selectedCategory: $selectedCategory, selectedCategoryEmoji: $selectedCategoryEmoji, amountText: $amountText, note: $note, selectedDate: $selectedDate, transactionType: $transactionType, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UpdateTransactionStateCopyWith<$Res>  {
  factory $UpdateTransactionStateCopyWith(UpdateTransactionState value, $Res Function(UpdateTransactionState) _then) = _$UpdateTransactionStateCopyWithImpl;
@useResult
$Res call({
 TransactionModel originalTransaction, TransactionStatus status, List<CategoryModel> categories, String selectedCategory, String selectedCategoryEmoji, String amountText, String note, DateTime? selectedDate, TransactionType transactionType, String? errorMessage
});


$TransactionModelCopyWith<$Res> get originalTransaction;

}
/// @nodoc
class _$UpdateTransactionStateCopyWithImpl<$Res>
    implements $UpdateTransactionStateCopyWith<$Res> {
  _$UpdateTransactionStateCopyWithImpl(this._self, this._then);

  final UpdateTransactionState _self;
  final $Res Function(UpdateTransactionState) _then;

/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalTransaction = null,Object? status = null,Object? categories = null,Object? selectedCategory = null,Object? selectedCategoryEmoji = null,Object? amountText = null,Object? note = null,Object? selectedDate = freezed,Object? transactionType = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
originalTransaction: null == originalTransaction ? _self.originalTransaction : originalTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryEmoji: null == selectedCategoryEmoji ? _self.selectedCategoryEmoji : selectedCategoryEmoji // ignore: cast_nullable_to_non_nullable
as String,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as TransactionType,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res> get originalTransaction {
  
  return $TransactionModelCopyWith<$Res>(_self.originalTransaction, (value) {
    return _then(_self.copyWith(originalTransaction: value));
  });
}
}


/// @nodoc


class _UpdateTransactionState extends UpdateTransactionState {
  const _UpdateTransactionState({required this.originalTransaction, this.status = TransactionStatus.initial, final  List<CategoryModel> categories = const [], this.selectedCategory = '', this.selectedCategoryEmoji = '', this.amountText = '', this.note = '', this.selectedDate, this.transactionType = TransactionType.expense, this.errorMessage}): _categories = categories,super._();
  

@override final  TransactionModel originalTransaction;
@override@JsonKey() final  TransactionStatus status;
 final  List<CategoryModel> _categories;
@override@JsonKey() List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  String selectedCategory;
@override@JsonKey() final  String selectedCategoryEmoji;
@override@JsonKey() final  String amountText;
@override@JsonKey() final  String note;
@override final  DateTime? selectedDate;
@override@JsonKey() final  TransactionType transactionType;
@override final  String? errorMessage;

/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTransactionStateCopyWith<_UpdateTransactionState> get copyWith => __$UpdateTransactionStateCopyWithImpl<_UpdateTransactionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTransactionState&&(identical(other.originalTransaction, originalTransaction) || other.originalTransaction == originalTransaction)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.selectedCategoryEmoji, selectedCategoryEmoji) || other.selectedCategoryEmoji == selectedCategoryEmoji)&&(identical(other.amountText, amountText) || other.amountText == amountText)&&(identical(other.note, note) || other.note == note)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,originalTransaction,status,const DeepCollectionEquality().hash(_categories),selectedCategory,selectedCategoryEmoji,amountText,note,selectedDate,transactionType,errorMessage);

@override
String toString() {
  return 'UpdateTransactionState(originalTransaction: $originalTransaction, status: $status, categories: $categories, selectedCategory: $selectedCategory, selectedCategoryEmoji: $selectedCategoryEmoji, amountText: $amountText, note: $note, selectedDate: $selectedDate, transactionType: $transactionType, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UpdateTransactionStateCopyWith<$Res> implements $UpdateTransactionStateCopyWith<$Res> {
  factory _$UpdateTransactionStateCopyWith(_UpdateTransactionState value, $Res Function(_UpdateTransactionState) _then) = __$UpdateTransactionStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionModel originalTransaction, TransactionStatus status, List<CategoryModel> categories, String selectedCategory, String selectedCategoryEmoji, String amountText, String note, DateTime? selectedDate, TransactionType transactionType, String? errorMessage
});


@override $TransactionModelCopyWith<$Res> get originalTransaction;

}
/// @nodoc
class __$UpdateTransactionStateCopyWithImpl<$Res>
    implements _$UpdateTransactionStateCopyWith<$Res> {
  __$UpdateTransactionStateCopyWithImpl(this._self, this._then);

  final _UpdateTransactionState _self;
  final $Res Function(_UpdateTransactionState) _then;

/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalTransaction = null,Object? status = null,Object? categories = null,Object? selectedCategory = null,Object? selectedCategoryEmoji = null,Object? amountText = null,Object? note = null,Object? selectedDate = freezed,Object? transactionType = null,Object? errorMessage = freezed,}) {
  return _then(_UpdateTransactionState(
originalTransaction: null == originalTransaction ? _self.originalTransaction : originalTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryEmoji: null == selectedCategoryEmoji ? _self.selectedCategoryEmoji : selectedCategoryEmoji // ignore: cast_nullable_to_non_nullable
as String,amountText: null == amountText ? _self.amountText : amountText // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as TransactionType,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UpdateTransactionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res> get originalTransaction {
  
  return $TransactionModelCopyWith<$Res>(_self.originalTransaction, (value) {
    return _then(_self.copyWith(originalTransaction: value));
  });
}
}

// dart format on
