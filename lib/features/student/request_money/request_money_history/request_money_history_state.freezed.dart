// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_money_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestMoneyHistoryState {

 RequestMoneyModel? get request; bool get isSaving; bool get isDeleting; String? get errorMessage; bool get isSuccess;
/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestMoneyHistoryStateCopyWith<RequestMoneyHistoryState> get copyWith => _$RequestMoneyHistoryStateCopyWithImpl<RequestMoneyHistoryState>(this as RequestMoneyHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestMoneyHistoryState&&(identical(other.request, request) || other.request == request)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,request,isSaving,isDeleting,errorMessage,isSuccess);

@override
String toString() {
  return 'RequestMoneyHistoryState(request: $request, isSaving: $isSaving, isDeleting: $isDeleting, errorMessage: $errorMessage, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class $RequestMoneyHistoryStateCopyWith<$Res>  {
  factory $RequestMoneyHistoryStateCopyWith(RequestMoneyHistoryState value, $Res Function(RequestMoneyHistoryState) _then) = _$RequestMoneyHistoryStateCopyWithImpl;
@useResult
$Res call({
 RequestMoneyModel? request, bool isSaving, bool isDeleting, String? errorMessage, bool isSuccess
});


$RequestMoneyModelCopyWith<$Res>? get request;

}
/// @nodoc
class _$RequestMoneyHistoryStateCopyWithImpl<$Res>
    implements $RequestMoneyHistoryStateCopyWith<$Res> {
  _$RequestMoneyHistoryStateCopyWithImpl(this._self, this._then);

  final RequestMoneyHistoryState _self;
  final $Res Function(RequestMoneyHistoryState) _then;

/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? request = freezed,Object? isSaving = null,Object? isDeleting = null,Object? errorMessage = freezed,Object? isSuccess = null,}) {
  return _then(_self.copyWith(
request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestMoneyModel?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestMoneyModelCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $RequestMoneyModelCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// @nodoc


class _RequestMoneyHistoryState extends RequestMoneyHistoryState {
  const _RequestMoneyHistoryState({this.request, this.isSaving = false, this.isDeleting = false, this.errorMessage, this.isSuccess = false}): super._();
  

@override final  RequestMoneyModel? request;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isDeleting;
@override final  String? errorMessage;
@override@JsonKey() final  bool isSuccess;

/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestMoneyHistoryStateCopyWith<_RequestMoneyHistoryState> get copyWith => __$RequestMoneyHistoryStateCopyWithImpl<_RequestMoneyHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestMoneyHistoryState&&(identical(other.request, request) || other.request == request)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,request,isSaving,isDeleting,errorMessage,isSuccess);

@override
String toString() {
  return 'RequestMoneyHistoryState(request: $request, isSaving: $isSaving, isDeleting: $isDeleting, errorMessage: $errorMessage, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class _$RequestMoneyHistoryStateCopyWith<$Res> implements $RequestMoneyHistoryStateCopyWith<$Res> {
  factory _$RequestMoneyHistoryStateCopyWith(_RequestMoneyHistoryState value, $Res Function(_RequestMoneyHistoryState) _then) = __$RequestMoneyHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 RequestMoneyModel? request, bool isSaving, bool isDeleting, String? errorMessage, bool isSuccess
});


@override $RequestMoneyModelCopyWith<$Res>? get request;

}
/// @nodoc
class __$RequestMoneyHistoryStateCopyWithImpl<$Res>
    implements _$RequestMoneyHistoryStateCopyWith<$Res> {
  __$RequestMoneyHistoryStateCopyWithImpl(this._self, this._then);

  final _RequestMoneyHistoryState _self;
  final $Res Function(_RequestMoneyHistoryState) _then;

/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? request = freezed,Object? isSaving = null,Object? isDeleting = null,Object? errorMessage = freezed,Object? isSuccess = null,}) {
  return _then(_RequestMoneyHistoryState(
request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestMoneyModel?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RequestMoneyHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestMoneyModelCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $RequestMoneyModelCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
