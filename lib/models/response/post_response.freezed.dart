// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDataWrapper {

@JsonKey(name: 'data') List<PostResponseItem> get items;
/// Create a copy of PostDataWrapper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDataWrapperCopyWith<PostDataWrapper> get copyWith => _$PostDataWrapperCopyWithImpl<PostDataWrapper>(this as PostDataWrapper, _$identity);

  /// Serializes this PostDataWrapper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDataWrapper&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'PostDataWrapper(items: $items)';
}


}

/// @nodoc
abstract mixin class $PostDataWrapperCopyWith<$Res>  {
  factory $PostDataWrapperCopyWith(PostDataWrapper value, $Res Function(PostDataWrapper) _then) = _$PostDataWrapperCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<PostResponseItem> items
});




}
/// @nodoc
class _$PostDataWrapperCopyWithImpl<$Res>
    implements $PostDataWrapperCopyWith<$Res> {
  _$PostDataWrapperCopyWithImpl(this._self, this._then);

  final PostDataWrapper _self;
  final $Res Function(PostDataWrapper) _then;

/// Create a copy of PostDataWrapper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PostResponseItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PostDataWrapper].
extension PostDataWrapperPatterns on PostDataWrapper {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDataWrapper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDataWrapper() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDataWrapper value)  $default,){
final _that = this;
switch (_that) {
case _PostDataWrapper():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDataWrapper value)?  $default,){
final _that = this;
switch (_that) {
case _PostDataWrapper() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<PostResponseItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDataWrapper() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<PostResponseItem> items)  $default,) {final _that = this;
switch (_that) {
case _PostDataWrapper():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<PostResponseItem> items)?  $default,) {final _that = this;
switch (_that) {
case _PostDataWrapper() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDataWrapper implements PostDataWrapper {
  const _PostDataWrapper({@JsonKey(name: 'data') final  List<PostResponseItem> items = const []}): _items = items;
  factory _PostDataWrapper.fromJson(Map<String, dynamic> json) => _$PostDataWrapperFromJson(json);

 final  List<PostResponseItem> _items;
@override@JsonKey(name: 'data') List<PostResponseItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PostDataWrapper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDataWrapperCopyWith<_PostDataWrapper> get copyWith => __$PostDataWrapperCopyWithImpl<_PostDataWrapper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDataWrapperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDataWrapper&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'PostDataWrapper(items: $items)';
}


}

/// @nodoc
abstract mixin class _$PostDataWrapperCopyWith<$Res> implements $PostDataWrapperCopyWith<$Res> {
  factory _$PostDataWrapperCopyWith(_PostDataWrapper value, $Res Function(_PostDataWrapper) _then) = __$PostDataWrapperCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<PostResponseItem> items
});




}
/// @nodoc
class __$PostDataWrapperCopyWithImpl<$Res>
    implements _$PostDataWrapperCopyWith<$Res> {
  __$PostDataWrapperCopyWithImpl(this._self, this._then);

  final _PostDataWrapper _self;
  final $Res Function(_PostDataWrapper) _then;

/// Create a copy of PostDataWrapper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_PostDataWrapper(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PostResponseItem>,
  ));
}


}


/// @nodoc
mixin _$PostResponseItem {

 int get userId; int get id; String? get title; String? get body;
/// Create a copy of PostResponseItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostResponseItemCopyWith<PostResponseItem> get copyWith => _$PostResponseItemCopyWithImpl<PostResponseItem>(this as PostResponseItem, _$identity);

  /// Serializes this PostResponseItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostResponseItem&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,id,title,body);

@override
String toString() {
  return 'PostResponseItem(userId: $userId, id: $id, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class $PostResponseItemCopyWith<$Res>  {
  factory $PostResponseItemCopyWith(PostResponseItem value, $Res Function(PostResponseItem) _then) = _$PostResponseItemCopyWithImpl;
@useResult
$Res call({
 int userId, int id, String? title, String? body
});




}
/// @nodoc
class _$PostResponseItemCopyWithImpl<$Res>
    implements $PostResponseItemCopyWith<$Res> {
  _$PostResponseItemCopyWithImpl(this._self, this._then);

  final PostResponseItem _self;
  final $Res Function(PostResponseItem) _then;

/// Create a copy of PostResponseItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? id = null,Object? title = freezed,Object? body = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostResponseItem].
extension PostResponseItemPatterns on PostResponseItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostResponseItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostResponseItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostResponseItem value)  $default,){
final _that = this;
switch (_that) {
case _PostResponseItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostResponseItem value)?  $default,){
final _that = this;
switch (_that) {
case _PostResponseItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  int id,  String? title,  String? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostResponseItem() when $default != null:
return $default(_that.userId,_that.id,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  int id,  String? title,  String? body)  $default,) {final _that = this;
switch (_that) {
case _PostResponseItem():
return $default(_that.userId,_that.id,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  int id,  String? title,  String? body)?  $default,) {final _that = this;
switch (_that) {
case _PostResponseItem() when $default != null:
return $default(_that.userId,_that.id,_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostResponseItem implements PostResponseItem {
  const _PostResponseItem({required this.userId, required this.id, this.title, this.body});
  factory _PostResponseItem.fromJson(Map<String, dynamic> json) => _$PostResponseItemFromJson(json);

@override final  int userId;
@override final  int id;
@override final  String? title;
@override final  String? body;

/// Create a copy of PostResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostResponseItemCopyWith<_PostResponseItem> get copyWith => __$PostResponseItemCopyWithImpl<_PostResponseItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostResponseItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostResponseItem&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,id,title,body);

@override
String toString() {
  return 'PostResponseItem(userId: $userId, id: $id, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$PostResponseItemCopyWith<$Res> implements $PostResponseItemCopyWith<$Res> {
  factory _$PostResponseItemCopyWith(_PostResponseItem value, $Res Function(_PostResponseItem) _then) = __$PostResponseItemCopyWithImpl;
@override @useResult
$Res call({
 int userId, int id, String? title, String? body
});




}
/// @nodoc
class __$PostResponseItemCopyWithImpl<$Res>
    implements _$PostResponseItemCopyWith<$Res> {
  __$PostResponseItemCopyWithImpl(this._self, this._then);

  final _PostResponseItem _self;
  final $Res Function(_PostResponseItem) _then;

/// Create a copy of PostResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? id = null,Object? title = freezed,Object? body = freezed,}) {
  return _then(_PostResponseItem(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
