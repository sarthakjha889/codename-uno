// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'isReady': instance.isReady,
      'solarSystems': instance.solarSystems,
    };

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      isReady: json['isReady'] as bool? ?? true,
      solarSystems: (json['solarSystems'] as List<dynamic>?)
              ?.map((e) => SolarSystemData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'isReady': instance.isReady,
      'solarSystems': instance.solarSystems,
    };
