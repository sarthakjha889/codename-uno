import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/model/solar_system_data.dart';

part 'galaxy_data.freezed.dart';
part 'galaxy_data.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class GalaxyData with _$GalaxyData {
  const GalaxyData._();
  const factory GalaxyData({
    @Default([]) List<SolarSystemData> solarSystems,
  }) = _GalaxyData;

  factory GalaxyData.fromJson(Map<String, Object?> json) =>
      _$GalaxyDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GalaxyDataToJson(this);
}
