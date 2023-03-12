import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/characters/enemy.dart';
import 'package:game_test_bonfire/global/characters/player/player.dart';
import 'package:game_test_bonfire/global/characters/player/player_spritesheet.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'dart:async' as asy;
import 'package:collection/collection.dart';

import 'package:game_test_bonfire/main.dart';
import 'package:helpers/helpers.dart';

class PlayerController extends StateController<Player> {
  asy.Timer? dayCycleTimer;
  final int maxEnemies = 99;
  int currentEnemies = 0;
  asy.Timer? enemySpawnTimer;
  PlayerCharacter? player;
  asy.Timer? rangeAttackTimer;
  int gemCount = 0;
  bool shouldAutoRangeAttack = true;

  @override
  void onReady(Player component) {
    player = component as PlayerCharacter;
    currentEnemies = 0;
    player?.toggleLighting(true);
    super.onReady(component);
    handleDayTimeCycle();
    spawnEnemiesHandler();
    rangeAttackTimer = asy.Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (gameRef.livingEnemies().isNotEmpty && shouldAutoRangeAttack) {
        player?.execRangeAttack(
            Alfred.getRandomNumber(min: 999, max: 9999).toDouble());
      }
    });
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

  void incrementGemCount() {
    gemCount++;
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
                min: 4,
                max: 10,
              );
      double y = player!.position.y +
          (Random().nextDouble() * 2 - 1) *
              Alfred.tileSize *
              Alfred.getRandomNumber(
                min: 4,
                max: 10,
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
      switch (gameStateController.state.dayTimeType) {
        case DayTimeType.day:
          player?.toggleLighting(true);
          gameRef.lighting?.animateToColor(
            Colors.black.withOpacity(0.8),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 3),
          );
          gameStateController.emit(
            gameStateController.state.copyWith(
              dayTimeType: DayTimeType.evening,
            ),
          );
          break;
        case DayTimeType.evening:
          player?.toggleLighting(true);
          gameRef.lighting?.animateToColor(
            Colors.black,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 3),
          );
          gameStateController.emit(
            gameStateController.state.copyWith(dayTimeType: DayTimeType.night),
          );
          break;
        case DayTimeType.night:
          player?.toggleLighting(false);
          gameRef.lighting?.animateToColor(
            Colors.transparent,
            curve: Curves.easeInOut,
            duration: const Duration(seconds: 3),
          );
          gameStateController.emit(
            gameStateController.state.copyWith(dayTimeType: DayTimeType.day),
          );
          break;
        default:
          player?.toggleLighting(false);
          gameRef.lighting?.animateToColor(
            Colors.transparent,
            curve: Curves.easeInOut,
            duration: const Duration(seconds: 3),
          );
          gameStateController.emit(
            gameStateController.state.copyWith(
              dayTimeType: DayTimeType.day,
            ),
          );
      }
    });
  }
}
