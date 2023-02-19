// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'star_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StarData _$StarDataFromJson(Map<String, dynamic> json) {
  return _StarData.fromJson(json);
}

/// @nodoc
mixin _$StarData {
  @Vector2Serialiser()
  Vector2 get position => throw _privateConstructorUsedError;
  @ColorSerialiser()
  StarBase get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StarDataCopyWith<StarData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarDataCopyWith<$Res> {
  factory $StarDataCopyWith(StarData value, $Res Function(StarData) then) =
      _$StarDataCopyWithImpl<$Res, StarData>;
  @useResult
  $Res call(
      {@Vector2Serialiser() Vector2 position,
      @ColorSerialiser() StarBase type});
}

/// @nodoc
class _$StarDataCopyWithImpl<$Res, $Val extends StarData>
    implements $StarDataCopyWith<$Res> {
  _$StarDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StarBase,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StarDataCopyWith<$Res> implements $StarDataCopyWith<$Res> {
  factory _$$_StarDataCopyWith(
          _$_StarData value, $Res Function(_$_StarData) then) =
      __$$_StarDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Vector2Serialiser() Vector2 position,
      @ColorSerialiser() StarBase type});
}

/// @nodoc
class __$$_StarDataCopyWithImpl<$Res>
    extends _$StarDataCopyWithImpl<$Res, _$_StarData>
    implements _$$_StarDataCopyWith<$Res> {
  __$$_StarDataCopyWithImpl(
      _$_StarData _value, $Res Function(_$_StarData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? type = null,
  }) {
    return _then(_$_StarData(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Vector2,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StarBase,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StarData extends _StarData {
  const _$_StarData(
      {@Vector2Serialiser() required this.position,
      @ColorSerialiser() required this.type})
      : super._();

  factory _$_StarData.fromJson(Map<String, dynamic> json) =>
      _$$_StarDataFromJson(json);

  @override
  @Vector2Serialiser()
  final Vector2 position;
  @override
  @ColorSerialiser()
  final StarBase type;

  @override
  String toString() {
    return 'StarData(position: $position, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StarData &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StarDataCopyWith<_$_StarData> get copyWith =>
      __$$_StarDataCopyWithImpl<_$_StarData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StarDataToJson(
      this,
    );
  }
}

abstract class _StarData extends StarData {
  const factory _StarData(
      {@Vector2Serialiser() required final Vector2 position,
      @ColorSerialiser() required final StarBase type}) = _$_StarData;
  const _StarData._() : super._();

  factory _StarData.fromJson(Map<String, dynamic> json) = _$_StarData.fromJson;

  @override
  @Vector2Serialiser()
  Vector2 get position;
  @override
  @ColorSerialiser()
  StarBase get type;
  @override
  @JsonKey(ignore: true)
  _$$_StarDataCopyWith<_$_StarData> get copyWith =>
      throw _privateConstructorUsedError;
}
