import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/constants.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/star_data.dart';
import 'package:game_test_bonfire/space_elements/planet.dart';
import 'package:game_test_bonfire/space_elements/star.dart';
import 'package:helpers/helpers.dart';

class SolarSystem {
  late final int numberOfPlanets;
  late final Star star;
  List<Planet> planets = [];

  SolarSystem() {
    numberOfPlanets = Alfred.getRandomNumber(min: 1, max: 5).toInt();
    star = Star(
      StarData(
        position: Alfred.getMapCenter(),
        type: getRandomStarType(),
      ),
    );

    for (int i = 1; i <= numberOfPlanets; i++) {
      double planetSize = Alfred.getRandomNumber(min: 128, max: 256);
      PlanetBase base = getRandomPlanetBase();
      SolidPlanetVariant? solidPlanetVariant;
      GasPlanetVariant? gasPlanetVariant;
      if (base == PlanetBase.solid) {
        solidPlanetVariant = getRandomSolidPlanetVariant();
      } else {
        gasPlanetVariant = getRandomGasPlanetVariant();
      }
      planets.add(
        Planet(
          PlanetData(
            planetSize: Vector2(planetSize, planetSize),
            starPosition: Alfred.getMapCenter(),
            name: getRandomPlanetName(),
            starDistance:
                (i * Alfred.getRandomNumber(max: 3, min: 2) * Alfred.tileSize)
                    .toDouble(),
            revolutionSpeed: Alfred.getRandomNumber(min: 1, max: 2) /
                Alfred.getRandomNumber(min: 10, max: 20),
            type: base,
            solidVariant: solidPlanetVariant,
            gasVariant: gasPlanetVariant,
            spritesheetPath: getPlanetSpritesheet(
              base: base,
              gasVariant: gasPlanetVariant,
              solidVariant: solidPlanetVariant,
            ),
          ),
        ),
      );
    }
  }

  List<GameDecoration> getSystem() {
    return [star, ...planets];
  }

  String getRandomPlanetName() {
    String prefix = Alfred.random.nextBool()
        ? Alfred.getRandomStringFromList(planetPrefixes)
        : '';
    String base = Alfred.getRandomStringFromList(planetBaseNames);
    String suffix = Alfred.random.nextBool()
        ? Alfred.getRandomStringFromList(planetSuffixes)
        : '';
    String numericSuffix = Alfred.random.nextBool()
        ? Alfred.getRandomStringFromList(planetNameNumericSuffix)
        : '';
    return [prefix, base, suffix, numericSuffix]
        .where((element) => element.isNotEmpty)
        .join(' ');
  }

  PlanetBase getRandomPlanetBase() {
    return Alfred.getRandomValueFromList(PlanetBase.values);
  }

  SolidPlanetVariant getRandomSolidPlanetVariant() {
    return Alfred.getRandomValueFromList(SolidPlanetVariant.values);
  }

  GasPlanetVariant getRandomGasPlanetVariant() {
    return Alfred.getRandomValueFromList(GasPlanetVariant.values);
  }

  StarBase getRandomStarType() {
    return Alfred.getRandomValueFromList(StarBase.values);
  }

  String getPlanetSpritesheet({
    required PlanetBase base,
    SolidPlanetVariant? solidVariant,
    GasPlanetVariant? gasVariant,
  }) {
    if (base == PlanetBase.solid) {
      return "planets/Solid/${solidVariant?.name.toCapitalize()}/spritesheet.png";
    } else {
      return "planets/Gaseous/${gasVariant?.name.toCapitalize()} Giant/spritesheet.png";
    }
  }
}
