import 'package:game_test_bonfire/global/constants.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';
import 'package:game_test_bonfire/global/model/star_data.dart';
import 'package:helpers/helpers.dart';

class SolarSystemUseCase {
  StarBase getRandomStarType() {
    return Alfred.getRandomValueFromList(StarBase.values);
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
}
