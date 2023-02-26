// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlanetData _$PlanetDataFromJson(Map<String, dynamic> json) {
  return _PlanetData.fromJson(json);
}

/// @nodoc
mixin _$PlanetData {
  @Vector2Serialiser()
  Vector2 get planetSize => throw _privateConstructorUsedError;
  @Vector2Serialiser()
  Vector2 get starPosition => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get spritesheetPath => throw _privateConstructorUsedError;
  double get starDistance => throw _privateConstructorUsedError;
  double get revolutionSpeed => throw _privateConstructorUsedError;
  PlanetBase get type => throw _privateConstructorUsedError;
  int get dayDurationInSeconds => throw _privateConstructorUsedError;
  SolidPlanetVariant? get solidVariant => throw _privateConstructorUsedError;
  GasPlanetVariant? get gasVariant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlanetDataCopyWith<PlanetData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanetDataCopyWith<$Res> {
  factory $PlanetDataCopyWith(
          PlanetData value, $Res Function(PlanetData) then) =
      _$PlanetDataCopyWithImpl<$Res, PlanetData>;
  @useResult
  $Res call(
      {@Vector2Serialiser() Vector2 planetSize,
      @Vector2Serialiser() Vector2 starPosition,
      String name,
      String spritesheetPath,
      double starDistance,
      double revolutionSpeed,
      PlanetBase type,
      int dayDurationInSeconds,
      SolidPlanetVariant? solidVariant,
      GasPlanetVariant? gasVariant});
}

/// @nodoc
class _$PlanetDataCopyWithImpl<$Res, $Val extends PlanetData>
    implements $PlanetDataCopyWith<$Res> {
  _$PlanetDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planetSize = null,
    Object? starPosition = null,
    Object? name = null,
    Object? spritesheetPath = null,
    Object? starDistance = null,
    Object? revolutionSpeed = null,
    Object? type = null,
    Object? dayDurationInSeconds = null,
    Object? solidVariant = freezed,
    Object? gasVariant = freezed,
  }) {
    return _then(_value.copyWith(
      planetSize: null == planetSize
          ? _value.planetSize
          : planetSize // ignore: cast_nullable_to_non_nullable
              as Vector2,
      starPosition: null == starPosition
          ? _value.starPosition
          : starPosition // ignore: cast_nullable_to_non_nullable
              as Vector2,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spritesheetPath: null == spritesheetPath
          ? _value.spritesheetPath
          : spritesheetPath // ignore: cast_nullable_to_non_nullable
              as String,
      starDistance: null == starDistance
          ? _value.starDistance
          : starDistance // ignore: cast_nullable_to_non_nullable
              as double,
      revolutionSpeed: null == revolutionSpeed
          ? _value.revolutionSpeed
          : revolutionSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlanetBase,
      dayDurationInSeconds: null == dayDurationInSeconds
          ? _value.dayDurationInSeconds
          : dayDurationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      solidVariant: freezed == solidVariant
          ? _value.solidVariant
          : solidVariant // ignore: cast_nullable_to_non_nullable
              as SolidPlanetVariant?,
      gasVariant: freezed == gasVariant
          ? _value.gasVariant
          : gasVariant // ignore: cast_nullable_to_non_nullable
              as GasPlanetVariant?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlanetDataCopyWith<$Res>
    implements $PlanetDataCopyWith<$Res> {
  factory _$$_PlanetDataCopyWith(
          _$_PlanetData value, $Res Function(_$_PlanetData) then) =
      __$$_PlanetDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Vector2Serialiser() Vector2 planetSize,
      @Vector2Serialiser() Vector2 starPosition,
      String name,
      String spritesheetPath,
      double starDistance,
      double revolutionSpeed,
      PlanetBase type,
      int dayDurationInSeconds,
      SolidPlanetVariant? solidVariant,
      GasPlanetVariant? gasVariant});
}

/// @nodoc
class __$$_PlanetDataCopyWithImpl<$Res>
    extends _$PlanetDataCopyWithImpl<$Res, _$_PlanetData>
    implements _$$_PlanetDataCopyWith<$Res> {
  __$$_PlanetDataCopyWithImpl(
      _$_PlanetData _value, $Res Function(_$_PlanetData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planetSize = null,
    Object? starPosition = null,
    Object? name = null,
    Object? spritesheetPath = null,
    Object? starDistance = null,
    Object? revolutionSpeed = null,
    Object? type = null,
    Object? dayDurationInSeconds = null,
    Object? solidVariant = freezed,
    Object? gasVariant = freezed,
  }) {
    return _then(_$_PlanetData(
      planetSize: null == planetSize
          ? _value.planetSize
          : planetSize // ignore: cast_nullable_to_non_nullable
              as Vector2,
      starPosition: null == starPosition
          ? _value.starPosition
          : starPosition // ignore: cast_nullable_to_non_nullable
              as Vector2,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spritesheetPath: null == spritesheetPath
          ? _value.spritesheetPath
          : spritesheetPath // ignore: cast_nullable_to_non_nullable
              as String,
      starDistance: null == starDistance
          ? _value.starDistance
          : starDistance // ignore: cast_nullable_to_non_nullable
              as double,
      revolutionSpeed: null == revolutionSpeed
          ? _value.revolutionSpeed
          : revolutionSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlanetBase,
      dayDurationInSeconds: null == dayDurationInSeconds
          ? _value.dayDurationInSeconds
          : dayDurationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      solidVariant: freezed == solidVariant
          ? _value.solidVariant
          : solidVariant // ignore: cast_nullable_to_non_nullable
              as SolidPlanetVariant?,
      gasVariant: freezed == gasVariant
          ? _value.gasVariant
          : gasVariant // ignore: cast_nullable_to_non_nullable
              as GasPlanetVariant?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlanetData extends _PlanetData {
  const _$_PlanetData(
      {@Vector2Serialiser() required this.planetSize,
      @Vector2Serialiser() required this.starPosition,
      required this.name,
      required this.spritesheetPath,
      required this.starDistance,
      required this.revolutionSpeed,
      required this.type,
      this.dayDurationInSeconds = 30,
      this.solidVariant,
      this.gasVariant})
      : assert(solidVariant != null || gasVariant != null),
        super._();

  factory _$_PlanetData.fromJson(Map<String, dynamic> json) =>
      _$$_PlanetDataFromJson(json);

  @override
  @Vector2Serialiser()
  final Vector2 planetSize;
  @override
  @Vector2Serialiser()
  final Vector2 starPosition;
  @override
  final String name;
  @override
  final String spritesheetPath;
  @override
  final double starDistance;
  @override
  final double revolutionSpeed;
  @override
  final PlanetBase type;
  @override
  @JsonKey()
  final int dayDurationInSeconds;
  @override
  final SolidPlanetVariant? solidVariant;
  @override
  final GasPlanetVariant? gasVariant;

  @override
  String toString() {
    return 'PlanetData(planetSize: $planetSize, starPosition: $starPosition, name: $name, spritesheetPath: $spritesheetPath, starDistance: $starDistance, revolutionSpeed: $revolutionSpeed, type: $type, dayDurationInSeconds: $dayDurationInSeconds, solidVariant: $solidVariant, gasVariant: $gasVariant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlanetData &&
            (identical(other.planetSize, planetSize) ||
                other.planetSize == planetSize) &&
            (identical(other.starPosition, starPosition) ||
                other.starPosition == starPosition) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.spritesheetPath, spritesheetPath) ||
                other.spritesheetPath == spritesheetPath) &&
            (identical(other.starDistance, starDistance) ||
                other.starDistance == starDistance) &&
            (identical(other.revolutionSpeed, revolutionSpeed) ||
                other.revolutionSpeed == revolutionSpeed) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dayDurationInSeconds, dayDurationInSeconds) ||
                other.dayDurationInSeconds == dayDurationInSeconds) &&
            (identical(other.solidVariant, solidVariant) ||
                other.solidVariant == solidVariant) &&
            (identical(other.gasVariant, gasVariant) ||
                other.gasVariant == gasVariant));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      planetSize,
      starPosition,
      name,
      spritesheetPath,
      starDistance,
      revolutionSpeed,
      type,
      dayDurationInSeconds,
      solidVariant,
      gasVariant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlanetDataCopyWith<_$_PlanetData> get copyWith =>
      __$$_PlanetDataCopyWithImpl<_$_PlanetData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlanetDataToJson(
      this,
    );
  }
}

