// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionEvidenceImage {

 String get storagePath; String? get fileName; String? get mimeType;@TimestampConverter() DateTime? get uploadedAt;
/// Create a copy of TransactionEvidenceImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionEvidenceImageCopyWith<TransactionEvidenceImage> get copyWith => _$TransactionEvidenceImageCopyWithImpl<TransactionEvidenceImage>(this as TransactionEvidenceImage, _$identity);

  /// Serializes this TransactionEvidenceImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionEvidenceImage&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storagePath,fileName,mimeType,uploadedAt);

@override
String toString() {
  return 'TransactionEvidenceImage(storagePath: $storagePath, fileName: $fileName, mimeType: $mimeType, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class $TransactionEvidenceImageCopyWith<$Res>  {
  factory $TransactionEvidenceImageCopyWith(TransactionEvidenceImage value, $Res Function(TransactionEvidenceImage) _then) = _$TransactionEvidenceImageCopyWithImpl;
@useResult
$Res call({
 String storagePath, String? fileName, String? mimeType,@TimestampConverter() DateTime? uploadedAt
});




}
/// @nodoc
class _$TransactionEvidenceImageCopyWithImpl<$Res>
    implements $TransactionEvidenceImageCopyWith<$Res> {
  _$TransactionEvidenceImageCopyWithImpl(this._self, this._then);

  final TransactionEvidenceImage _self;
  final $Res Function(TransactionEvidenceImage) _then;

/// Create a copy of TransactionEvidenceImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storagePath = null,Object? fileName = freezed,Object? mimeType = freezed,Object? uploadedAt = freezed,}) {
  return _then(_self.copyWith(
storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TransactionEvidenceImage extends TransactionEvidenceImage {
  const _TransactionEvidenceImage({required this.storagePath, this.fileName, this.mimeType, @TimestampConverter() this.uploadedAt}): super._();
  factory _TransactionEvidenceImage.fromJson(Map<String, dynamic> json) => _$TransactionEvidenceImageFromJson(json);

@override final  String storagePath;
@override final  String? fileName;
@override final  String? mimeType;
@override@TimestampConverter() final  DateTime? uploadedAt;

/// Create a copy of TransactionEvidenceImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionEvidenceImageCopyWith<_TransactionEvidenceImage> get copyWith => __$TransactionEvidenceImageCopyWithImpl<_TransactionEvidenceImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionEvidenceImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionEvidenceImage&&(identical(other.storagePath, storagePath) || other.storagePath == storagePath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storagePath,fileName,mimeType,uploadedAt);

@override
String toString() {
  return 'TransactionEvidenceImage(storagePath: $storagePath, fileName: $fileName, mimeType: $mimeType, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionEvidenceImageCopyWith<$Res> implements $TransactionEvidenceImageCopyWith<$Res> {
  factory _$TransactionEvidenceImageCopyWith(_TransactionEvidenceImage value, $Res Function(_TransactionEvidenceImage) _then) = __$TransactionEvidenceImageCopyWithImpl;
@override @useResult
$Res call({
 String storagePath, String? fileName, String? mimeType,@TimestampConverter() DateTime? uploadedAt
});




}
/// @nodoc
class __$TransactionEvidenceImageCopyWithImpl<$Res>
    implements _$TransactionEvidenceImageCopyWith<$Res> {
  __$TransactionEvidenceImageCopyWithImpl(this._self, this._then);

  final _TransactionEvidenceImage _self;
  final $Res Function(_TransactionEvidenceImage) _then;

/// Create a copy of TransactionEvidenceImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storagePath = null,Object? fileName = freezed,Object? mimeType = freezed,Object? uploadedAt = freezed,}) {
  return _then(_TransactionEvidenceImage(
storagePath: null == storagePath ? _self.storagePath : storagePath // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TransactionModel {

 String get transactionId; String get userId; String? get familyId; int get amountMinor; String get currency; String get type; String get categoryKey; String get categoryLabel; String? get categoryIcon; String? get note; String? get source; String? get merchantName;@TimestampConverter() DateTime get dateTs;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt; bool? get ocrUsed; double? get ocrConfidence; TransactionEvidenceImage? get evidenceImage;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.dateTs, dateTs) || other.dateTs == dateTs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ocrUsed, ocrUsed) || other.ocrUsed == ocrUsed)&&(identical(other.ocrConfidence, ocrConfidence) || other.ocrConfidence == ocrConfidence)&&(identical(other.evidenceImage, evidenceImage) || other.evidenceImage == evidenceImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,familyId,amountMinor,currency,type,categoryKey,categoryLabel,categoryIcon,note,source,merchantName,dateTs,createdAt,updatedAt,ocrUsed,ocrConfidence,evidenceImage);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, familyId: $familyId, amountMinor: $amountMinor, currency: $currency, type: $type, categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, note: $note, source: $source, merchantName: $merchantName, dateTs: $dateTs, createdAt: $createdAt, updatedAt: $updatedAt, ocrUsed: $ocrUsed, ocrConfidence: $ocrConfidence, evidenceImage: $evidenceImage)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String transactionId, String userId, String? familyId, int amountMinor, String currency, String type, String categoryKey, String categoryLabel, String? categoryIcon, String? note, String? source, String? merchantName,@TimestampConverter() DateTime dateTs,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool? ocrUsed, double? ocrConfidence, TransactionEvidenceImage? evidenceImage
});


$TransactionEvidenceImageCopyWith<$Res>? get evidenceImage;

}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? userId = null,Object? familyId = freezed,Object? amountMinor = null,Object? currency = null,Object? type = null,Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? note = freezed,Object? source = freezed,Object? merchantName = freezed,Object? dateTs = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? ocrUsed = freezed,Object? ocrConfidence = freezed,Object? evidenceImage = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,dateTs: null == dateTs ? _self.dateTs : dateTs // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ocrUsed: freezed == ocrUsed ? _self.ocrUsed : ocrUsed // ignore: cast_nullable_to_non_nullable
as bool?,ocrConfidence: freezed == ocrConfidence ? _self.ocrConfidence : ocrConfidence // ignore: cast_nullable_to_non_nullable
as double?,evidenceImage: freezed == evidenceImage ? _self.evidenceImage : evidenceImage // ignore: cast_nullable_to_non_nullable
as TransactionEvidenceImage?,
  ));
}
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionEvidenceImageCopyWith<$Res>? get evidenceImage {
    if (_self.evidenceImage == null) {
    return null;
  }

  return $TransactionEvidenceImageCopyWith<$Res>(_self.evidenceImage!, (value) {
    return _then(_self.copyWith(evidenceImage: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({required this.transactionId, required this.userId, this.familyId, required this.amountMinor, this.currency = 'VND', required this.type, required this.categoryKey, required this.categoryLabel, this.categoryIcon, this.note, this.source, this.merchantName, @TimestampConverter() required this.dateTs, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, this.ocrUsed, this.ocrConfidence, this.evidenceImage}): super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String transactionId;
@override final  String userId;
@override final  String? familyId;
@override final  int amountMinor;
@override@JsonKey() final  String currency;
@override final  String type;
@override final  String categoryKey;
@override final  String categoryLabel;
@override final  String? categoryIcon;
@override final  String? note;
@override final  String? source;
@override final  String? merchantName;
@override@TimestampConverter() final  DateTime dateTs;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  bool? ocrUsed;
@override final  double? ocrConfidence;
@override final  TransactionEvidenceImage? evidenceImage;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.note, note) || other.note == note)&&(identical(other.source, source) || other.source == source)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.dateTs, dateTs) || other.dateTs == dateTs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.ocrUsed, ocrUsed) || other.ocrUsed == ocrUsed)&&(identical(other.ocrConfidence, ocrConfidence) || other.ocrConfidence == ocrConfidence)&&(identical(other.evidenceImage, evidenceImage) || other.evidenceImage == evidenceImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,userId,familyId,amountMinor,currency,type,categoryKey,categoryLabel,categoryIcon,note,source,merchantName,dateTs,createdAt,updatedAt,ocrUsed,ocrConfidence,evidenceImage);

