// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar_system_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SolarSystemData _$SolarSystemDataFromJson(Map<String, dynamic> json) {
  return _SolarSystemData.fromJson(json);
}

/// @nodoc
mixin _$SolarSystemData {
  String get name => throw _privateConstructorUsedError;
  StarData get star => throw _privateConstructorUsedError;
  List<PlanetData> get planets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SolarSystemDataCopyWith<SolarSystemData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarSystemDataCopyWith<$Res> {
  factory $SolarSystemDataCopyWith(
          SolarSystemData value, $Res Function(SolarSystemData) then) =
      _$SolarSystemDataCopyWithImpl<$Res, SolarSystemData>;
  @useResult
  $Res call({String name, StarData star, List<PlanetData> planets});

  $StarDataCopyWith<$Res> get star;
}

/// @nodoc
class _$SolarSystemDataCopyWithImpl<$Res, $Val extends SolarSystemData>
    implements $SolarSystemDataCopyWith<$Res> {
  _$SolarSystemDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? star = null,
    Object? planets = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as StarData,
      planets: null == planets
          ? _value.planets
          : planets // ignore: cast_nullable_to_non_nullable
              as List<PlanetData>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StarDataCopyWith<$Res> get star {
    return $StarDataCopyWith<$Res>(_value.star, (value) {
      return _then(_value.copyWith(star: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SolarSystemDataCopyWith<$Res>
    implements $SolarSystemDataCopyWith<$Res> {
  factory _$$_SolarSystemDataCopyWith(
          _$_SolarSystemData value, $Res Function(_$_SolarSystemData) then) =
      __$$_SolarSystemDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, StarData star, List<PlanetData> planets});

  @override
  $StarDataCopyWith<$Res> get star;
}

/// @nodoc
class __$$_SolarSystemDataCopyWithImpl<$Res>
    extends _$SolarSystemDataCopyWithImpl<$Res, _$_SolarSystemData>
    implements _$$_SolarSystemDataCopyWith<$Res> {
  __$$_SolarSystemDataCopyWithImpl(
      _$_SolarSystemData _value, $Res Function(_$_SolarSystemData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? star = null,
    Object? planets = null,
  }) {
    return _then(_$_SolarSystemData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as StarData,
      planets: null == planets
          ? _value._planets
          : planets // ignore: cast_nullable_to_non_nullable
              as List<PlanetData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SolarSystemData extends _SolarSystemData {
  const _$_SolarSystemData(
      {required this.name,
      required this.star,
      required final List<PlanetData> planets})
      : _planets = planets,
        super._();

  factory _$_SolarSystemData.fromJson(Map<String, dynamic> json) =>
      _$$_SolarSystemDataFromJson(json);

  @override
  final String name;
  @override
  final StarData star;
  final List<PlanetData> _planets;
  @override
  List<PlanetData> get planets {
    if (_planets is EqualUnmodifiableListView) return _planets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_planets);
  }

  @override
  String toString() {
    return 'SolarSystemData(name: $name, star: $star, planets: $planets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SolarSystemData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.star, star) || other.star == star) &&
            const DeepCollectionEquality().equals(other._planets, _planets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, star, const DeepCollectionEquality().hash(_planets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SolarSystemDataCopyWith<_$_SolarSystemData> get copyWith =>
      __$$_SolarSystemDataCopyWithImpl<_$_SolarSystemData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SolarSystemDataToJson(
      this,
    );
  }
}

abstract class _SolarSystemData extends SolarSystemData {
  const factory _SolarSystemData(
      {required final String name,
      required final StarData star,
      required final List<PlanetData> planets}) = _$_SolarSystemData;
  const _SolarSystemData._() : super._();

  factory _SolarSystemData.fromJson(Map<String, dynamic> json) =
      _$_SolarSystemData.fromJson;

  @override
  String get name;
  @override
  StarData get star;
  @override
  List<PlanetData> get planets;
  @override
  @JsonKey(ignore: true)
  _$$_SolarSystemDataCopyWith<_$_SolarSystemData> get copyWith =>
      throw _privateConstructorUsedError;
}
