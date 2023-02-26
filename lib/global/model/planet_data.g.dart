// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PlanetDataToJson(PlanetData instance) =>
    <String, dynamic>{
      'planetSize': const Vector2Serialiser().toJson(instance.planetSize),
      'starPosition': const Vector2Serialiser().toJson(instance.starPosition),
      'name': instance.name,
      'spritesheetPath': instance.spritesheetPath,
      'starDistance': instance.starDistance,
      'revolutionSpeed': instance.revolutionSpeed,
      'type': _$PlanetBaseEnumMap[instance.type]!,
      'dayDurationInSeconds': instance.dayDurationInSeconds,
      'solidVariant': _$SolidPlanetVariantEnumMap[instance.solidVariant],
      'gasVariant': _$GasPlanetVariantEnumMap[instance.gasVariant],
    };

const _$PlanetBaseEnumMap = {
  PlanetBase.solid: 'solid',
  PlanetBase.gaseous: 'gaseous',
};

const _$SolidPlanetVariantEnumMap = {
  SolidPlanetVariant.airless: 'airless',
  SolidPlanetVariant.aquamarine: 'aquamarine',
  SolidPlanetVariant.arid: 'arid',
  SolidPlanetVariant.barren: 'barren',
  SolidPlanetVariant.cloudy: 'cloudy',
  SolidPlanetVariant.cratered: 'cratered',
  SolidPlanetVariant.dry: 'dry',
  SolidPlanetVariant.frozen: 'frozen',
  SolidPlanetVariant.glacial: 'glacial',
  SolidPlanetVariant.icy: 'icy',
  SolidPlanetVariant.lunar: 'lunar',
  SolidPlanetVariant.lush: 'lush',
  SolidPlanetVariant.magma: 'magma',
  SolidPlanetVariant.muddy: 'muddy',
  SolidPlanetVariant.oasis: 'oasis',
  SolidPlanetVariant.ocean: 'ocean',
  SolidPlanetVariant.rocky: 'rocky',
  SolidPlanetVariant.snowy: 'snowy',
  SolidPlanetVariant.terrestrial: 'terrestrial',
  SolidPlanetVariant.tropical: 'tropical',
};

const _$GasPlanetVariantEnumMap = {
  GasPlanetVariant.blue: 'blue',
  GasPlanetVariant.green: 'green',
  GasPlanetVariant.orange: 'orange',
  GasPlanetVariant.red: 'red',
  GasPlanetVariant.yellow: 'yellow',
};

_$_PlanetData _$$_PlanetDataFromJson(Map<String, dynamic> json) =>
    _$_PlanetData(
      planetSize: const Vector2Serialiser()
          .fromJson(json['planetSize'] as Map<String, double>),
      starPosition: const Vector2Serialiser()
          .fromJson(json['starPosition'] as Map<String, double>),
      name: json['name'] as String,
      spritesheetPath: json['spritesheetPath'] as String,
      starDistance: (json['starDistance'] as num).toDouble(),
      revolutionSpeed: (json['revolutionSpeed'] as num).toDouble(),
      type: $enumDecode(_$PlanetBaseEnumMap, json['type']),
      dayDurationInSeconds: json['dayDurationInSeconds'] as int? ?? 30,
      solidVariant: $enumDecodeNullable(
          _$SolidPlanetVariantEnumMap, json['solidVariant']),
      gasVariant:
          $enumDecodeNullable(_$GasPlanetVariantEnumMap, json['gasVariant']),
    );

Map<String, dynamic> _$$_PlanetDataToJson(_$_PlanetData instance) =>
    <String, dynamic>{
      'planetSize': const Vector2Serialiser().toJson(instance.planetSize),
      'starPosition': const Vector2Serialiser().toJson(instance.starPosition),
      'name': instance.name,
      'spritesheetPath': instance.spritesheetPath,
      'starDistance': instance.starDistance,
      'revolutionSpeed': instance.revolutionSpeed,
      'type': _$PlanetBaseEnumMap[instance.type]!,
      'dayDurationInSeconds': instance.dayDurationInSeconds,
      'solidVariant': _$SolidPlanetVariantEnumMap[instance.solidVariant],
      'gasVariant': _$GasPlanetVariantEnumMap[instance.gasVariant],
    };
