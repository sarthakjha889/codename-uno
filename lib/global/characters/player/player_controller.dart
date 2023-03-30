import 'dart:math';
import 'dart:async' as asy;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/characters/enemy.dart';
import 'package:game_test_bonfire/global/characters/player/player.dart';
import 'package:game_test_bonfire/global/data/planet_map_nodes.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/map_gen_test.dart';
import 'package:game_test_bonfire/global/levels/planet_surface.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/objects/map_boundary_tile.dart';
import 'package:game_test_bonfire/main.dart';
import 'package:helpers/helpers.dart';

class PlayerController extends StateController<Player> {
  late DayTimeType currentDayTimeType;
  asy.Timer? dayCycleTimer;
  final int maxEnemies = 99;
  int currentEnemies = 0;
  asy.Timer? enemySpawnTimer;
  PlayerCharacter? player;
  asy.Timer? rangeAttackTimer;
  int gemCount = 0;
  bool shouldAutoRangeAttack = true;
  late List<List<double>> currentMap;
  bool canChangePlanetMap = false;
  int currentMapNodeX = 0;
  int currentMapNodeY = 0;
  MapGraph<List<List<double>>> planetMapGraph = MapGraph();

  PlayerController() {
    // currentDayTimeType = Alfred.getRandomValueFromList(DayTimeType.values);
    currentDayTimeType = DayTimeType.day;
    resetPlayerCanChangePlanetMap();
  }

  @override
  void onReady(Player component) {
    player = component as PlayerCharacter;
    currentEnemies = 0;
    // player?.toggleLighting(true);
    super.onReady(component);
    // handleDayTimeCycle();
    // spawnEnemiesHandler();
    rangeAttackTimer = getAutoRangeAttackScheduler();
  }

  @override
  void onRemove(Player component) {
    dayCycleTimer?.cancel();
    rangeAttackTimer?.cancel();
    super.onRemove(component);
  }

  @override
  void update(double dt, Player component) {
    // if (component.checkInterval('seeEnemy', 250, dt) == true) {
    //   component.seeEnemy(
    //     radiusVision: component!.width * 4,
    //     notObserved: _handleNotObserveEnemy,
    //     observed: (enemies) => _handleObserveEnemy(enemies.first),
    //   );
    // }
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {}

  List<List<double>> getPlanetMapNode({
    List<String>? topEdge,
    List<String>? bottomEdge,
    List<String>? leftEdge,
    List<String>? rightEdge,
  }) {
    List<List<double>> map = mapToMatrix(
      currentMapNodeX,
      currentMapNodeY,
      topEdge: topEdge,
      bottomEdge: bottomEdge,
      leftEdge: leftEdge,
      rightEdge: rightEdge,
    );
    planetMapGraph.addMapNode(map, currentMapNodeX, currentMapNodeY);
    return map;
  }

  void changeCurrentMapNode(MapBoundarySide side, BuildContext context) {
    if (side != MapBoundarySide.none && canChangePlanetMap) {
      List<List<String>>? matrixMap = mapDoubleToString(currentMap);
      List<String>? topEdge;
      List<String>? bottomEdge;
      List<String>? leftEdge;
      List<String>? rightEdge;
      switch (side) {
        case MapBoundarySide.top:
          bottomEdge = matrixMap?.first;
          currentMapNodeY++;
          break;
        case MapBoundarySide.bottom:
          topEdge = matrixMap?.last;
          currentMapNodeY--;
          break;
        case MapBoundarySide.left:
          rightEdge = matrixMap?.map((e) => e.first).toList();
          currentMapNodeX++;
          break;
        case MapBoundarySide.right:
          leftEdge = matrixMap?.map((e) => e.last).toList();
          currentMapNodeX--;
          break;
        default:
      }

      List<List<double>> newMap =
          planetMapGraph.getNode(currentMapNodeX, currentMapNodeY)?.data ??
              getPlanetMapNode(
                topEdge: topEdge,
                bottomEdge: bottomEdge,
                leftEdge: leftEdge,
                rightEdge: rightEdge,
              );
      resetPlayerCanChangePlanetMap();
      Alfred.pushNewLevel(
        context: context,
        destination: PlanetSurface(
          mapNode: newMap,
        ),
      );
    }
  }

  resetPlayerCanChangePlanetMap() {
    canChangePlanetMap = false;
    Future.delayed(const Duration(seconds: 3), () {
      canChangePlanetMap = true;
    });
  }

  asy.Timer? getAutoRangeAttackScheduler() {
    if (player != null) {
      return asy.Timer.periodic(
          Duration(
              milliseconds: (player!.rangedAttackInterval *
                      player!.rangedAttackIntervalMultiplier)
                  .toInt()), (timer) {
        if (gameRef.livingEnemies().isNotEmpty && shouldAutoRangeAttack) {
          player?.execRangeAttack(
            Alfred.getRandomNumber(min: 100, max: 999).toDouble(),
          );
        }
      });
    }
    return null;
  }

  void incrementGemCount() {
    gemCount++;
    // player?.movementSpeedMultiplier += 0.01;
    // player?.rangedAttackIntervalMultiplier -= 0.01;
    // player?.rangedAttackSpeedMultiplier += 0.01;
    // player?.setPlayerMovementSpeed();
    // rangeAttackTimer?.cancel();
    // rangeAttackTimer = getAttackTimer();
    notifyListeners();
  }

  void spawnEnemiesHandler() {
    enemySpawnTimer =
        asy.Timer.periodic(const Duration(seconds: 1), spawnEnemies);
  }

  void spawnEnemies(_) {
    if (player != null && !player!.isDead && currentEnemies < maxEnemies) {
      currentEnemies++;
      double x = player!.position.x +
          (Random().nextDouble() * 2 - 1) *
              Alfred.tileSize *
              Alfred.getRandomNumber(
                min: 8,
                max: 20,
              );
      double y = player!.position.y +
          (Random().nextDouble() * 2 - 1) *
              Alfred.tileSize *
              Alfred.getRandomNumber(
                min: 8,
                max: 20,
              );

      gameRef.add(
        MyEnemy(
          Vector2(x, y),
        ),
      );
      gameRef.add(
        MyEnemy(
          Vector2(x + Alfred.tileSize, y + Alfred.tileSize),
        ),
      );
    } else {
      enemySpawnTimer?.cancel();
    }
  }

  void handleDayTimeCycle() {
    dayCycleTimer = asy.Timer.periodic(
        Duration(
          seconds:
              gameStateController.state.currentPlanet?.dayDurationInSeconds ??
                  30,
        ), (timer) {
      currentDayTimeType = currentDayTimeType.next;
      player?.toggleLighting(currentDayTimeType.hasLight);
      gameRef.lighting?.animateToColor(
        currentDayTimeType.lighting,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(seconds: 3),
      );
      notifyListeners();
    });
  }
}
