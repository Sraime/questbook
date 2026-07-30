// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameTable {

 String get id; String get title; String get universeLabel; DateTime? get nextSession; String? get systemId;
/// Create a copy of GameTable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameTableCopyWith<GameTable> get copyWith => _$GameTableCopyWithImpl<GameTable>(this as GameTable, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameTable&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.universeLabel, universeLabel) || other.universeLabel == universeLabel)&&(identical(other.nextSession, nextSession) || other.nextSession == nextSession)&&(identical(other.systemId, systemId) || other.systemId == systemId));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,universeLabel,nextSession,systemId);

@override
String toString() {
  return 'GameTable(id: $id, title: $title, universeLabel: $universeLabel, nextSession: $nextSession, systemId: $systemId)';
}


}

/// @nodoc
abstract mixin class $GameTableCopyWith<$Res>  {
  factory $GameTableCopyWith(GameTable value, $Res Function(GameTable) _then) = _$GameTableCopyWithImpl;
@useResult
$Res call({
 String id, String title, String universeLabel, DateTime? nextSession, String? systemId
});




}
/// @nodoc
class _$GameTableCopyWithImpl<$Res>
    implements $GameTableCopyWith<$Res> {
  _$GameTableCopyWithImpl(this._self, this._then);

  final GameTable _self;
  final $Res Function(GameTable) _then;

/// Create a copy of GameTable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? universeLabel = null,Object? nextSession = freezed,Object? systemId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,universeLabel: null == universeLabel ? _self.universeLabel : universeLabel // ignore: cast_nullable_to_non_nullable
as String,nextSession: freezed == nextSession ? _self.nextSession : nextSession // ignore: cast_nullable_to_non_nullable
as DateTime?,systemId: freezed == systemId ? _self.systemId : systemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameTable].
extension GameTablePatterns on GameTable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameTable value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameTable() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameTable value)  $default,){
final _that = this;
switch (_that) {
case _GameTable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameTable value)?  $default,){
final _that = this;
switch (_that) {
case _GameTable() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String universeLabel,  DateTime? nextSession,  String? systemId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameTable() when $default != null:
return $default(_that.id,_that.title,_that.universeLabel,_that.nextSession,_that.systemId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String universeLabel,  DateTime? nextSession,  String? systemId)  $default,) {final _that = this;
switch (_that) {
case _GameTable():
return $default(_that.id,_that.title,_that.universeLabel,_that.nextSession,_that.systemId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String universeLabel,  DateTime? nextSession,  String? systemId)?  $default,) {final _that = this;
switch (_that) {
case _GameTable() when $default != null:
return $default(_that.id,_that.title,_that.universeLabel,_that.nextSession,_that.systemId);case _:
  return null;

}
}

}

/// @nodoc


class _GameTable implements GameTable {
  const _GameTable({required this.id, required this.title, required this.universeLabel, this.nextSession, this.systemId});
  

@override final  String id;
@override final  String title;
@override final  String universeLabel;
@override final  DateTime? nextSession;
@override final  String? systemId;

/// Create a copy of GameTable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameTableCopyWith<_GameTable> get copyWith => __$GameTableCopyWithImpl<_GameTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameTable&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.universeLabel, universeLabel) || other.universeLabel == universeLabel)&&(identical(other.nextSession, nextSession) || other.nextSession == nextSession)&&(identical(other.systemId, systemId) || other.systemId == systemId));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,universeLabel,nextSession,systemId);

@override
String toString() {
  return 'GameTable(id: $id, title: $title, universeLabel: $universeLabel, nextSession: $nextSession, systemId: $systemId)';
}


}

/// @nodoc
abstract mixin class _$GameTableCopyWith<$Res> implements $GameTableCopyWith<$Res> {
  factory _$GameTableCopyWith(_GameTable value, $Res Function(_GameTable) _then) = __$GameTableCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String universeLabel, DateTime? nextSession, String? systemId
});




}
/// @nodoc
class __$GameTableCopyWithImpl<$Res>
    implements _$GameTableCopyWith<$Res> {
  __$GameTableCopyWithImpl(this._self, this._then);

  final _GameTable _self;
  final $Res Function(_GameTable) _then;

/// Create a copy of GameTable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? universeLabel = null,Object? nextSession = freezed,Object? systemId = freezed,}) {
  return _then(_GameTable(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,universeLabel: null == universeLabel ? _self.universeLabel : universeLabel // ignore: cast_nullable_to_non_nullable
as String,nextSession: freezed == nextSession ? _self.nextSession : nextSession // ignore: cast_nullable_to_non_nullable
as DateTime?,systemId: freezed == systemId ? _self.systemId : systemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
