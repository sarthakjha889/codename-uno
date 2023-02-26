// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/model/galaxy_data.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/solar_system_data.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum DayTimeType {
  day,
  evening,
  night,
}

enum WeatherType {
  sunny,
  snowy,
  rainy,
}

@JsonSerializable(createFactory: false)
@freezed
class GameState with _$GameState {
  const factory GameState({
    required GalaxyData galaxy,
    @Default(true) bool isReady,
    @Default(DayTimeType.day) DayTimeType dayTimeType,
    @Default(WeatherType.sunny) WeatherType weatherType,
    SolarSystemData? currentSolarSystem,
    PlanetData? currentPlanet,
  }) = _GameState;

  factory GameState.fromJson(Map<String, Object?> json) =>
      _$GameStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameStateToJson(this);
}
