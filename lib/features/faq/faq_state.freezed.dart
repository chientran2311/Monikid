// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FAQState {

 List<FAQModel> get faqList; bool get isLoading; String? get selectedItemId; String? get errorMessage;
/// Create a copy of FAQState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FAQStateCopyWith<FAQState> get copyWith => _$FAQStateCopyWithImpl<FAQState>(this as FAQState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FAQState&&const DeepCollectionEquality().equals(other.faqList, faqList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItemId, selectedItemId) || other.selectedItemId == selectedItemId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(faqList),isLoading,selectedItemId,errorMessage);

@override
String toString() {
  return 'FAQState(faqList: $faqList, isLoading: $isLoading, selectedItemId: $selectedItemId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FAQStateCopyWith<$Res>  {
  factory $FAQStateCopyWith(FAQState value, $Res Function(FAQState) _then) = _$FAQStateCopyWithImpl;
@useResult
$Res call({
 List<FAQModel> faqList, bool isLoading, String? selectedItemId, String? errorMessage
});




}
/// @nodoc
class _$FAQStateCopyWithImpl<$Res>
    implements $FAQStateCopyWith<$Res> {
  _$FAQStateCopyWithImpl(this._self, this._then);

  final FAQState _self;
  final $Res Function(FAQState) _then;

/// Create a copy of FAQState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faqList = null,Object? isLoading = null,Object? selectedItemId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
faqList: null == faqList ? _self.faqList : faqList // ignore: cast_nullable_to_non_nullable
as List<FAQModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItemId: freezed == selectedItemId ? _self.selectedItemId : selectedItemId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _FAQState extends FAQState {
  const _FAQState({final  List<FAQModel> faqList = const [], this.isLoading = true, this.selectedItemId, this.errorMessage}): _faqList = faqList,super._();
  

 final  List<FAQModel> _faqList;
@override@JsonKey() List<FAQModel> get faqList {
  if (_faqList is EqualUnmodifiableListView) return _faqList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faqList);
}

@override@JsonKey() final  bool isLoading;
@override final  String? selectedItemId;
@override final  String? errorMessage;

/// Create a copy of FAQState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FAQStateCopyWith<_FAQState> get copyWith => __$FAQStateCopyWithImpl<_FAQState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FAQState&&const DeepCollectionEquality().equals(other._faqList, _faqList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItemId, selectedItemId) || other.selectedItemId == selectedItemId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_faqList),isLoading,selectedItemId,errorMessage);

@override
String toString() {
  return 'FAQState(faqList: $faqList, isLoading: $isLoading, selectedItemId: $selectedItemId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FAQStateCopyWith<$Res> implements $FAQStateCopyWith<$Res> {
  factory _$FAQStateCopyWith(_FAQState value, $Res Function(_FAQState) _then) = __$FAQStateCopyWithImpl;
@override @useResult
$Res call({
 List<FAQModel> faqList, bool isLoading, String? selectedItemId, String? errorMessage
});




}
/// @nodoc
class __$FAQStateCopyWithImpl<$Res>
    implements _$FAQStateCopyWith<$Res> {
  __$FAQStateCopyWithImpl(this._self, this._then);

  final _FAQState _self;
  final $Res Function(_FAQState) _then;

/// Create a copy of FAQState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faqList = null,Object? isLoading = null,Object? selectedItemId = freezed,Object? errorMessage = freezed,}) {
  return _then(_FAQState(
faqList: null == faqList ? _self._faqList : faqList // ignore: cast_nullable_to_non_nullable
as List<FAQModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItemId: freezed == selectedItemId ? _self.selectedItemId : selectedItemId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