abstract class _PlanetData extends PlanetData {
  const factory _PlanetData(
      {@Vector2Serialiser() required final Vector2 planetSize,
      @Vector2Serialiser() required final Vector2 starPosition,
      required final String name,
      required final String spritesheetPath,
      required final double starDistance,
      required final double revolutionSpeed,
      required final PlanetBase type,
      final int dayDurationInSeconds,
      final SolidPlanetVariant? solidVariant,
      final GasPlanetVariant? gasVariant}) = _$_PlanetData;
  const _PlanetData._() : super._();

  factory _PlanetData.fromJson(Map<String, dynamic> json) =
      _$_PlanetData.fromJson;

  @override
  @Vector2Serialiser()
  Vector2 get planetSize;
  @override
  @Vector2Serialiser()
  Vector2 get starPosition;
  @override
  String get name;
  @override
  String get spritesheetPath;
  @override
  double get starDistance;
  @override
  double get revolutionSpeed;
  @override
  PlanetBase get type;
  @override
  int get dayDurationInSeconds;
  @override
  SolidPlanetVariant? get solidVariant;
  @override
  GasPlanetVariant? get gasVariant;
  @override
  @JsonKey(ignore: true)
  _$$_PlanetDataCopyWith<_$_PlanetData> get copyWith =>
      throw _privateConstructorUsedError;
}
