// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choose_ai_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChooseAiModelState {

 ChooseAiModelStatus get status; String get apiKeyInput; String get promptInput; bool get hasSavedApiKey; String get selectedModel; String? get responseText; TransactionAiResult? get transactionAiResult; ChooseAiModelError? get error; GemmaDownloadStatus get gemmaStatus; double get gemmaDownloadProgress; String? get gemmaDownloadError;
/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseAiModelStateCopyWith<ChooseAiModelState> get copyWith => _$ChooseAiModelStateCopyWithImpl<ChooseAiModelState>(this as ChooseAiModelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseAiModelState&&(identical(other.status, status) || other.status == status)&&(identical(other.apiKeyInput, apiKeyInput) || other.apiKeyInput == apiKeyInput)&&(identical(other.promptInput, promptInput) || other.promptInput == promptInput)&&(identical(other.hasSavedApiKey, hasSavedApiKey) || other.hasSavedApiKey == hasSavedApiKey)&&(identical(other.selectedModel, selectedModel) || other.selectedModel == selectedModel)&&(identical(other.responseText, responseText) || other.responseText == responseText)&&(identical(other.transactionAiResult, transactionAiResult) || other.transactionAiResult == transactionAiResult)&&(identical(other.error, error) || other.error == error)&&(identical(other.gemmaStatus, gemmaStatus) || other.gemmaStatus == gemmaStatus)&&(identical(other.gemmaDownloadProgress, gemmaDownloadProgress) || other.gemmaDownloadProgress == gemmaDownloadProgress)&&(identical(other.gemmaDownloadError, gemmaDownloadError) || other.gemmaDownloadError == gemmaDownloadError));
}


@override
int get hashCode => Object.hash(runtimeType,status,apiKeyInput,promptInput,hasSavedApiKey,selectedModel,responseText,transactionAiResult,error,gemmaStatus,gemmaDownloadProgress,gemmaDownloadError);

@override
String toString() {
  return 'ChooseAiModelState(status: $status, apiKeyInput: $apiKeyInput, promptInput: $promptInput, hasSavedApiKey: $hasSavedApiKey, selectedModel: $selectedModel, responseText: $responseText, transactionAiResult: $transactionAiResult, error: $error, gemmaStatus: $gemmaStatus, gemmaDownloadProgress: $gemmaDownloadProgress, gemmaDownloadError: $gemmaDownloadError)';
}


}

/// @nodoc
abstract mixin class $ChooseAiModelStateCopyWith<$Res>  {
  factory $ChooseAiModelStateCopyWith(ChooseAiModelState value, $Res Function(ChooseAiModelState) _then) = _$ChooseAiModelStateCopyWithImpl;
@useResult
$Res call({
 ChooseAiModelStatus status, String apiKeyInput, String promptInput, bool hasSavedApiKey, String selectedModel, String? responseText, TransactionAiResult? transactionAiResult, ChooseAiModelError? error, GemmaDownloadStatus gemmaStatus, double gemmaDownloadProgress, String? gemmaDownloadError
});


$TransactionAiResultCopyWith<$Res>? get transactionAiResult;

}
/// @nodoc
class _$ChooseAiModelStateCopyWithImpl<$Res>
    implements $ChooseAiModelStateCopyWith<$Res> {
  _$ChooseAiModelStateCopyWithImpl(this._self, this._then);

  final ChooseAiModelState _self;
  final $Res Function(ChooseAiModelState) _then;

/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? apiKeyInput = null,Object? promptInput = null,Object? hasSavedApiKey = null,Object? selectedModel = null,Object? responseText = freezed,Object? transactionAiResult = freezed,Object? error = freezed,Object? gemmaStatus = null,Object? gemmaDownloadProgress = null,Object? gemmaDownloadError = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseAiModelStatus,apiKeyInput: null == apiKeyInput ? _self.apiKeyInput : apiKeyInput // ignore: cast_nullable_to_non_nullable
as String,promptInput: null == promptInput ? _self.promptInput : promptInput // ignore: cast_nullable_to_non_nullable
as String,hasSavedApiKey: null == hasSavedApiKey ? _self.hasSavedApiKey : hasSavedApiKey // ignore: cast_nullable_to_non_nullable
as bool,selectedModel: null == selectedModel ? _self.selectedModel : selectedModel // ignore: cast_nullable_to_non_nullable
as String,responseText: freezed == responseText ? _self.responseText : responseText // ignore: cast_nullable_to_non_nullable
as String?,transactionAiResult: freezed == transactionAiResult ? _self.transactionAiResult : transactionAiResult // ignore: cast_nullable_to_non_nullable
as TransactionAiResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ChooseAiModelError?,gemmaStatus: null == gemmaStatus ? _self.gemmaStatus : gemmaStatus // ignore: cast_nullable_to_non_nullable
as GemmaDownloadStatus,gemmaDownloadProgress: null == gemmaDownloadProgress ? _self.gemmaDownloadProgress : gemmaDownloadProgress // ignore: cast_nullable_to_non_nullable
as double,gemmaDownloadError: freezed == gemmaDownloadError ? _self.gemmaDownloadError : gemmaDownloadError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionAiResultCopyWith<$Res>? get transactionAiResult {
    if (_self.transactionAiResult == null) {
    return null;
  }

  return $TransactionAiResultCopyWith<$Res>(_self.transactionAiResult!, (value) {
    return _then(_self.copyWith(transactionAiResult: value));
  });
}
}


