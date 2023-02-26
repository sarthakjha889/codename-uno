import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/solar_system_data.dart';
import 'package:game_test_bonfire/space_elements/planet.dart';
import 'package:game_test_bonfire/space_elements/star.dart';

class SolarSystem {
  final SolarSystemData solarSystemData;

  SolarSystem({required this.solarSystemData});

  List<GameDecoration> getDecorations() {
    Star star = Star(solarSystemData.star);
    List<Planet> planets = [];

    for (PlanetData planet in solarSystemData.planets) {
      planets.add(
        Planet(planet),
      );
    }
    return [star, ...planets, ...Alfred.getMapBoundaries()];
  }
}
