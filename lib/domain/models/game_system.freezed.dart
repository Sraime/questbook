// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_system.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameSystem {

 String get id; String get name; List<String> get occupationSuggestions;
/// Create a copy of GameSystem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSystemCopyWith<GameSystem> get copyWith => _$GameSystemCopyWithImpl<GameSystem>(this as GameSystem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSystem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.occupationSuggestions, occupationSuggestions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(occupationSuggestions));

@override
String toString() {
  return 'GameSystem(id: $id, name: $name, occupationSuggestions: $occupationSuggestions)';
}


}

/// @nodoc
abstract mixin class $GameSystemCopyWith<$Res>  {
  factory $GameSystemCopyWith(GameSystem value, $Res Function(GameSystem) _then) = _$GameSystemCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> occupationSuggestions
});




}
/// @nodoc
class _$GameSystemCopyWithImpl<$Res>
    implements $GameSystemCopyWith<$Res> {
  _$GameSystemCopyWithImpl(this._self, this._then);

  final GameSystem _self;
  final $Res Function(GameSystem) _then;

/// Create a copy of GameSystem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? occupationSuggestions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,occupationSuggestions: null == occupationSuggestions ? _self.occupationSuggestions : occupationSuggestions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSystem].
extension GameSystemPatterns on GameSystem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSystem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSystem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSystem value)  $default,){
final _that = this;
switch (_that) {
case _GameSystem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSystem value)?  $default,){
final _that = this;
switch (_that) {
case _GameSystem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> occupationSuggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSystem() when $default != null:
return $default(_that.id,_that.name,_that.occupationSuggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> occupationSuggestions)  $default,) {final _that = this;
switch (_that) {
case _GameSystem():
return $default(_that.id,_that.name,_that.occupationSuggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> occupationSuggestions)?  $default,) {final _that = this;
switch (_that) {
case _GameSystem() when $default != null:
return $default(_that.id,_that.name,_that.occupationSuggestions);case _:
  return null;

}
}

}

/// @nodoc


class _GameSystem implements GameSystem {
  const _GameSystem({required this.id, required this.name, final  List<String> occupationSuggestions = const []}): _occupationSuggestions = occupationSuggestions;
  

@override final  String id;
@override final  String name;
 final  List<String> _occupationSuggestions;
@override@JsonKey() List<String> get occupationSuggestions {
  if (_occupationSuggestions is EqualUnmodifiableListView) return _occupationSuggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occupationSuggestions);
}


/// Create a copy of GameSystem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSystemCopyWith<_GameSystem> get copyWith => __$GameSystemCopyWithImpl<_GameSystem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSystem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._occupationSuggestions, _occupationSuggestions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_occupationSuggestions));

@override
String toString() {
  return 'GameSystem(id: $id, name: $name, occupationSuggestions: $occupationSuggestions)';
}


}

/// @nodoc
abstract mixin class _$GameSystemCopyWith<$Res> implements $GameSystemCopyWith<$Res> {
  factory _$GameSystemCopyWith(_GameSystem value, $Res Function(_GameSystem) _then) = __$GameSystemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> occupationSuggestions
});




}
/// @nodoc
class __$GameSystemCopyWithImpl<$Res>
    implements _$GameSystemCopyWith<$Res> {
  __$GameSystemCopyWithImpl(this._self, this._then);

  final _GameSystem _self;
  final $Res Function(_GameSystem) _then;

/// Create a copy of GameSystem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? occupationSuggestions = null,}) {
  return _then(_GameSystem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,occupationSuggestions: null == occupationSuggestions ? _self._occupationSuggestions : occupationSuggestions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
