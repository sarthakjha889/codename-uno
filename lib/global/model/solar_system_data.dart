// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/star_data.dart';

part 'solar_system_data.freezed.dart';
part 'solar_system_data.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class SolarSystemData with _$SolarSystemData {
  const SolarSystemData._();
  const factory SolarSystemData({
    required String name,
    required StarData star,
    required List<PlanetData> planets,
  }) = _SolarSystemData;

  factory SolarSystemData.fromJson(Map<String, Object?> json) =>
      _$SolarSystemDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SolarSystemDataToJson(this);
}
