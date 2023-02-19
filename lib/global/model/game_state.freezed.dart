// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  bool get isReady => throw _privateConstructorUsedError;
  List<SolarSystemData> get solarSystems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({bool isReady, List<SolarSystemData> solarSystems});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? solarSystems = null,
  }) {
    return _then(_value.copyWith(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      solarSystems: null == solarSystems
          ? _value.solarSystems
          : solarSystems // ignore: cast_nullable_to_non_nullable
              as List<SolarSystemData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isReady, List<SolarSystemData> solarSystems});
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$_GameState>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isReady = null,
    Object? solarSystems = null,
  }) {
    return _then(_$_GameState(
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      solarSystems: null == solarSystems
          ? _value._solarSystems
          : solarSystems // ignore: cast_nullable_to_non_nullable
              as List<SolarSystemData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameState implements _GameState {
  const _$_GameState(
      {this.isReady = true,
      final List<SolarSystemData> solarSystems = const []})
      : _solarSystems = solarSystems;

  factory _$_GameState.fromJson(Map<String, dynamic> json) =>
      _$$_GameStateFromJson(json);

  @override
  @JsonKey()
  final bool isReady;
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
    return 'GameState(isReady: $isReady, solarSystems: $solarSystems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            const DeepCollectionEquality()
                .equals(other._solarSystems, _solarSystems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isReady, const DeepCollectionEquality().hash(_solarSystems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameStateToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final bool isReady,
      final List<SolarSystemData> solarSystems}) = _$_GameState;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$_GameState.fromJson;

  @override
  bool get isReady;
  @override
  List<SolarSystemData> get solarSystems;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
