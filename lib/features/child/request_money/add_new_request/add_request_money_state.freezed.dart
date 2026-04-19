// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_request_money_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddRequestMoneyState {

 double get amount; String get category; String get note; List<String> get recipients; bool get isLoading; bool get isSuccess; String? get errorMessage;
/// Create a copy of AddRequestMoneyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddRequestMoneyStateCopyWith<AddRequestMoneyState> get copyWith => _$AddRequestMoneyStateCopyWithImpl<AddRequestMoneyState>(this as AddRequestMoneyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddRequestMoneyState&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.recipients, recipients)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,amount,category,note,const DeepCollectionEquality().hash(recipients),isLoading,isSuccess,errorMessage);

@override
String toString() {
  return 'AddRequestMoneyState(amount: $amount, category: $category, note: $note, recipients: $recipients, isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AddRequestMoneyStateCopyWith<$Res>  {
  factory $AddRequestMoneyStateCopyWith(AddRequestMoneyState value, $Res Function(AddRequestMoneyState) _then) = _$AddRequestMoneyStateCopyWithImpl;
@useResult
$Res call({
 double amount, String category, String note, List<String> recipients, bool isLoading, bool isSuccess, String? errorMessage
});




}
/// @nodoc
class _$AddRequestMoneyStateCopyWithImpl<$Res>
    implements $AddRequestMoneyStateCopyWith<$Res> {
  _$AddRequestMoneyStateCopyWithImpl(this._self, this._then);

  final AddRequestMoneyState _self;
  final $Res Function(AddRequestMoneyState) _then;

/// Create a copy of AddRequestMoneyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? category = null,Object? note = null,Object? recipients = null,Object? isLoading = null,Object? isSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,recipients: null == recipients ? _self.recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _AddRequestMoneyState extends AddRequestMoneyState {
  const _AddRequestMoneyState({this.amount = 0.0, this.category = 'snacks', this.note = '', final  List<String> recipients = const [], this.isLoading = false, this.isSuccess = false, this.errorMessage}): _recipients = recipients,super._();
  

@override@JsonKey() final  double amount;
@override@JsonKey() final  String category;
@override@JsonKey() final  String note;
 final  List<String> _recipients;
@override@JsonKey() List<String> get recipients {
  if (_recipients is EqualUnmodifiableListView) return _recipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipients);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSuccess;
@override final  String? errorMessage;

/// Create a copy of AddRequestMoneyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddRequestMoneyStateCopyWith<_AddRequestMoneyState> get copyWith => __$AddRequestMoneyStateCopyWithImpl<_AddRequestMoneyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddRequestMoneyState&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._recipients, _recipients)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,amount,category,note,const DeepCollectionEquality().hash(_recipients),isLoading,isSuccess,errorMessage);

@override
String toString() {
  return 'AddRequestMoneyState(amount: $amount, category: $category, note: $note, recipients: $recipients, isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AddRequestMoneyStateCopyWith<$Res> implements $AddRequestMoneyStateCopyWith<$Res> {
  factory _$AddRequestMoneyStateCopyWith(_AddRequestMoneyState value, $Res Function(_AddRequestMoneyState) _then) = __$AddRequestMoneyStateCopyWithImpl;
@override @useResult
$Res call({
 double amount, String category, String note, List<String> recipients, bool isLoading, bool isSuccess, String? errorMessage
});




}
/// @nodoc
class __$AddRequestMoneyStateCopyWithImpl<$Res>
    implements _$AddRequestMoneyStateCopyWith<$Res> {
  __$AddRequestMoneyStateCopyWithImpl(this._self, this._then);

  final _AddRequestMoneyState _self;
  final $Res Function(_AddRequestMoneyState) _then;

/// Create a copy of AddRequestMoneyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? category = null,Object? note = null,Object? recipients = null,Object? isLoading = null,Object? isSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_AddRequestMoneyState(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,recipients: null == recipients ? _self._recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
