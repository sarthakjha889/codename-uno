// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'galaxy_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GalaxyData _$GalaxyDataFromJson(Map<String, dynamic> json) {
  return _GalaxyData.fromJson(json);
}

/// @nodoc
mixin _$GalaxyData {
  List<SolarSystemData> get solarSystems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GalaxyDataCopyWith<GalaxyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalaxyDataCopyWith<$Res> {
  factory $GalaxyDataCopyWith(
          GalaxyData value, $Res Function(GalaxyData) then) =
      _$GalaxyDataCopyWithImpl<$Res, GalaxyData>;
  @useResult
  $Res call({List<SolarSystemData> solarSystems});
}

/// @nodoc
class _$GalaxyDataCopyWithImpl<$Res, $Val extends GalaxyData>
    implements $GalaxyDataCopyWith<$Res> {
  _$GalaxyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solarSystems = null,
  }) {
    return _then(_value.copyWith(
      solarSystems: null == solarSystems
          ? _value.solarSystems
          : solarSystems // ignore: cast_nullable_to_non_nullable
              as List<SolarSystemData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GalaxyDataCopyWith<$Res>
    implements $GalaxyDataCopyWith<$Res> {
  factory _$$_GalaxyDataCopyWith(
          _$_GalaxyData value, $Res Function(_$_GalaxyData) then) =
      __$$_GalaxyDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SolarSystemData> solarSystems});
}

/// @nodoc
class __$$_GalaxyDataCopyWithImpl<$Res>
    extends _$GalaxyDataCopyWithImpl<$Res, _$_GalaxyData>
    implements _$$_GalaxyDataCopyWith<$Res> {
  __$$_GalaxyDataCopyWithImpl(
      _$_GalaxyData _value, $Res Function(_$_GalaxyData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solarSystems = null,
  }) {
    return _then(_$_GalaxyData(
      solarSystems: null == solarSystems
          ? _value._solarSystems
          : solarSystems // ignore: cast_nullable_to_non_nullable
              as List<SolarSystemData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GalaxyData extends _GalaxyData {
  const _$_GalaxyData({final List<SolarSystemData> solarSystems = const []})
      : _solarSystems = solarSystems,
        super._();

  factory _$_GalaxyData.fromJson(Map<String, dynamic> json) =>
      _$$_GalaxyDataFromJson(json);

  final List<SolarSystemData> _solarSystems;
  @override
  @JsonKey()
  List<SolarSystemData> get solarSystems {
    if (_solarSystems is EqualUnmodifiableListView) return _solarSystems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_solarSystems);
  }

  @override
  String toString() {
    return 'GalaxyData(solarSystems: $solarSystems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GalaxyData &&
            const DeepCollectionEquality()
                .equals(other._solarSystems, _solarSystems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_solarSystems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GalaxyDataCopyWith<_$_GalaxyData> get copyWith =>
      __$$_GalaxyDataCopyWithImpl<_$_GalaxyData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GalaxyDataToJson(
      this,
    );
  }
}

abstract class _GalaxyData extends GalaxyData {
  const factory _GalaxyData({final List<SolarSystemData> solarSystems}) =
      _$_GalaxyData;
  const _GalaxyData._() : super._();

  factory _GalaxyData.fromJson(Map<String, dynamic> json) =
      _$_GalaxyData.fromJson;

  @override
  List<SolarSystemData> get solarSystems;
  @override
  @JsonKey(ignore: true)
  _$$_GalaxyDataCopyWith<_$_GalaxyData> get copyWith =>
      throw _privateConstructorUsedError;
}
