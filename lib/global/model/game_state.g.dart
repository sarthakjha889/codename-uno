// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'isReady': instance.isReady,
      'galaxy': instance.galaxy,
      'currentSolarSystem': instance.currentSolarSystem,
    };

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      isReady: json['isReady'] as bool? ?? true,
      galaxy: GalaxyData.fromJson(json['galaxy'] as Map<String, dynamic>),
      currentSolarSystem: json['currentSolarSystem'] == null
          ? null
          : SolarSystemData.fromJson(
              json['currentSolarSystem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'isReady': instance.isReady,
      'galaxy': instance.galaxy,
      'currentSolarSystem': instance.currentSolarSystem,
    };
