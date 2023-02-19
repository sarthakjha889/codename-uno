// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$StarDataToJson(StarData instance) => <String, dynamic>{
      'position': const Vector2Serialiser().toJson(instance.position),
      'type': _$StarBaseEnumMap[instance.type]!,
    };

const _$StarBaseEnumMap = {
  StarBase.blue: 'blue',
  StarBase.red: 'red',
  StarBase.yellow: 'yellow',
};

_$_StarData _$$_StarDataFromJson(Map<String, dynamic> json) => _$_StarData(
      position: const Vector2Serialiser()
          .fromJson(json['position'] as Map<String, double>),
      type: $enumDecode(_$StarBaseEnumMap, json['type']),
    );

Map<String, dynamic> _$$_StarDataToJson(_$_StarData instance) =>
    <String, dynamic>{
      'position': const Vector2Serialiser().toJson(instance.position),
      'type': _$StarBaseEnumMap[instance.type]!,
    };
