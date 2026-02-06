// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostProviderState {

 List<PostResponseItem> get postList; bool get isLoading; int get selectedItem; int get page; bool get hasMore; bool get isLoadingMore; bool get isLocalMode; String? get errorMessage;
/// Create a copy of PostProviderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostProviderStateCopyWith<PostProviderState> get copyWith => _$PostProviderStateCopyWithImpl<PostProviderState>(this as PostProviderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostProviderState&&const DeepCollectionEquality().equals(other.postList, postList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLocalMode, isLocalMode) || other.isLocalMode == isLocalMode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(postList),isLoading,selectedItem,page,hasMore,isLoadingMore,isLocalMode,errorMessage);

@override
String toString() {
  return 'PostProviderState(postList: $postList, isLoading: $isLoading, selectedItem: $selectedItem, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, isLocalMode: $isLocalMode, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PostProviderStateCopyWith<$Res>  {
  factory $PostProviderStateCopyWith(PostProviderState value, $Res Function(PostProviderState) _then) = _$PostProviderStateCopyWithImpl;
@useResult
$Res call({
 List<PostResponseItem> postList, bool isLoading, int selectedItem, int page, bool hasMore, bool isLoadingMore, bool isLocalMode, String? errorMessage
});




}
/// @nodoc
class _$PostProviderStateCopyWithImpl<$Res>
    implements $PostProviderStateCopyWith<$Res> {
  _$PostProviderStateCopyWithImpl(this._self, this._then);

  final PostProviderState _self;
  final $Res Function(PostProviderState) _then;

/// Create a copy of PostProviderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postList = null,Object? isLoading = null,Object? selectedItem = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? isLocalMode = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
postList: null == postList ? _self.postList : postList // ignore: cast_nullable_to_non_nullable
as List<PostResponseItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItem: null == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isLocalMode: null == isLocalMode ? _self.isLocalMode : isLocalMode // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostProviderState].
extension PostProviderStatePatterns on PostProviderState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostProviderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostProviderState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostProviderState value)  $default,){
final _that = this;
switch (_that) {
case _PostProviderState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostProviderState value)?  $default,){
final _that = this;
switch (_that) {
case _PostProviderState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PostResponseItem> postList,  bool isLoading,  int selectedItem,  int page,  bool hasMore,  bool isLoadingMore,  bool isLocalMode,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostProviderState() when $default != null:
return $default(_that.postList,_that.isLoading,_that.selectedItem,_that.page,_that.hasMore,_that.isLoadingMore,_that.isLocalMode,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PostResponseItem> postList,  bool isLoading,  int selectedItem,  int page,  bool hasMore,  bool isLoadingMore,  bool isLocalMode,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PostProviderState():
return $default(_that.postList,_that.isLoading,_that.selectedItem,_that.page,_that.hasMore,_that.isLoadingMore,_that.isLocalMode,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PostResponseItem> postList,  bool isLoading,  int selectedItem,  int page,  bool hasMore,  bool isLoadingMore,  bool isLocalMode,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PostProviderState() when $default != null:
return $default(_that.postList,_that.isLoading,_that.selectedItem,_that.page,_that.hasMore,_that.isLoadingMore,_that.isLocalMode,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PostProviderState extends PostProviderState {
  const _PostProviderState({final  List<PostResponseItem> postList = const [], this.isLoading = false, this.selectedItem = -1, this.page = 1, this.hasMore = true, this.isLoadingMore = false, this.isLocalMode = false, this.errorMessage}): _postList = postList,super._();
  

 final  List<PostResponseItem> _postList;
@override@JsonKey() List<PostResponseItem> get postList {
  if (_postList is EqualUnmodifiableListView) return _postList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postList);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int selectedItem;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isLocalMode;
@override final  String? errorMessage;

/// Create a copy of PostProviderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostProviderStateCopyWith<_PostProviderState> get copyWith => __$PostProviderStateCopyWithImpl<_PostProviderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostProviderState&&const DeepCollectionEquality().equals(other._postList, _postList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isLocalMode, isLocalMode) || other.isLocalMode == isLocalMode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_postList),isLoading,selectedItem,page,hasMore,isLoadingMore,isLocalMode,errorMessage);

@override
String toString() {
  return 'PostProviderState(postList: $postList, isLoading: $isLoading, selectedItem: $selectedItem, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, isLocalMode: $isLocalMode, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PostProviderStateCopyWith<$Res> implements $PostProviderStateCopyWith<$Res> {
  factory _$PostProviderStateCopyWith(_PostProviderState value, $Res Function(_PostProviderState) _then) = __$PostProviderStateCopyWithImpl;
@override @useResult
$Res call({
 List<PostResponseItem> postList, bool isLoading, int selectedItem, int page, bool hasMore, bool isLoadingMore, bool isLocalMode, String? errorMessage
});




}
/// @nodoc
class __$PostProviderStateCopyWithImpl<$Res>
    implements _$PostProviderStateCopyWith<$Res> {
  __$PostProviderStateCopyWithImpl(this._self, this._then);

  final _PostProviderState _self;
  final $Res Function(_PostProviderState) _then;

/// Create a copy of PostProviderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postList = null,Object? isLoading = null,Object? selectedItem = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? isLocalMode = null,Object? errorMessage = freezed,}) {
  return _then(_PostProviderState(
postList: null == postList ? _self._postList : postList // ignore: cast_nullable_to_non_nullable
as List<PostResponseItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedItem: null == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isLocalMode: null == isLocalMode ? _self.isLocalMode : isLocalMode // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
