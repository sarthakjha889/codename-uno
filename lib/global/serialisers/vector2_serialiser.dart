import 'package:bonfire/bonfire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class Vector2Serialiser implements JsonConverter<Vector2, Map<String, double>> {
  const Vector2Serialiser();

  @override
  Vector2 fromJson(Map<String, double> json) {
    return Vector2(json['x']!, json['y']!);
  }

  @override
  Map<String, double> toJson(Vector2 value) => {
        'x': value.x,
        'y': value.y,
      };
}
