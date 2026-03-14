// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fqa_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FQAState {

 List<FQAModel> get fqaList; bool get isLoading; String? get selectedItemId; String? get errorMessage;
/// Create a copy of FQAState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FQAStateCopyWith<FQAState> get copyWith => _$FQAStateCopyWithImpl<FQAState>(this as FQAState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FQAState&&const DeepCollectionEquality().equals(other.fqaList, fqaList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItemId, selectedItemId) || other.selectedItemId == selectedItemId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fqaList),isLoading,selectedItemId,errorMessage);

@override
String toString() {
  return 'FQAState(fqaList: $fqaList, isLoading: $isLoading, selectedItemId: $selectedItemId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FQAStateCopyWith<$Res>  {
  factory $FQAStateCopyWith(FQAState value, $Res Function(FQAState) _then) = _$FQAStateCopyWithImpl;
@useResult
$Res call({
 List<FQAModel> fqaList, bool isLoading, String? selectedItemId, String? errorMessage
});




}
/// @nodoc
class _$FQAStateCopyWithImpl<$Res>
    implements $FQAStateCopyWith<$Res> {
  _$FQAStateCopyWithImpl(this._self, this._then);

  final FQAState _self;
  final $Res Function(FQAState) _then;

/// Create a copy of FQAState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fqaList = null,Object? isLoading = null,Object? selectedItemId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
fqaList: null == fqaList ? _self.fqaList : fqaList // ignore: cast_nullable_to_non_nullable
as List<FQAModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItemId: freezed == selectedItemId ? _self.selectedItemId : selectedItemId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _FQAState extends FQAState {
  const _FQAState({final  List<FQAModel> fqaList = const [], this.isLoading = true, this.selectedItemId, this.errorMessage}): _fqaList = fqaList,super._();
  

 final  List<FQAModel> _fqaList;
@override@JsonKey() List<FQAModel> get fqaList {
  if (_fqaList is EqualUnmodifiableListView) return _fqaList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fqaList);
}

@override@JsonKey() final  bool isLoading;
@override final  String? selectedItemId;
@override final  String? errorMessage;

/// Create a copy of FQAState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FQAStateCopyWith<_FQAState> get copyWith => __$FQAStateCopyWithImpl<_FQAState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FQAState&&const DeepCollectionEquality().equals(other._fqaList, _fqaList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItemId, selectedItemId) || other.selectedItemId == selectedItemId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fqaList),isLoading,selectedItemId,errorMessage);

@override
String toString() {
  return 'FQAState(fqaList: $fqaList, isLoading: $isLoading, selectedItemId: $selectedItemId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FQAStateCopyWith<$Res> implements $FQAStateCopyWith<$Res> {
  factory _$FQAStateCopyWith(_FQAState value, $Res Function(_FQAState) _then) = __$FQAStateCopyWithImpl;
@override @useResult
$Res call({
 List<FQAModel> fqaList, bool isLoading, String? selectedItemId, String? errorMessage
});




}
/// @nodoc
class __$FQAStateCopyWithImpl<$Res>
    implements _$FQAStateCopyWith<$Res> {
  __$FQAStateCopyWithImpl(this._self, this._then);

  final _FQAState _self;
  final $Res Function(_FQAState) _then;

/// Create a copy of FQAState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fqaList = null,Object? isLoading = null,Object? selectedItemId = freezed,Object? errorMessage = freezed,}) {
  return _then(_FQAState(
fqaList: null == fqaList ? _self._fqaList : fqaList // ignore: cast_nullable_to_non_nullable
as List<FQAModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItemId: freezed == selectedItemId ? _self.selectedItemId : selectedItemId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
