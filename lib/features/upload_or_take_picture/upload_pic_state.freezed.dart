// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_pic_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UploadPicState {

 bool get isUploadPic; bool get isTakePic; String? get imagePath; String? get errorMessage;
/// Create a copy of UploadPicState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadPicStateCopyWith<UploadPicState> get copyWith => _$UploadPicStateCopyWithImpl<UploadPicState>(this as UploadPicState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadPicState&&(identical(other.isUploadPic, isUploadPic) || other.isUploadPic == isUploadPic)&&(identical(other.isTakePic, isTakePic) || other.isTakePic == isTakePic)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isUploadPic,isTakePic,imagePath,errorMessage);

@override
String toString() {
  return 'UploadPicState(isUploadPic: $isUploadPic, isTakePic: $isTakePic, imagePath: $imagePath, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UploadPicStateCopyWith<$Res>  {
  factory $UploadPicStateCopyWith(UploadPicState value, $Res Function(UploadPicState) _then) = _$UploadPicStateCopyWithImpl;
@useResult
$Res call({
 bool isUploadPic, bool isTakePic, String? imagePath, String? errorMessage
});




}
/// @nodoc
class _$UploadPicStateCopyWithImpl<$Res>
    implements $UploadPicStateCopyWith<$Res> {
  _$UploadPicStateCopyWithImpl(this._self, this._then);

  final UploadPicState _self;
  final $Res Function(UploadPicState) _then;

/// Create a copy of UploadPicState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUploadPic = null,Object? isTakePic = null,Object? imagePath = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isUploadPic: null == isUploadPic ? _self.isUploadPic : isUploadPic // ignore: cast_nullable_to_non_nullable
as bool,isTakePic: null == isTakePic ? _self.isTakePic : isTakePic // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _UploadPicState extends UploadPicState {
  const _UploadPicState({this.isUploadPic = false, this.isTakePic = false, this.imagePath, this.errorMessage}): super._();
  

@override@JsonKey() final  bool isUploadPic;
@override@JsonKey() final  bool isTakePic;
@override final  String? imagePath;
@override final  String? errorMessage;

/// Create a copy of UploadPicState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadPicStateCopyWith<_UploadPicState> get copyWith => __$UploadPicStateCopyWithImpl<_UploadPicState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadPicState&&(identical(other.isUploadPic, isUploadPic) || other.isUploadPic == isUploadPic)&&(identical(other.isTakePic, isTakePic) || other.isTakePic == isTakePic)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isUploadPic,isTakePic,imagePath,errorMessage);

@override
String toString() {
  return 'UploadPicState(isUploadPic: $isUploadPic, isTakePic: $isTakePic, imagePath: $imagePath, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$UploadPicStateCopyWith<$Res> implements $UploadPicStateCopyWith<$Res> {
  factory _$UploadPicStateCopyWith(_UploadPicState value, $Res Function(_UploadPicState) _then) = __$UploadPicStateCopyWithImpl;
@override @useResult
$Res call({
 bool isUploadPic, bool isTakePic, String? imagePath, String? errorMessage
});




}
/// @nodoc
class __$UploadPicStateCopyWithImpl<$Res>
    implements _$UploadPicStateCopyWith<$Res> {
  __$UploadPicStateCopyWithImpl(this._self, this._then);

  final _UploadPicState _self;
  final $Res Function(_UploadPicState) _then;

/// Create a copy of UploadPicState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUploadPic = null,Object? isTakePic = null,Object? imagePath = freezed,Object? errorMessage = freezed,}) {
  return _then(_UploadPicState(
isUploadPic: null == isUploadPic ? _self.isUploadPic : isUploadPic // ignore: cast_nullable_to_non_nullable
as bool,isTakePic: null == isTakePic ? _self.isTakePic : isTakePic // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