@override
String toString() {
  return 'TransactionModel(transactionId: $transactionId, userId: $userId, familyId: $familyId, amountMinor: $amountMinor, currency: $currency, type: $type, categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, note: $note, source: $source, merchantName: $merchantName, dateTs: $dateTs, createdAt: $createdAt, updatedAt: $updatedAt, ocrUsed: $ocrUsed, ocrConfidence: $ocrConfidence, evidenceImage: $evidenceImage)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, String userId, String? familyId, int amountMinor, String currency, String type, String categoryKey, String categoryLabel, String? categoryIcon, String? note, String? source, String? merchantName,@TimestampConverter() DateTime dateTs,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool? ocrUsed, double? ocrConfidence, TransactionEvidenceImage? evidenceImage
});


@override $TransactionEvidenceImageCopyWith<$Res>? get evidenceImage;

}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? userId = null,Object? familyId = freezed,Object? amountMinor = null,Object? currency = null,Object? type = null,Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? note = freezed,Object? source = freezed,Object? merchantName = freezed,Object? dateTs = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? ocrUsed = freezed,Object? ocrConfidence = freezed,Object? evidenceImage = freezed,}) {
  return _then(_TransactionModel(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,dateTs: null == dateTs ? _self.dateTs : dateTs // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,ocrUsed: freezed == ocrUsed ? _self.ocrUsed : ocrUsed // ignore: cast_nullable_to_non_nullable
as bool?,ocrConfidence: freezed == ocrConfidence ? _self.ocrConfidence : ocrConfidence // ignore: cast_nullable_to_non_nullable
as double?,evidenceImage: freezed == evidenceImage ? _self.evidenceImage : evidenceImage // ignore: cast_nullable_to_non_nullable
as TransactionEvidenceImage?,
  ));
}

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionEvidenceImageCopyWith<$Res>? get evidenceImage {
    if (_self.evidenceImage == null) {
    return null;
  }

  return $TransactionEvidenceImageCopyWith<$Res>(_self.evidenceImage!, (value) {
    return _then(_self.copyWith(evidenceImage: value));
  });
}
}

// dart format on
