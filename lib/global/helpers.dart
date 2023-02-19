import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:fast_noise/fast_noise.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/bush.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/flower.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/grass.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/tree.dart';

class Alfred {
  static Random random = Random();
  static int mapSize = 20;
  static int tileSize = 256;

  static Vector2 getMapCenter() {
    return Vector2(
      (mapSize / 2 * tileSize),
      (mapSize / 2 * tileSize),
    );
  }

  static double getRandomNumber({int? min, int? max}) {
    if (min != null && max != null) {
      ++max;
      return min + random.nextInt(max - min).toDouble();
    } else {
      return random.nextInt(max ?? 9999).toDouble();
    }
  }

  static String getRandomStringFromList(List<String> list) {
    return list[getRandomNumber(max: list.length - 1, min: 0).toInt()];
  }

  static T getRandomValueFromList<T>(List<T> list) {
    return list[getRandomNumber(max: list.length - 1, min: 0).toInt()];
  }

  static List<List<double>> generateNoiseMap({
    required int size,
    required double frequency,
    int? seed,
    double? gain,
    NoiseType? noiseType,
    CellularDistanceFunction? df,
  }) {
    return noise2(
      size,
      size,
      seed: seed ?? random.nextInt(9999),
      frequency: frequency,
      gain: gain ?? 0.5,
      noiseType: noiseType ?? NoiseType.PerlinFractal,
      cellularDistanceFunction: df ?? CellularDistanceFunction.Manhattan,
    );
  }

  static List<GameDecoration> getForestDecorations({required int mapSize}) {
    List<GameDecoration> list = [];
    List<List<double>> noiseMap = generateNoiseMap(
      size: mapSize,
      frequency: 0.5,
    );

    for (List<double> i in noiseMap) {
      for (double j in i) {
        if (j != 0) {
          switch (getRandomNumber(min: 1, max: 4).toInt()) {
            case 1:
              list.add(
                BushDecoration(
                  Vector2(
                    noiseMap.indexOf(i) * 64,
                    (64 * i.indexOf(j)).toDouble(),
                  ),
                ),
              );
              break;
            case 2:
              if (i.indexOf(j) < mapSize - 1) {
                list.add(
                  TreeDecoration(
                    Vector2(
                      noiseMap.indexOf(i) * 64,
                      (64 * i.indexOf(j)).toDouble(),
                    ),
                  ),
                );
              }
              break;
            case 3:
              list.add(
                FlowerDecoration(
                  Vector2(
                    noiseMap.indexOf(i) * 64,
                    (64 * i.indexOf(j)).toDouble(),
                  ),
                ),
              );
              break;
            case 4:
              list.add(
                GrassDecoration(
                  Vector2(
                    noiseMap.indexOf(i) * 64,
                    (64 * i.indexOf(j)).toDouble(),
                  ),
                ),
              );
              break;
            default:
          }
        }
      }
    }
    return list;
  }

  static List<GameDecoration> getBushDecorationList({required int mapSize}) {
    List<GameDecoration> list = [];
    List<List<double>> noiseMap = generateNoiseMap(
      size: mapSize,
      frequency: 0.5,
    );
    for (List<double> i in noiseMap) {
      for (double j in i) {
        if (j < 0) {
          noiseMap[noiseMap.indexOf(i)][i.indexOf(j)] = 1;
          list.add(
            BushDecoration(
              Vector2(
                noiseMap.indexOf(i) * 64,
                (64 * i.indexOf(j)).toDouble(),
              ),
            ),
          );
        }
      }
    }
    return list;
  }
}
