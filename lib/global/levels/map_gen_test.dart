import 'dart:io';
import 'dart:math';
import 'package:fast_noise/fast_noise.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:helpers/helpers.dart';

Map<String, double> mapToMatrixMapping = {
  'L': 1,
  '~': 2,
  'T': 3,
  'w': 4,
  'R': 5,
  'i': 6,
  'r': 7,
};

List<List<double>> mapToMatrix() {
  List<List<String>> rawMap = mapTest();
  List<List<double>> matrixMap = List.generate(
      rawMap.length, (index) => List.generate(rawMap.length, (index) => 1));
  for (int i = 0; i < rawMap.length; i++) {
    for (int j = 0; j < rawMap.length; j++) {
      matrixMap[i][j] = mapToMatrixMapping[rawMap[i][j]] ?? 1;
    }
  }
  printMap(rawMap);
  return matrixMap;
}

List<List<String>> mapTest() {
  final Map<String, dynamic> config = {
    'width': 30,
    'height': 30,
    'landWater': {
      'landRatio': 0.55,
      'smoothIterations': 10,
      'landThreshold': 4.0,
    },
    'tiles': [
      {
        'type': 'L',
        'minNoise': 0.5,
        'maxNoise': 1.0,
        'allowedNeighbors': ['L', 'T', 'w', 'R']
      }, // Land
      {
        'type': '~',
        'minNoise': 0.0,
        'maxNoise': 0.2,
        'allowedNeighbors': ['~', 's']
      }, // Water
      {
        'type': 'T',
        'minNoise': 0.4,
        'maxNoise': 0.5,
        'allowedNeighbors': ['L', 'T']
      }, // Trees
      {
        'type': 'w',
        'minNoise': 0.3,
        'maxNoise': 0.4,
        'allowedNeighbors': ['L', 'w']
      }, // Plants
      {
        'type': 'R',
        'minNoise': 0.2,
        'maxNoise': 0.3,
        'allowedNeighbors': ['L']
      }, // Ruins
      {
        'type': 's',
        'minNoise': 0.2,
        'maxNoise': 0.3,
        'allowedNeighbors': ['L', 'w']
      }, // R
    ],
    'noise': {
      'octaves': 6,
      'persistence': 0.5,
      'lacunarity': 2.0,
      'scale': 30.0,
    },
  };

  List<List<String>> combinedMap = generateCombinedMap(config);
  return combinedMap;
}

List<List<String>> generateCombinedMap(Map<String, dynamic> config) {
  List<List<String>> landWaterMap = generateLandAndWater(config);
  List<List<String>> treesRuinsPlantsMap =
      generateTreesRuinsPlants(config, landWaterMap);
  List<List<String>> combinedMap =
      combineMaps(landWaterMap, treesRuinsPlantsMap, config);
  List<List<String>> mapWithPOIs = generatePOIs(combinedMap, config);
  List<List<String>> finalMap = connectPOIs(mapWithPOIs, config);
  return finalMap;
}

List<List<String>> generateLandAndWater(Map<String, dynamic> config,
    {List<String>? topEdge,
    List<String>? bottomEdge,
    List<String>? leftEdge,
    List<String>? rightEdge}) {
  int height = config['height'];
  int width = config['width'];
  double initialLandRatio = config['landWater']['landRatio'];
  int smoothIterations = config['landWater']['smoothIterations'];
  List<List<String>> map = List.generate(
      height, (_) => List.generate(width, (_) => 'L', growable: false),
      growable: false);
  Random rand = Random();

  // Initialize the map randomly
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      // If edge information is provided, use it instead of random initialization
      if (y == 0 && topEdge != null) {
        map[y][x] = topEdge[x];
      } else if (y == height - 1 && bottomEdge != null) {
        map[y][x] = bottomEdge[x];
      } else if (x == 0 && leftEdge != null) {
        map[y][x] = leftEdge[y];
      } else if (x == width - 1 && rightEdge != null) {
        map[y][x] = rightEdge[y];
      } else {
        map[y][x] = (rand.nextDouble() < initialLandRatio) ? 'L' : '~';
      }
    }
  }

  // Smooth the map using Cellular Automata rules
  for (int i = 0; i < smoothIterations; i++) {
    map = smoothMap(map, config, topEdge, bottomEdge, leftEdge, rightEdge);
  }

  return map;
}

