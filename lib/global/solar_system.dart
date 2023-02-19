import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/constants.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/space_elements/planet.dart';
import 'package:game_test_bonfire/space_elements/star.dart';
import 'package:helpers/helpers.dart';

class SolarSystem {
  late final int numberOfPlanets;
  late final Star star;
  List<Planet> planets = [];

  SolarSystem() {
    numberOfPlanets = Alfred.getRandomNumber(min: 1, max: 5).toInt();
    String starSpritesheet = getRandomStarSpritesheet();
    Color starLightColor;
    if (starSpritesheet.contains('Blue')) {
      starLightColor = Colors.blueAccent.withOpacity(0.5);
    } else if (starSpritesheet.contains('Red')) {
      starLightColor = Colors.redAccent.withOpacity(0.5);
    } else {
      starLightColor = Colors.yellowAccent.withOpacity(0.5);
    }
    star = Star(
      Alfred.getMapCenter(),
      spritesheetPath: starSpritesheet,
      lightiningColor: starLightColor,
    );

    for (int i = 1; i <= numberOfPlanets; i++) {
      double planetSize = Alfred.getRandomNumber(min: 128, max: 256);
      planets.add(
        Planet(
          Alfred.getMapCenter(),
          spritesheetPath: getRandomPlanetSpritesheet(),
          starDistance:
              (i * Alfred.getRandomNumber(max: 3, min: 2) * Alfred.tileSize)
                  .toDouble(),
          revolutionSpeed: Alfred.getRandomNumber(min: 1, max: 2) /
              Alfred.getRandomNumber(min: 10, max: 20),
          planetSize: Vector2(planetSize, planetSize),
          name: getRandomPlanetName(),
        ),
      );
    }
  }

  List<GameDecoration> getSystem() {
    for (Planet planet in planets) {
      print(planet.starDistance);
    }
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

  String getRandomStarSpritesheet() {
    return 'planets/Suns/${Alfred.getRandomStringFromList(starVariants)} Sun/spritesheet.png';
  }

  String getRandomPlanetBase() {
    return Alfred.getRandomStringFromList(planetBase);
  }

  String getRandomPlanetSpritesheet() {
    String planetBase = getRandomPlanetBase();
    switch (planetBase) {
      case 'Solid':
        return "planets/$planetBase/${Alfred.getRandomStringFromList(solidPlanetVariants)}/spritesheet.png";
      case 'Gaseous':
        return "planets/$planetBase/${Alfred.getRandomStringFromList(gasPlanetVariants)} Giant/spritesheet.png";
      default:
        return "planets/$planetBase/${Alfred.getRandomStringFromList(solidPlanetVariants)}/spritesheet.png";
    }
  }
}
