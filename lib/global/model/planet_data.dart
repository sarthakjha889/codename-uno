// This file is "main.dart"
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/serialisers/vector2_serialiser.dart';

part 'planet_data.freezed.dart';
part 'planet_data.g.dart';

enum SolidPlanetVariant {
  airless(fogColor: Colors.grey),
  aquamarine(fogColor: Colors.blue),
  arid(fogColor: Colors.grey),
  barren(fogColor: Colors.brown),
  cloudy(fogColor: Colors.blueGrey),
  cratered(fogColor: Colors.blueGrey),
  dry(fogColor: Colors.brown),
  frozen(fogColor: Colors.lightBlue),
  glacial(fogColor: Colors.lightBlue),
  icy(fogColor: Colors.lightBlue),
  lunar(fogColor: Colors.grey),
  lush(fogColor: Colors.green),
  magma(fogColor: Colors.orange),
  muddy(fogColor: Colors.brown),
  oasis(fogColor: Colors.green),
  ocean(fogColor: Colors.blue),
  rocky(fogColor: Colors.grey),
  snowy(fogColor: Colors.blue),
  terrestrial(fogColor: Colors.green),
  tropical(fogColor: Colors.green);

  final Color fogColor;
  const SolidPlanetVariant({
    required this.fogColor,
  });
}

enum GasPlanetVariant {
  blue(fogColor: Colors.blue),
  green(fogColor: Colors.green),
  orange(fogColor: Colors.orange),
  red(fogColor: Colors.red),
  yellow(fogColor: Colors.yellow);

  final Color fogColor;
  const GasPlanetVariant({
    required this.fogColor,
  });
}

enum PlanetBase {
  solid,
  gaseous,
}

@JsonSerializable(createFactory: false)
@freezed
class PlanetData with _$PlanetData {
  const PlanetData._();
  @Assert('solidVariant != null || gasVariant != null')
  const factory PlanetData({
    @Vector2Serialiser() required Vector2 planetSize,
    @Vector2Serialiser() required Vector2 starPosition,
    required String name,
    required String spritesheetPath,
    required double starDistance,
    required double revolutionSpeed,
    required PlanetBase type,
    @Default(30) int dayDurationInSeconds,
    SolidPlanetVariant? solidVariant,
    GasPlanetVariant? gasVariant,
  }) = _PlanetData;

  factory PlanetData.fromJson(Map<String, Object?> json) =>
      _$PlanetDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlanetDataToJson(this);
}