List<List<String>> smoothMap(
    List<List<String>> map, Map<String, dynamic> config,
    [List<String>? topEdge,
    List<String>? bottomEdge,
    List<String>? leftEdge,
    List<String>? rightEdge]) {
  int height = config['height'];
  int width = config['width'];
  double landThreshold = config['landWater']['landThreshold'];
  List<List<String>> newMap =
      List.generate(height, (_) => List.generate(width, (_) => 'L'));

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int landNeighbors = countNeighbors(map, x, y, 'L', config);

      if (y == 0 && topEdge != null) {
        newMap[y][x] = topEdge[x];
      } else if (y == height - 1 && bottomEdge != null) {
        newMap[y][x] = bottomEdge[x];
      } else if (x == 0 && leftEdge != null) {
        newMap[y][x] = leftEdge[y];
      } else if (x == width - 1 && rightEdge != null) {
        newMap[y][x] = rightEdge[y];
      } else {
        if (map[y][x] == 'L') {
          newMap[y][x] = (landNeighbors >= landThreshold) ? 'L' : '~';
        } else {
          newMap[y][x] = (landNeighbors > landThreshold) ? 'L' : '~';
        }
      }
    }
  }

  return newMap;
}

int countNeighbors(List<List<String>> map, int x, int y, String targetType,
    Map<String, dynamic> config) {
  int height = config['height'];
  int width = config['width'];
  int count = 0;

  for (int dy = -1; dy <= 1; dy++) {
    for (int dx = -1; dx <= 1; dx++) {
      int ny = y + dy;
      int nx = x + dx;

      if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
        if (map[ny][nx] == targetType) {
          count++;
        }
      }
    }
  }

  return count;
}

List<List<String>> generateTreesRuinsPlants(
    Map<String, dynamic> config, List<List<String>> landWaterMap,
    {List<String>? topEdge,
    List<String>? bottomEdge,
    List<String>? leftEdge,
    List<String>? rightEdge}) {
  int width = config['width'];
  int height = config['height'];
  List<Map<String, dynamic>> tiles = config['tiles'];
  Map<String, dynamic> noiseConfig = config['noise'];

  List<List<String>> map =
      List.generate(height, (_) => List.generate(width, (_) => ' '));

  final CubicNoise noise = CubicNoise(
    frequency: Alfred.getRandomNumber(min: 1, max: 5) / 10,
    gain: Alfred.getRandomNumber(min: 1, max: 5) / 10,
  );

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (topEdge != null && y == 0) {
        map[y][x] = topEdge[x];
        continue;
      }
      if (bottomEdge != null && y == height - 1) {
        map[y][x] = bottomEdge[x];
        continue;
      }
      if (leftEdge != null && x == 0) {
        map[y][x] = leftEdge[y];
        continue;
      }
      if (rightEdge != null && x == width - 1) {
        map[y][x] = rightEdge[y];
        continue;
      }

      double noiseValue = 0.0;
      noiseValue = noise.getCubicFractal2(x.toDouble(), y.toDouble());
      noiseValue = (noiseValue + 1) / 2;
      // printLime(noiseValue);
      for (Map<String, dynamic> tile in tiles) {
        if (noiseValue >= tile['minNoise'] && noiseValue < tile['maxNoise']) {
          if (isValidNeighbor(x, y, tile, map, landWaterMap)) {
            map[y][x] = tile['type'];
          } else {
            map[y][x] = 'L';
          }
          break;
        }
      }
    }
  }

  return map;
}

List<List<String>> combineMaps(List<List<String>> landWaterMap,
    List<List<String>> treesRuinsPlantsMap, Map<String, dynamic> config) {
  int width = landWaterMap[0].length;
  int height = landWaterMap.length;
  List<Map<String, dynamic>> tiles = config['tiles'];

  List<List<String>> combinedMap =
      List.generate(height, (_) => List.generate(width, (_) => ' '));

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (landWaterMap[y][x] == 'L') {
        String treesRuinsPlantsTile = treesRuinsPlantsMap[y][x];
        Map<String, dynamic> tileConfig =
            tiles.firstWhere((tile) => tile['type'] == treesRuinsPlantsTile);

        if (isValidNeighbor(
            x, y, tileConfig, treesRuinsPlantsMap, landWaterMap)) {
          combinedMap[y][x] = treesRuinsPlantsTile;
        } else {
          combinedMap[y][x] = landWaterMap[y][x];
        }
      } else {
        combinedMap[y][x] = landWaterMap[y][x];
      }
    }
  }

  return combinedMap;
}

