// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_test_bonfire/global/model/galaxy_data.dart';
import 'package:game_test_bonfire/global/model/solar_system_data.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(true) bool isReady,
    required GalaxyData galaxy,
    SolarSystemData? currentSolarSystem,
  }) = _GameState;

  factory GameState.fromJson(Map<String, Object?> json) =>
      _$GameStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GameStateToJson(this);
}
