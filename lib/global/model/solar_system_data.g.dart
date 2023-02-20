// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_system_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SolarSystemDataToJson(SolarSystemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': const Vector2Serialiser().toJson(instance.position),
      'star': instance.star,
      'planets': instance.planets,
      'backgroundSpritePath': instance.backgroundSpritePath,
    };

_$_SolarSystemData _$$_SolarSystemDataFromJson(Map<String, dynamic> json) =>
    _$_SolarSystemData(
      id: json['id'] as String,
      name: json['name'] as String,
      position: const Vector2Serialiser()
          .fromJson(json['position'] as Map<String, double>),
      star: StarData.fromJson(json['star'] as Map<String, dynamic>),
      planets: (json['planets'] as List<dynamic>)
          .map((e) => PlanetData.fromJson(e as Map<String, dynamic>))
          .toList(),
      backgroundSpritePath: json['backgroundSpritePath'] as String,
    );

Map<String, dynamic> _$$_SolarSystemDataToJson(_$_SolarSystemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': const Vector2Serialiser().toJson(instance.position),
      'star': instance.star,
      'planets': instance.planets,
      'backgroundSpritePath': instance.backgroundSpritePath,
    };
