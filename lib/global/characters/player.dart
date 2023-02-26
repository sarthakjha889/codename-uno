import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'dart:async' as asy;

import 'package:game_test_bonfire/main.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "player/knight_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "player/knight_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Player extends SimplePlayer
    with ObjectCollision, Lighting, UseStateController<PlayerController> {
  double nightVisionMultiplier = 3;
  int? countDownSeconds;

  TextPaint textPaint = TextPaint(
      style: const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ));

  Player(Vector2 position)
      : super(
          position: position,
          size: Vector2(128, 128),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 1000,
        ) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(128, 128),
            align: Vector2(0, 0),
          ),
        ],
      ),
    );
  }

  toggleLighting(bool enable) {
    if (enable) {
      setupLighting(
        LightingConfig(
          radius: Alfred.tileSize * nightVisionMultiplier,
          color: gameStateController.state.currentPlanet?.gasVariant?.fogColor
                  .withOpacity(0.1) ??
              gameStateController.state.currentPlanet?.gasVariant?.fogColor
                  .withOpacity(0.1) ??
              Colors.blueGrey[900]!.withOpacity(0.1),
          blurBorder: nightVisionMultiplier * Alfred.tileSize,
        ),
      );
    } else {
      setupLighting(
        LightingConfig(
          radius: Alfred.tileSize * nightVisionMultiplier,
          color: Colors.white.withOpacity(0.01),
          blurBorder: nightVisionMultiplier * Alfred.tileSize,
        ),
      );
    }
  }

  @override
  void die() {
    super.die();
  }

  @override
  void render(Canvas canvas) {
    // do anything
    // print(countDownSeconds);
    // if (countDownSeconds != null) {
    //   textPaint.render(
    //     canvas,
    //     // 'adsfsaf',
    //     countDownSeconds.toString().toUpperCase(),
    //     Vector2(
    //       position.x - 100,
    //       position.y - 100,
    //     ),
    //     anchor: Anchor.bottomCenter,
    //   );
    // }
    super.render(canvas);
  }
}

class PlayerController extends StateController<Player> {
  asy.Timer? dayCycleTimer;

  @override
  void onReady(Player component) {
    component.toggleLighting(true);
    super.onReady(component);
    handleDayTimeCycle(component);
  }

  @override
  void onRemove(Player component) {
    // TODO: implement onRemove
    dayCycleTimer?.cancel();
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

  void handleDayTimeCycle(Player player) {
    dayCycleTimer = asy.Timer.periodic(
        Duration(
          seconds:
              gameStateController.state.currentPlanet?.dayDurationInSeconds ??
                  30,
        ), (timer) {
      switch (gameStateController.state.dayTimeType) {
        case DayTimeType.day:
          player.toggleLighting(true);
          gameRef.lighting?.animateToColor(
            gameStateController.state.currentPlanet?.gasVariant?.fogColor
                    .withOpacity(0.8) ??
                gameStateController.state.currentPlanet?.gasVariant?.fogColor
                    .withOpacity(0.8) ??
                Colors.blueGrey[900]!.withOpacity(0.8),
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
          player.toggleLighting(true);
          gameRef.lighting?.animateToColor(
            gameStateController.state.currentPlanet?.gasVariant?.fogColor ??
                gameStateController.state.currentPlanet?.gasVariant?.fogColor ??
                Colors.blueGrey[900]!,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 3),
          );
          gameStateController.emit(
            gameStateController.state.copyWith(dayTimeType: DayTimeType.night),
          );
          break;
        case DayTimeType.night:
          player.toggleLighting(false);
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
          player.toggleLighting(false);
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
