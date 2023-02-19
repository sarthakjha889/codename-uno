import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helpers/helpers.dart';

class ColorSerialiser implements JsonConverter<Color, String> {
  const ColorSerialiser();

  @override
  Color fromJson(String json) {
    String sanitizedJson = json
        .toLowerCase()
        .replaceAll('color(0xff', '')
        .replaceAll('colorswatch(primary value: ', '')
        .replaceAll(')', '');
    return Color(int.parse('0xff$sanitizedJson'));
  }

  @override
  String toJson(Color color) => color.toHex();
}
