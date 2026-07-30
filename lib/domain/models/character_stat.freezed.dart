// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharacterStat {

 String get id; String get characterId; StatKind get kind; String get key; String get label; int get value; String? get base; int get sortOrder;
/// Create a copy of CharacterStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterStatCopyWith<CharacterStat> get copyWith => _$CharacterStatCopyWithImpl<CharacterStat>(this as CharacterStat, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterStat&&(identical(other.id, id) || other.id == id)&&(identical(other.characterId, characterId) || other.characterId == characterId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.base, base) || other.base == base)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,characterId,kind,key,label,value,base,sortOrder);

@override
String toString() {
  return 'CharacterStat(id: $id, characterId: $characterId, kind: $kind, key: $key, label: $label, value: $value, base: $base, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $CharacterStatCopyWith<$Res>  {
  factory $CharacterStatCopyWith(CharacterStat value, $Res Function(CharacterStat) _then) = _$CharacterStatCopyWithImpl;
@useResult
$Res call({
 String id, String characterId, StatKind kind, String key, String label, int value, String? base, int sortOrder
});




}
/// @nodoc
class _$CharacterStatCopyWithImpl<$Res>
    implements $CharacterStatCopyWith<$Res> {
  _$CharacterStatCopyWithImpl(this._self, this._then);

  final CharacterStat _self;
  final $Res Function(CharacterStat) _then;

/// Create a copy of CharacterStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? characterId = null,Object? kind = null,Object? key = null,Object? label = null,Object? value = null,Object? base = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,characterId: null == characterId ? _self.characterId : characterId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as StatKind,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,base: freezed == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterStat].
extension CharacterStatPatterns on CharacterStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterStat value)  $default,){
final _that = this;
switch (_that) {
case _CharacterStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterStat value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String characterId,  StatKind kind,  String key,  String label,  int value,  String? base,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterStat() when $default != null:
return $default(_that.id,_that.characterId,_that.kind,_that.key,_that.label,_that.value,_that.base,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String characterId,  StatKind kind,  String key,  String label,  int value,  String? base,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CharacterStat():
return $default(_that.id,_that.characterId,_that.kind,_that.key,_that.label,_that.value,_that.base,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String characterId,  StatKind kind,  String key,  String label,  int value,  String? base,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CharacterStat() when $default != null:
return $default(_that.id,_that.characterId,_that.kind,_that.key,_that.label,_that.value,_that.base,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _CharacterStat implements CharacterStat {
  const _CharacterStat({required this.id, required this.characterId, required this.kind, required this.key, required this.label, required this.value, this.base, this.sortOrder = 0});
  

@override final  String id;
@override final  String characterId;
@override final  StatKind kind;
@override final  String key;
@override final  String label;
@override final  int value;
@override final  String? base;
@override@JsonKey() final  int sortOrder;

/// Create a copy of CharacterStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterStatCopyWith<_CharacterStat> get copyWith => __$CharacterStatCopyWithImpl<_CharacterStat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterStat&&(identical(other.id, id) || other.id == id)&&(identical(other.characterId, characterId) || other.characterId == characterId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.base, base) || other.base == base)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,characterId,kind,key,label,value,base,sortOrder);

@override
String toString() {
  return 'CharacterStat(id: $id, characterId: $characterId, kind: $kind, key: $key, label: $label, value: $value, base: $base, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CharacterStatCopyWith<$Res> implements $CharacterStatCopyWith<$Res> {
  factory _$CharacterStatCopyWith(_CharacterStat value, $Res Function(_CharacterStat) _then) = __$CharacterStatCopyWithImpl;
@override @useResult
$Res call({
 String id, String characterId, StatKind kind, String key, String label, int value, String? base, int sortOrder
});




}
/// @nodoc
class __$CharacterStatCopyWithImpl<$Res>
    implements _$CharacterStatCopyWith<$Res> {
  __$CharacterStatCopyWithImpl(this._self, this._then);

  final _CharacterStat _self;
  final $Res Function(_CharacterStat) _then;

/// Create a copy of CharacterStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? characterId = null,Object? kind = null,Object? key = null,Object? label = null,Object? value = null,Object? base = freezed,Object? sortOrder = null,}) {
  return _then(_CharacterStat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,characterId: null == characterId ? _self.characterId : characterId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as StatKind,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,base: freezed == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
