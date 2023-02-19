// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PlanetDataToJson(PlanetData instance) =>
    <String, dynamic>{
      'panetSize': const Vector2Serialiser().toJson(instance.panetSize),
      'starPosition': const Vector2Serialiser().toJson(instance.starPosition),
      'name': instance.name,
      'spritesheetPath': instance.spritesheetPath,
      'starDistance': instance.starDistance,
      'revolutionSpeed': instance.revolutionSpeed,
      'type': _$PlanetBaseEnumMap[instance.type]!,
      'solidVariant': _$SolidVariantEnumMap[instance.solidVariant],
      'gasVariant': _$GasVariantEnumMap[instance.gasVariant],
    };

const _$PlanetBaseEnumMap = {
  PlanetBase.solid: 'solid',
  PlanetBase.gaseous: 'gaseous',
};

const _$SolidVariantEnumMap = {
  SolidVariant.airless: 'airless',
  SolidVariant.aquamarine: 'aquamarine',
  SolidVariant.arid: 'arid',
  SolidVariant.barren: 'barren',
  SolidVariant.cloudy: 'cloudy',
  SolidVariant.cratered: 'cratered',
  SolidVariant.dry: 'dry',
  SolidVariant.frozen: 'frozen',
  SolidVariant.glacial: 'glacial',
  SolidVariant.icy: 'icy',
  SolidVariant.lunar: 'lunar',
  SolidVariant.lush: 'lush',
  SolidVariant.magma: 'magma',
  SolidVariant.muddy: 'muddy',
  SolidVariant.oasis: 'oasis',
  SolidVariant.ocean: 'ocean',
  SolidVariant.rocky: 'rocky',
  SolidVariant.snowy: 'snowy',
  SolidVariant.terrestrial: 'terrestrial',
  SolidVariant.tropical: 'tropical',
};

const _$GasVariantEnumMap = {
  GasVariant.blue: 'blue',
  GasVariant.green: 'green',
  GasVariant.orange: 'orange',
  GasVariant.red: 'red',
  GasVariant.yellow: 'yellow',
};

_$_PlanetData _$$_PlanetDataFromJson(Map<String, dynamic> json) =>
    _$_PlanetData(
      panetSize: const Vector2Serialiser()
          .fromJson(json['panetSize'] as Map<String, double>),
      starPosition: const Vector2Serialiser()
          .fromJson(json['starPosition'] as Map<String, double>),
      name: json['name'] as String,
      spritesheetPath: json['spritesheetPath'] as String,
      starDistance: (json['starDistance'] as num).toDouble(),
      revolutionSpeed: (json['revolutionSpeed'] as num).toDouble(),
      type: $enumDecode(_$PlanetBaseEnumMap, json['type']),
      solidVariant:
          $enumDecodeNullable(_$SolidVariantEnumMap, json['solidVariant']),
      gasVariant: $enumDecodeNullable(_$GasVariantEnumMap, json['gasVariant']),
    );

Map<String, dynamic> _$$_PlanetDataToJson(_$_PlanetData instance) =>
    <String, dynamic>{
      'panetSize': const Vector2Serialiser().toJson(instance.panetSize),
      'starPosition': const Vector2Serialiser().toJson(instance.starPosition),
      'name': instance.name,
      'spritesheetPath': instance.spritesheetPath,
      'starDistance': instance.starDistance,
      'revolutionSpeed': instance.revolutionSpeed,
      'type': _$PlanetBaseEnumMap[instance.type]!,
      'solidVariant': _$SolidVariantEnumMap[instance.solidVariant],
      'gasVariant': _$GasVariantEnumMap[instance.gasVariant],
    };
