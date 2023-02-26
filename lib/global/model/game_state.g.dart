// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'galaxy': instance.galaxy,
      'isReady': instance.isReady,
      'dayTimeType': _$DayTimeTypeEnumMap[instance.dayTimeType]!,
      'weatherType': _$WeatherTypeEnumMap[instance.weatherType]!,
      'currentSolarSystem': instance.currentSolarSystem,
    };

const _$DayTimeTypeEnumMap = {
  DayTimeType.day: 'day',
  DayTimeType.night: 'night',
};

const _$WeatherTypeEnumMap = {
  WeatherType.sunny: 'sunny',
  WeatherType.snowy: 'snowy',
  WeatherType.rainy: 'rainy',
};

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      galaxy: GalaxyData.fromJson(json['galaxy'] as Map<String, dynamic>),
      isReady: json['isReady'] as bool? ?? true,
      dayTimeType:
          $enumDecodeNullable(_$DayTimeTypeEnumMap, json['dayTimeType']) ??
              DayTimeType.day,
      weatherType:
          $enumDecodeNullable(_$WeatherTypeEnumMap, json['weatherType']) ??
              WeatherType.sunny,
      currentSolarSystem: json['currentSolarSystem'] == null
          ? null
          : SolarSystemData.fromJson(
              json['currentSolarSystem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'galaxy': instance.galaxy,
      'isReady': instance.isReady,
      'dayTimeType': _$DayTimeTypeEnumMap[instance.dayTimeType]!,
      'weatherType': _$WeatherTypeEnumMap[instance.weatherType]!,
      'currentSolarSystem': instance.currentSolarSystem,
    };
