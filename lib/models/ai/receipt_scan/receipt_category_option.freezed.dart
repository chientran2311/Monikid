// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_category_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptCategoryOption {

 String get key; String get label; String get type;
/// Create a copy of ReceiptCategoryOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptCategoryOptionCopyWith<ReceiptCategoryOption> get copyWith => _$ReceiptCategoryOptionCopyWithImpl<ReceiptCategoryOption>(this as ReceiptCategoryOption, _$identity);

  /// Serializes this ReceiptCategoryOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptCategoryOption&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,type);

@override
String toString() {
  return 'ReceiptCategoryOption(key: $key, label: $label, type: $type)';
}


}

/// @nodoc
abstract mixin class $ReceiptCategoryOptionCopyWith<$Res>  {
  factory $ReceiptCategoryOptionCopyWith(ReceiptCategoryOption value, $Res Function(ReceiptCategoryOption) _then) = _$ReceiptCategoryOptionCopyWithImpl;
@useResult
$Res call({
 String key, String label, String type
});




}
/// @nodoc
class _$ReceiptCategoryOptionCopyWithImpl<$Res>
    implements $ReceiptCategoryOptionCopyWith<$Res> {
  _$ReceiptCategoryOptionCopyWithImpl(this._self, this._then);

  final ReceiptCategoryOption _self;
  final $Res Function(ReceiptCategoryOption) _then;

/// Create a copy of ReceiptCategoryOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? type = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ReceiptCategoryOption implements ReceiptCategoryOption {
  const _ReceiptCategoryOption({required this.key, required this.label, required this.type});
  factory _ReceiptCategoryOption.fromJson(Map<String, dynamic> json) => _$ReceiptCategoryOptionFromJson(json);

@override final  String key;
@override final  String label;
@override final  String type;

/// Create a copy of ReceiptCategoryOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptCategoryOptionCopyWith<_ReceiptCategoryOption> get copyWith => __$ReceiptCategoryOptionCopyWithImpl<_ReceiptCategoryOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptCategoryOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptCategoryOption&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,type);

@override
String toString() {
  return 'ReceiptCategoryOption(key: $key, label: $label, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ReceiptCategoryOptionCopyWith<$Res> implements $ReceiptCategoryOptionCopyWith<$Res> {
  factory _$ReceiptCategoryOptionCopyWith(_ReceiptCategoryOption value, $Res Function(_ReceiptCategoryOption) _then) = __$ReceiptCategoryOptionCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String type
});




}
/// @nodoc
class __$ReceiptCategoryOptionCopyWithImpl<$Res>
    implements _$ReceiptCategoryOptionCopyWith<$Res> {
  __$ReceiptCategoryOptionCopyWithImpl(this._self, this._then);

  final _ReceiptCategoryOption _self;
  final $Res Function(_ReceiptCategoryOption) _then;

/// Create a copy of ReceiptCategoryOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? type = null,}) {
  return _then(_ReceiptCategoryOption(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