bool isValidNeighbor(int x, int y, Map<String, dynamic> tile,
    List<List<String>> treesRuinsPlantsMap, List<List<String>> landWaterMap) {
  int width = treesRuinsPlantsMap[0].length;
  int height = treesRuinsPlantsMap.length;
  List<String> allowedNeighbors = tile['allowedNeighbors'];

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) continue;
      if (x + i < 0 || x + i >= width || y + j < 0 || y + j >= height) continue;

      String neighboringTile = landWaterMap[y + j][x + i];
      if (!allowedNeighbors.contains(neighboringTile)) {
        return false;
      }
    }
  }

  return true;
}

List<List<String>> generatePOIs(
    List<List<String>> map, Map<String, dynamic> config) {
  int width = config['width'];
  int height = config['height'];
  int minPOIs = 2;
  int maxPOIs = 5;
  Random rand = Random();

  int numPOIs = rand.nextInt(maxPOIs - minPOIs + 1) + minPOIs;

  for (int i = 0; i < numPOIs; i++) {
    int x, y;
    do {
      x = rand.nextInt(width - 2) + 1;
      y = rand.nextInt(height - 2) + 1;
    } while (map[y][x] != 'L');
    map[y][x] = 'i';
  }

  return map;
}

List<List<String>> connectPOIs(
    List<List<String>> map, Map<String, dynamic> config) {
  int width = config['width'];
  int height = config['height'];

  List<Point> pois = [];

  for (int y = 1; y < height - 1; y++) {
    for (int x = 1; x < width - 1; x++) {
      if (map[y][x] == 'i') {
        pois.add(Point(x, y));
      }
    }
  }
  void createPath(Point start, Point end) {
    Point current = start;
    int maxIterations = 1000;
    int iterations = 0;
    double zigzagProbability = 0.3;

    while (current != end && iterations < maxIterations) {
      List<Point> possibleMoves = [
        Point(current.x + 1, current.y),
        Point(current.x - 1, current.y),
        Point(current.x, current.y + 1),
        Point(current.x, current.y - 1),
      ];

      // Filter out moves that are out of the map boundaries
      possibleMoves = possibleMoves.where((move) {
        return move.x >= 1 &&
            move.x < width - 1 &&
            move.y >= 1 &&
            move.y < height - 1;
      }).toList();

      // Filter out moves that would create a path thicker than 2 tiles
      possibleMoves = possibleMoves.where((move) {
        int adjacentRoadCount = 0;
        for (int dx = -1; dx <= 1; dx++) {
          for (int dy = -1; dy <= 1; dy++) {
            if (dx == 0 && dy == 0) continue;
            if (map[move.y + dy][move.x + dx] == 'r') adjacentRoadCount++;
          }
        }
        return adjacentRoadCount <= 2;
      }).toList();

      if (possibleMoves.isNotEmpty) {
        Point nextMove = possibleMoves[Random().nextInt(possibleMoves.length)];

        if (map[nextMove.y][nextMove.x] != 'W' &&
            map[nextMove.y][nextMove.x] != 'i') {
          if (map[current.y][current.x] != 'i') {
            map[current.y][current.x] = 'r';
          }
        }
        current = nextMove;
      }

      iterations++;
    }
  }

  for (int i = 0; i < pois.length - 1; i++) {
    createPath(pois[i], pois[i + 1]);
  }

  List<Point> edgePoints = [
    Point(0, Random().nextInt(height)),
    Point(width - 1, Random().nextInt(height)),
    Point(Random().nextInt(width), 0),
    Point(Random().nextInt(width), height - 1),
  ];

  for (Point poi in pois) {
    Point edgePoint = edgePoints[Random().nextInt(edgePoints.length)];
    createPath(poi, edgePoint);
  }

  // Create additional paths between random POIs to sprawl paths all over the map
  int additionalPaths = Random().nextInt(pois.length);
  for (int i = 0; i < additionalPaths; i++) {
    Point start = pois[Random().nextInt(pois.length)];
    Point end = pois[Random().nextInt(pois.length)];
    createPath(start, end);
  }

  return map;
}

void printMap(List<List<dynamic>> map) {
  for (int y = 0; y < map.length; y++) {
    for (int x = 0; x < map[y].length; x++) {
      stdout.write(map[y][x].toString().replaceAll('.0', ''));
    }
    stdout.write('\n');
  }
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  int get hashCode => x.hashCode ^ y.hashCode;
}
