// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_convention_hint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceiptConventionHint {

 String? get purpose; String? get merchant;// ignore: invalid_annotation_target
@JsonKey(name: 'category_hint') String? get categoryHint;
/// Create a copy of ReceiptConventionHint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptConventionHintCopyWith<ReceiptConventionHint> get copyWith => _$ReceiptConventionHintCopyWithImpl<ReceiptConventionHint>(this as ReceiptConventionHint, _$identity);

  /// Serializes this ReceiptConventionHint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptConventionHint&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.categoryHint, categoryHint) || other.categoryHint == categoryHint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,merchant,categoryHint);

@override
String toString() {
  return 'ReceiptConventionHint(purpose: $purpose, merchant: $merchant, categoryHint: $categoryHint)';
}


}

/// @nodoc
abstract mixin class $ReceiptConventionHintCopyWith<$Res>  {
  factory $ReceiptConventionHintCopyWith(ReceiptConventionHint value, $Res Function(ReceiptConventionHint) _then) = _$ReceiptConventionHintCopyWithImpl;
@useResult
$Res call({
 String? purpose, String? merchant,@JsonKey(name: 'category_hint') String? categoryHint
});




}
/// @nodoc
class _$ReceiptConventionHintCopyWithImpl<$Res>
    implements $ReceiptConventionHintCopyWith<$Res> {
  _$ReceiptConventionHintCopyWithImpl(this._self, this._then);

  final ReceiptConventionHint _self;
  final $Res Function(ReceiptConventionHint) _then;

/// Create a copy of ReceiptConventionHint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purpose = freezed,Object? merchant = freezed,Object? categoryHint = freezed,}) {
  return _then(_self.copyWith(
purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String?,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,categoryHint: freezed == categoryHint ? _self.categoryHint : categoryHint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ReceiptConventionHint implements ReceiptConventionHint {
  const _ReceiptConventionHint({this.purpose, this.merchant, @JsonKey(name: 'category_hint') this.categoryHint});
  factory _ReceiptConventionHint.fromJson(Map<String, dynamic> json) => _$ReceiptConventionHintFromJson(json);

@override final  String? purpose;
@override final  String? merchant;
// ignore: invalid_annotation_target
@override@JsonKey(name: 'category_hint') final  String? categoryHint;

/// Create a copy of ReceiptConventionHint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptConventionHintCopyWith<_ReceiptConventionHint> get copyWith => __$ReceiptConventionHintCopyWithImpl<_ReceiptConventionHint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiptConventionHintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptConventionHint&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.categoryHint, categoryHint) || other.categoryHint == categoryHint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,merchant,categoryHint);

@override
String toString() {
  return 'ReceiptConventionHint(purpose: $purpose, merchant: $merchant, categoryHint: $categoryHint)';
}


}

/// @nodoc
abstract mixin class _$ReceiptConventionHintCopyWith<$Res> implements $ReceiptConventionHintCopyWith<$Res> {
  factory _$ReceiptConventionHintCopyWith(_ReceiptConventionHint value, $Res Function(_ReceiptConventionHint) _then) = __$ReceiptConventionHintCopyWithImpl;
@override @useResult
$Res call({
 String? purpose, String? merchant,@JsonKey(name: 'category_hint') String? categoryHint
});




}
/// @nodoc
class __$ReceiptConventionHintCopyWithImpl<$Res>
    implements _$ReceiptConventionHintCopyWith<$Res> {
  __$ReceiptConventionHintCopyWithImpl(this._self, this._then);

  final _ReceiptConventionHint _self;
  final $Res Function(_ReceiptConventionHint) _then;

/// Create a copy of ReceiptConventionHint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purpose = freezed,Object? merchant = freezed,Object? categoryHint = freezed,}) {
  return _then(_ReceiptConventionHint(
purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String?,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,categoryHint: freezed == categoryHint ? _self.categoryHint : categoryHint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
