// This file is "main.dart"
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/serialisers/color_serialiser.dart';
import 'package:game_test_bonfire/global/serialisers/vector2_serialiser.dart';

part 'star_data.freezed.dart';
part 'star_data.g.dart';

enum StarBase {
  blue(
    lighting: Colors.blueAccent,
    spritesheetPath: 'planets/Suns/Blue Sun/spritesheet.png',
  ),
  red(
    lighting: Colors.redAccent,
    spritesheetPath: 'planets/Suns/Red Sun/spritesheet.png',
  ),
  yellow(
    lighting: Colors.yellowAccent,
    spritesheetPath: 'planets/Suns/Yellow Sun/spritesheet.png',
  );

  final Color lighting;
  final String spritesheetPath;
  const StarBase({
    required this.lighting,
    required this.spritesheetPath,
  });
}

@JsonSerializable(createFactory: false)
@freezed
class StarData with _$StarData {
  const StarData._();
  const factory StarData({
    required String name,
    @Vector2Serialiser() required Vector2 position,
    @ColorSerialiser() required StarBase type,
  }) = _StarData;

  factory StarData.fromJson(Map<String, Object?> json) =>
      _$StarDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StarDataToJson(this);
}
