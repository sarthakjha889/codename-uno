import 'dart:io';
import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:fast_noise/fast_noise.dart';
import 'package:game_test_bonfire/global/characters/player/player_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';

Map<String, double> mapToMatrixMapping = {
  'L': 1,
  '~': 2,
  'T': 3,
  'w': 4,
  'R': 5,
  'i': 6,
  'r': 7,
};

Map<double, String> matrixMappingToMap = {
  1: 'L',
  2: '~',
  3: 'T',
  4: 'w',
  5: 'R',
  6: 'i',
  7: 'r',
};

List<List<double>>? mapStringToDouble(List<List<String>>? rawMap) {
  if (rawMap != null) {
    List<List<double>> matrixMap = List.generate(
        rawMap.length, (index) => List.generate(rawMap.length, (index) => 1));
    List.generate(
        rawMap.length, (index) => List.generate(rawMap.length, (index) => 1));
    for (int i = 0; i < rawMap.length; i++) {
      for (int j = 0; j < rawMap.length; j++) {
        matrixMap[i][j] = mapToMatrixMapping[rawMap[i][j]] ?? 1;
      }
    }
    return matrixMap;
  } else {
    return null;
  }
}

List<List<String>>? mapDoubleToString(List<List<double>>? rawMap) {
  if (rawMap != null) {
    List<List<String>> matrixMap = List.generate(
        rawMap.length, (index) => List.generate(rawMap.length, (index) => 'L'));
    for (int i = 0; i < rawMap.length; i++) {
      for (int j = 0; j < rawMap.length; j++) {
        matrixMap[i][j] = matrixMappingToMap[rawMap[i][j]] ?? 'L';
      }
    }
    return matrixMap;
  } else {
    return null;
  }
}

List<List<double>> mapToMatrix(
  int mapNodeX,
  int mapNodeY, {
  List<String>? topEdge,
  List<String>? bottomEdge,
  List<String>? leftEdge,
  List<String>? rightEdge,
}) {
  List<List<String>> rawMap = mapTest(
    mapNodeX,
    mapNodeY,
    topEdge: topEdge,
    bottomEdge: bottomEdge,
    leftEdge: leftEdge,
    rightEdge: rightEdge,
  );

  return mapStringToDouble(rawMap)!;
}

