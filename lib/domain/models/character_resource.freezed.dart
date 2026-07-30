// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharacterResource {

 String get id; String get characterId; String get key; String get label; int get current; int get max; Tone get tone;
/// Create a copy of CharacterResource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterResourceCopyWith<CharacterResource> get copyWith => _$CharacterResourceCopyWithImpl<CharacterResource>(this as CharacterResource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterResource&&(identical(other.id, id) || other.id == id)&&(identical(other.characterId, characterId) || other.characterId == characterId)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.current, current) || other.current == current)&&(identical(other.max, max) || other.max == max)&&(identical(other.tone, tone) || other.tone == tone));
}


@override
int get hashCode => Object.hash(runtimeType,id,characterId,key,label,current,max,tone);

@override
String toString() {
  return 'CharacterResource(id: $id, characterId: $characterId, key: $key, label: $label, current: $current, max: $max, tone: $tone)';
}


}

/// @nodoc
abstract mixin class $CharacterResourceCopyWith<$Res>  {
  factory $CharacterResourceCopyWith(CharacterResource value, $Res Function(CharacterResource) _then) = _$CharacterResourceCopyWithImpl;
@useResult
$Res call({
 String id, String characterId, String key, String label, int current, int max, Tone tone
});




}
/// @nodoc
class _$CharacterResourceCopyWithImpl<$Res>
    implements $CharacterResourceCopyWith<$Res> {
  _$CharacterResourceCopyWithImpl(this._self, this._then);

  final CharacterResource _self;
  final $Res Function(CharacterResource) _then;

/// Create a copy of CharacterResource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? characterId = null,Object? key = null,Object? label = null,Object? current = null,Object? max = null,Object? tone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,characterId: null == characterId ? _self.characterId : characterId // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as Tone,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterResource].
extension CharacterResourcePatterns on CharacterResource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterResource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterResource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterResource value)  $default,){
final _that = this;
switch (_that) {
case _CharacterResource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterResource value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterResource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String characterId,  String key,  String label,  int current,  int max,  Tone tone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterResource() when $default != null:
return $default(_that.id,_that.characterId,_that.key,_that.label,_that.current,_that.max,_that.tone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String characterId,  String key,  String label,  int current,  int max,  Tone tone)  $default,) {final _that = this;
switch (_that) {
case _CharacterResource():
return $default(_that.id,_that.characterId,_that.key,_that.label,_that.current,_that.max,_that.tone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String characterId,  String key,  String label,  int current,  int max,  Tone tone)?  $default,) {final _that = this;
switch (_that) {
case _CharacterResource() when $default != null:
return $default(_that.id,_that.characterId,_that.key,_that.label,_that.current,_that.max,_that.tone);case _:
  return null;

}
}

}

/// @nodoc


class _CharacterResource implements CharacterResource {
  const _CharacterResource({required this.id, required this.characterId, required this.key, required this.label, required this.current, required this.max, this.tone = Tone.neutral});
  

@override final  String id;
@override final  String characterId;
@override final  String key;
@override final  String label;
@override final  int current;
@override final  int max;
@override@JsonKey() final  Tone tone;

/// Create a copy of CharacterResource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterResourceCopyWith<_CharacterResource> get copyWith => __$CharacterResourceCopyWithImpl<_CharacterResource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterResource&&(identical(other.id, id) || other.id == id)&&(identical(other.characterId, characterId) || other.characterId == characterId)&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.current, current) || other.current == current)&&(identical(other.max, max) || other.max == max)&&(identical(other.tone, tone) || other.tone == tone));
}


@override
int get hashCode => Object.hash(runtimeType,id,characterId,key,label,current,max,tone);

@override
String toString() {
  return 'CharacterResource(id: $id, characterId: $characterId, key: $key, label: $label, current: $current, max: $max, tone: $tone)';
}


}

/// @nodoc
abstract mixin class _$CharacterResourceCopyWith<$Res> implements $CharacterResourceCopyWith<$Res> {
  factory _$CharacterResourceCopyWith(_CharacterResource value, $Res Function(_CharacterResource) _then) = __$CharacterResourceCopyWithImpl;
@override @useResult
$Res call({
 String id, String characterId, String key, String label, int current, int max, Tone tone
});




}
/// @nodoc
class __$CharacterResourceCopyWithImpl<$Res>
    implements _$CharacterResourceCopyWith<$Res> {
  __$CharacterResourceCopyWithImpl(this._self, this._then);

  final _CharacterResource _self;
  final $Res Function(_CharacterResource) _then;

/// Create a copy of CharacterResource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? characterId = null,Object? key = null,Object? label = null,Object? current = null,Object? max = null,Object? tone = null,}) {
  return _then(_CharacterResource(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,characterId: null == characterId ? _self.characterId : characterId // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as Tone,
  ));
}


}

// dart format on