/// @nodoc


class _ChooseAiModelState extends ChooseAiModelState {
  const _ChooseAiModelState({this.status = ChooseAiModelStatus.initial, this.apiKeyInput = '', this.promptInput = '', this.hasSavedApiKey = false, this.selectedModel = 'gemini-2.5-flash', this.responseText, this.transactionAiResult, this.error, this.gemmaStatus = GemmaDownloadStatus.idle, this.gemmaDownloadProgress = 0.0, this.gemmaDownloadError}): super._();
  

@override@JsonKey() final  ChooseAiModelStatus status;
@override@JsonKey() final  String apiKeyInput;
@override@JsonKey() final  String promptInput;
@override@JsonKey() final  bool hasSavedApiKey;
@override@JsonKey() final  String selectedModel;
@override final  String? responseText;
@override final  TransactionAiResult? transactionAiResult;
@override final  ChooseAiModelError? error;
@override@JsonKey() final  GemmaDownloadStatus gemmaStatus;
@override@JsonKey() final  double gemmaDownloadProgress;
@override final  String? gemmaDownloadError;

/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChooseAiModelStateCopyWith<_ChooseAiModelState> get copyWith => __$ChooseAiModelStateCopyWithImpl<_ChooseAiModelState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChooseAiModelState&&(identical(other.status, status) || other.status == status)&&(identical(other.apiKeyInput, apiKeyInput) || other.apiKeyInput == apiKeyInput)&&(identical(other.promptInput, promptInput) || other.promptInput == promptInput)&&(identical(other.hasSavedApiKey, hasSavedApiKey) || other.hasSavedApiKey == hasSavedApiKey)&&(identical(other.selectedModel, selectedModel) || other.selectedModel == selectedModel)&&(identical(other.responseText, responseText) || other.responseText == responseText)&&(identical(other.transactionAiResult, transactionAiResult) || other.transactionAiResult == transactionAiResult)&&(identical(other.error, error) || other.error == error)&&(identical(other.gemmaStatus, gemmaStatus) || other.gemmaStatus == gemmaStatus)&&(identical(other.gemmaDownloadProgress, gemmaDownloadProgress) || other.gemmaDownloadProgress == gemmaDownloadProgress)&&(identical(other.gemmaDownloadError, gemmaDownloadError) || other.gemmaDownloadError == gemmaDownloadError));
}


