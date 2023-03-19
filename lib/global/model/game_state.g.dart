// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'galaxy': instance.galaxy,
      'isReady': instance.isReady,
      'currentSolarSystem': instance.currentSolarSystem,
      'currentPlanet': instance.currentPlanet,
    };

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      galaxy: GalaxyData.fromJson(json['galaxy'] as Map<String, dynamic>),
      isReady: json['isReady'] as bool? ?? true,
      currentSolarSystem: json['currentSolarSystem'] == null
          ? null
          : SolarSystemData.fromJson(
              json['currentSolarSystem'] as Map<String, dynamic>),
      currentPlanet: json['currentPlanet'] == null
          ? null
          : PlanetData.fromJson(json['currentPlanet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'galaxy': instance.galaxy,
      'isReady': instance.isReady,
      'currentSolarSystem': instance.currentSolarSystem,
      'currentPlanet': instance.currentPlanet,
    };