List<List<String>> mapTest(
  int mapNodeX,
  int mapNodeY, {
  List<String>? topEdge,
  List<String>? bottomEdge,
  List<String>? leftEdge,
  List<String>? rightEdge,
}) {
  final Map<String, dynamic> config = {
    'width': Alfred.mapSize,
    'height': Alfred.mapSize,
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
  PlayerController playerController = BonfireInjector().get<PlayerController>();
  List<List<String>>? topMap = mapDoubleToString(
      playerController.planetMapGraph.getNode(mapNodeX, mapNodeY - 1)?.data);
  List<List<String>>? leftMap = mapDoubleToString(
      playerController.planetMapGraph.getNode(mapNodeX - 1, mapNodeY)?.data);
  List<List<String>>? rightMap = mapDoubleToString(
      playerController.planetMapGraph.getNode(mapNodeX + 1, mapNodeY)?.data);
  List<List<String>>? bottomMap = mapDoubleToString(
      playerController.planetMapGraph.getNode(mapNodeX, mapNodeY + 1)?.data);

  List<List<String>> combinedMap = generateCombinedMap(
    config,
    mapNodeX,
    mapNodeY,
    topEdge: topEdge ?? topMap?.last,
    bottomEdge: bottomEdge ?? bottomMap?.first,
    leftEdge: leftEdge ?? leftMap?.map((e) => e.last).toList(),
    rightEdge: rightEdge ?? rightMap?.map((e) => e.first).toList(),
  );
  return combinedMap;
}

List<List<String>> generateCombinedMap(
  Map<String, dynamic> config,
  int mapNodeX,
  int mapNodeY, {
  List<String>? topEdge,
  List<String>? bottomEdge,
  List<String>? leftEdge,
  List<String>? rightEdge,
}) {
  List<List<String>> landWaterMap = generateLandAndWater(
    config,
    topEdge: topEdge,
    bottomEdge: bottomEdge,
    leftEdge: leftEdge,
    rightEdge: rightEdge,
  );
  List<List<String>> treesRuinsPlantsMap = generateTreesRuinsPlants(
    config,
    landWaterMap,
    topEdge: topEdge,
    bottomEdge: bottomEdge,
    leftEdge: leftEdge,
    rightEdge: rightEdge,
  );
  List<List<String>> combinedMap =
      combineMaps(landWaterMap, treesRuinsPlantsMap, config);
  List<List<String>> mapWithPOIs = generatePOIs(combinedMap, config);
  List<List<String>> finalMap =
      createPathsForTileTypes(mapWithPOIs, ['i', 'R']);
  return finalMap;
}

List<List<String>> generateLandAndWater(
  Map<String, dynamic> config, {
  List<String>? topEdge,
  List<String>? bottomEdge,
  List<String>? leftEdge,
  List<String>? rightEdge,
}) {
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

void printMap(List<List<dynamic>> map) {
  for (int y = 0; y < map.length; y++) {
    for (int x = 0; x < map[y].length; x++) {
      stdout.write(map[y][x].toString().replaceAll('.0', ''));
    }
    stdout.write('\n');
  }
}

class Point {
  int x;
  int y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  int get hashCode => x.hashCode ^ y.hashCode;
}

class Rectangle {
  Point topLeft;
  Point bottomRight;

  Rectangle(this.topLeft, this.bottomRight);

  bool contains(Point point) {
    return point.x >= topLeft.x &&
        point.x <= bottomRight.x &&
        point.y >= topLeft.y &&
        point.y <= bottomRight.y;
  }

  Point randomPointInside() {
    Random random = Random();
    int x = random.nextInt(bottomRight.x - topLeft.x + 1) + topLeft.x;
    int y = random.nextInt(bottomRight.y - topLeft.y + 1) + topLeft.y;
    return Point(x, y);
  }
}

List<List<Point>> kMeansClustering(List<Point> points, int k) {
  // Initialize cluster centroids randomly
  List<Point> centroids = List.generate(k, (_) {
    int randomIndex = Random().nextInt(points.length);
    return Point(points[randomIndex].x, points[randomIndex].y);
  });

  List<List<Point>> clusters = List.generate(k, (_) => []);

  bool centroidsChanged = true;
  while (centroidsChanged) {
    centroidsChanged = false;
    // Assign points to the closest centroid
    for (Point point in points) {
      int closestCentroidIndex = 0;
      double minDistance = double.infinity;

      for (int i = 0; i < centroids.length; i++) {
        double distance = point.distanceTo(centroids[i]);
        if (distance < minDistance) {
          minDistance = distance;
          closestCentroidIndex = i;
        }
      }

      clusters[closestCentroidIndex].add(point);
    }

    // Update centroids based on the mean of the assigned points
    for (int i = 0; i < centroids.length; i++) {
      if (clusters[i].isEmpty) continue;

      int sumX = 0;
      int sumY = 0;
      for (Point point in clusters[i]) {
        sumX += point.x;
        sumY += point.y;
      }

      int meanX = sumX ~/ clusters[i].length;
      int meanY = sumY ~/ clusters[i].length;
      Point newCentroid = Point(meanX, meanY);

      if (centroids[i].distanceTo(newCentroid) > 0) {
        centroidsChanged = true;
        centroids[i] = newCentroid;
      }
    }
  }

  return clusters;
}

List<Rectangle> createRectangles(List<List<Point>> clusters) {
  List<Rectangle> rectangles = [];

  for (List<Point> cluster in clusters) {
    int minX = cluster[0].x;
    int maxX = cluster[0].x;
    int minY = cluster[0].y;
    int maxY = cluster[0].y;

    for (Point point in cluster) {
      minX = min(minX, point.x);
      maxX = max(maxX, point.x);
      minY = min(minY, point.y);
      maxY = max(maxY, point.y);
    }

    rectangles.add(Rectangle(Point(minX, minY), Point(maxX, maxY)));
  }

  return rectangles;
}

void createPath(Point start, Point end, List<List<String>> map) {
  int height = map.length;
  int width = height;
  Point current = start;
  int maxIterations = 1000;
  int iterations = 0;
  double diagonalProbability = 0.3;

  while (current != end && iterations < maxIterations) {
    List<Point> possibleMoves = [
      Point(current.x + 1, current.y),
      Point(current.x - 1, current.y),
      Point(current.x, current.y + 1),
      Point(current.x, current.y - 1),
    ];

    if (Random().nextDouble() < diagonalProbability) {
      possibleMoves.addAll([
        Point(current.x + 1, current.y + 1),
        Point(current.x - 1, current.y - 1),
        Point(current.x - 1, current.y + 1),
        Point(current.x + 1, current.y - 1),
      ]);
    }

    possibleMoves
        .sort((a, b) => (a.distanceTo(end)).compareTo(b.distanceTo(end)));

    // Filter out moves that would create a path thicker than 1 tile
    possibleMoves = possibleMoves.where((move) {
      int adjacentRoadCount = 0;
      for (int dx = -1; dx <= 1; dx += 2) {
        for (int dy = -1; dy <= 1; dy += 2) {
          int newX = move.x + dx;
          int newY = move.y + dy;
          if (newX >= 0 &&
              newX < width &&
              newY >= 0 &&
              newY < height &&
              map[newY][newX] == 'r') {
            adjacentRoadCount++;
          }
        }
      }
      return adjacentRoadCount <= 1;
    }).toList();

    Point nextMove = possibleMoves.firstWhere(
        (move) =>
            move.x >= 0 && move.x < width && move.y >= 0 && move.y < height,
        orElse: () => current);

    if (map[nextMove.y][nextMove.x] != 'W' &&
        map[nextMove.y][nextMove.x] != 'i') {
      if (map[current.y][current.x] != 'i') {
        map[current.y][current.x] = 'r';
      }
    }

    current = nextMove;
    iterations++;
  }
}

void connectClustersWithRectangles(
    List<List<Point>> clusters, List<List<String>> map) {
  List<Rectangle> rectangles = createRectangles(clusters);

  for (int i = 0; i < rectangles.length; i++) {
    for (int j = i + 1; j < rectangles.length; j++) {
      Point start = rectangles[i].randomPointInside();
      Point end = rectangles[j].randomPointInside();
      createPath(start, end, map);
    }
  }
}

List<List<String>> createPathsForTileTypes(
    List<List<String>> map, List<String> tileTypes) {
  int width = map[0].length;
  int height = map.length;

  List<Point> getTilesByTypes(List<String> types) {
    List<Point> result = [];
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (types.contains(map[y][x])) {
          result.add(Point(x, y));
        }
      }
    }
    return result;
  }

  List<Point> tiles = getTilesByTypes(tileTypes);

  for (int i = 0; i < tiles.length; i++) {
    for (int j = i + 1; j < tiles.length; j++) {
      createPath(tiles[i], tiles[j], map);
    }
  }

  return map;
}