@override
int get hashCode => Object.hash(runtimeType,status,apiKeyInput,promptInput,hasSavedApiKey,selectedModel,responseText,transactionAiResult,error,gemmaStatus,gemmaDownloadProgress,gemmaDownloadError);

@override
String toString() {
  return 'ChooseAiModelState(status: $status, apiKeyInput: $apiKeyInput, promptInput: $promptInput, hasSavedApiKey: $hasSavedApiKey, selectedModel: $selectedModel, responseText: $responseText, transactionAiResult: $transactionAiResult, error: $error, gemmaStatus: $gemmaStatus, gemmaDownloadProgress: $gemmaDownloadProgress, gemmaDownloadError: $gemmaDownloadError)';
}


}

/// @nodoc
abstract mixin class _$ChooseAiModelStateCopyWith<$Res> implements $ChooseAiModelStateCopyWith<$Res> {
  factory _$ChooseAiModelStateCopyWith(_ChooseAiModelState value, $Res Function(_ChooseAiModelState) _then) = __$ChooseAiModelStateCopyWithImpl;
@override @useResult
$Res call({
 ChooseAiModelStatus status, String apiKeyInput, String promptInput, bool hasSavedApiKey, String selectedModel, String? responseText, TransactionAiResult? transactionAiResult, ChooseAiModelError? error, GemmaDownloadStatus gemmaStatus, double gemmaDownloadProgress, String? gemmaDownloadError
});


@override $TransactionAiResultCopyWith<$Res>? get transactionAiResult;

}
/// @nodoc
class __$ChooseAiModelStateCopyWithImpl<$Res>
    implements _$ChooseAiModelStateCopyWith<$Res> {
  __$ChooseAiModelStateCopyWithImpl(this._self, this._then);

  final _ChooseAiModelState _self;
  final $Res Function(_ChooseAiModelState) _then;

/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? apiKeyInput = null,Object? promptInput = null,Object? hasSavedApiKey = null,Object? selectedModel = null,Object? responseText = freezed,Object? transactionAiResult = freezed,Object? error = freezed,Object? gemmaStatus = null,Object? gemmaDownloadProgress = null,Object? gemmaDownloadError = freezed,}) {
  return _then(_ChooseAiModelState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseAiModelStatus,apiKeyInput: null == apiKeyInput ? _self.apiKeyInput : apiKeyInput // ignore: cast_nullable_to_non_nullable
as String,promptInput: null == promptInput ? _self.promptInput : promptInput // ignore: cast_nullable_to_non_nullable
as String,hasSavedApiKey: null == hasSavedApiKey ? _self.hasSavedApiKey : hasSavedApiKey // ignore: cast_nullable_to_non_nullable
as bool,selectedModel: null == selectedModel ? _self.selectedModel : selectedModel // ignore: cast_nullable_to_non_nullable
as String,responseText: freezed == responseText ? _self.responseText : responseText // ignore: cast_nullable_to_non_nullable
as String?,transactionAiResult: freezed == transactionAiResult ? _self.transactionAiResult : transactionAiResult // ignore: cast_nullable_to_non_nullable
as TransactionAiResult?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ChooseAiModelError?,gemmaStatus: null == gemmaStatus ? _self.gemmaStatus : gemmaStatus // ignore: cast_nullable_to_non_nullable
as GemmaDownloadStatus,gemmaDownloadProgress: null == gemmaDownloadProgress ? _self.gemmaDownloadProgress : gemmaDownloadProgress // ignore: cast_nullable_to_non_nullable
as double,gemmaDownloadError: freezed == gemmaDownloadError ? _self.gemmaDownloadError : gemmaDownloadError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChooseAiModelState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionAiResultCopyWith<$Res>? get transactionAiResult {
    if (_self.transactionAiResult == null) {
    return null;
  }

  return $TransactionAiResultCopyWith<$Res>(_self.transactionAiResult!, (value) {
    return _then(_self.copyWith(transactionAiResult: value));
  });
}
}

// dart format on
