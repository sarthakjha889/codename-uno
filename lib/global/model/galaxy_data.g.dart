// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'galaxy_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GalaxyDataToJson(GalaxyData instance) =>
    <String, dynamic>{
      'solarSystems': instance.solarSystems,
    };

_$_GalaxyData _$$_GalaxyDataFromJson(Map<String, dynamic> json) =>
    _$_GalaxyData(
      solarSystems: (json['solarSystems'] as List<dynamic>?)
              ?.map((e) => SolarSystemData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GalaxyDataToJson(_$_GalaxyData instance) =>
    <String, dynamic>{
      'solarSystems': instance.solarSystems,
    };
