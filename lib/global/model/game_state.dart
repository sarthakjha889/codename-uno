// This file is "main.dart"
import 'package:flutter/material.dart';
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

extension DayTimeLightingColor on DayTimeType {
  Color get lighting {
    switch (this) {
      case DayTimeType.day:
        return Colors.transparent;
      case DayTimeType.evening:
        return Colors.black.withOpacity(0.8);
      case DayTimeType.night:
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }

  bool get hasLight {
    return this != DayTimeType.night;
  }

  DayTimeType get next {
    switch (this) {
      case DayTimeType.day:
        return DayTimeType.evening;
      case DayTimeType.evening:
        return DayTimeType.night;
      case DayTimeType.night:
        return DayTimeType.day;
      default:
        return DayTimeType.day;
    }
  }
}

@JsonSerializable(createFactory: false)
@freezed
class GameState with _$GameState {
  const factory GameState({
    required GalaxyData galaxy,
    @Default(true) bool isReady,
    SolarSystemData? currentSolarSystem,
    PlanetData? currentPlanet,
  }) = _GameState;

  factory GameState.fromJson(Map<String, Object?> json) =>
      _$GameStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameStateToJson(this);
}
