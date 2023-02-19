// This file is "main.dart"
import 'package:bonfire/bonfire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/vector2_serialiser.dart';

part 'planet_data.freezed.dart';
part 'planet_data.g.dart';

enum SolidVariant {
  airless,
  aquamarine,
  arid,
  barren,
  cloudy,
  cratered,
  dry,
  frozen,
  glacial,
  icy,
  lunar,
  lush,
  magma,
  muddy,
  oasis,
  ocean,
  rocky,
  snowy,
  terrestrial,
  tropical,
}

enum GasVariant {
  blue,
  green,
  orange,
  red,
  yellow,
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
    @Vector2Serialiser() required Vector2 panetSize,
    @Vector2Serialiser() required Vector2 starPosition,
    required String name,
    required String spritesheetPath,
    required double starDistance,
    required double revolutionSpeed,
    required PlanetBase type,
    SolidVariant? solidVariant,
    GasVariant? gasVariant,
  }) = _PlanetData;

  factory PlanetData.fromJson(Map<String, Object?> json) =>
      _$PlanetDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlanetDataToJson(this);
}
