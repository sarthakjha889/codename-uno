// import 'package:bonfire/bonfire.dart';

import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/galaxy_data.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/solar_system_data.dart';
import 'package:game_test_bonfire/global/model/star_data.dart';
import 'package:game_test_bonfire/global/use_cases/solar_system_use_case.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

class GameStateController extends Cubit<GameState> {
  GameStateController() : super(const GameState(galaxy: GalaxyData())) {
    GalaxyData galaxy = getGalaxyData();
    emit(
      state.copyWith(
        galaxy: galaxy,
        currentSolarSystem: galaxy.solarSystems.first,
        isReady: true,
      ),
    );
  }

  SolarSystemUseCase solarSystemUseCase = SolarSystemUseCase();
  Uuid uuid = const Uuid();

  void changeCurrentSolarSystem(SolarSystemData e) {
    emit(state.copyWith(currentSolarSystem: e));
  }

  GalaxyData getGalaxyData() {
    int numberOfSolarSystems = Alfred.getRandomNumber(max: 50, min: 20);
    List<SolarSystemData> solarSystems = [];

    for (int i = 0; i < numberOfSolarSystems; i++) {
      solarSystems.add(getSolarSystemData());
    }

    return GalaxyData(solarSystems: solarSystems);
  }

  /// [getSolarSystemData] returns a randomly generated [SolarSystemData] which contains properties for a star and multiple planets.
  SolarSystemData getSolarSystemData() {
    // Decide random number of planets
    int numberOfPlanets = Alfred.getRandomNumber(min: 1, max: 5);
    List<PlanetData> planets = [];
    // Build a random star
    StarData star = StarData(
      name: 'Star name',
      position: Alfred.getMapCenter(),
      type: solarSystemUseCase.getRandomStarType(),
    );
    // Add planets for the number of planets decided
    for (int i = 1; i <= numberOfPlanets; i++) {
      // Planet illustration size
      double planetSize = Alfred.getRandomNumber(min: 128, max: 256).toDouble();
      // Decide on the type of planets from solid or gaseous
      PlanetBase base = solarSystemUseCase.getRandomPlanetBase();
      SolidPlanetVariant? solidPlanetVariant;
      GasPlanetVariant? gasPlanetVariant;
      // Get random planet biome depending on the planet base
      if (base == PlanetBase.solid) {
        solidPlanetVariant = solarSystemUseCase.getRandomSolidPlanetVariant();
      } else {
        gasPlanetVariant = solarSystemUseCase.getRandomGasPlanetVariant();
      }
      // Add the planet data as per the randomised configs
      planets.add(
        PlanetData(
          planetSize: Vector2(planetSize, planetSize),
          starPosition: Alfred.getMapCenter(),
          name: solarSystemUseCase.getRandomPlanetName(),
          starDistance: (((i * 1.5) + 1) * Alfred.tileSize).toDouble(),
          revolutionSpeed: Alfred.getRandomNumber(min: 1, max: 2) /
              Alfred.getRandomNumber(min: 10, max: 20),
          type: base,
          solidVariant: solidPlanetVariant,
          gasVariant: gasPlanetVariant,
          spritesheetPath: solarSystemUseCase.getPlanetSpritesheet(
            base: base,
            gasVariant: gasPlanetVariant,
            solidVariant: solidPlanetVariant,
          ),
        ),
      );
    }
    return SolarSystemData(
      id: uuid.v4(),
      position: Vector2(
        Alfred.getRandomNumber(min: 10, max: 950).toDouble(),
        Alfred.getRandomNumber(min: 10, max: 950).toDouble(),
      ),
      name: 'Solar system name',
      backgroundSpritePath:
          'space/Space_Stars${Alfred.getRandomNumber(min: 1, max: 8).toInt()}.png',
      star: star,
      planets: planets,
    );
  }
}
