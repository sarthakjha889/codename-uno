import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/characters/enemy.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'dart:async' as asy;
import 'package:collection/collection.dart';
import 'package:game_test_bonfire/global/objects/gem.dart';

import 'package:game_test_bonfire/main.dart';
import 'package:helpers/helpers.dart';

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

  static Future<SpriteAnimation> get whiteAttackEffectRight =>
      SpriteAnimation.load(
        "player/atack_effect_bottom.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get fireBallRight => SpriteAnimation.load(
        "player/fireball_right.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallLeft => SpriteAnimation.load(
        "player/fireball_left.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallBottom => SpriteAnimation.load(
        "player/fireball_bottom.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get fireBallTop => SpriteAnimation.load(
        "player/fireball_top.png",
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  static Future<SpriteAnimation> get explosionAnimation => SpriteAnimation.load(
        "player/explosion_fire.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Player extends SimplePlayer
    with
        ObjectCollision,
        Lighting,
        UseStateController<PlayerController>,
        UseBarLife {
  double nightVisionMultiplier = 3;
  int? countDownSeconds;

  TextPaint textPaint = TextPaint(
      style: const TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ));

  Player(Vector2 position)
      : super(
          position: position,
          size: Vector2(128, 128),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 1000,
          life: 2000,
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
    setupBarLife(
      backgroundColor: Colors.black,
      barLifePosition: BarLifePorition.bottom,
      borderRadius: BorderRadius.circular(8),
      showLifeText: false,
      colors: [Colors.red, Colors.orange, Colors.green],
      size: Vector2(size.x / 2, 10),
      borderColor: Colors.black,
    );
  }

  toggleLighting(bool enable) {
    if (enable) {
      setupLighting(
        LightingConfig(
          radius: Alfred.tileSize * nightVisionMultiplier,
          color: Colors.black.withOpacity(0.1),
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
  void joystickAction(JoystickActionEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) {
      return;
    }
    if (hasController) {
      if (event.event == ActionEvent.DOWN) {
        if (event.id == 'attack-range' && gameRef.livingEnemies().isNotEmpty) {
          execRangeAttack(
              Alfred.getRandomNumber(min: 100, max: 500).toDouble());
        }
        if (event.id == 'attack-melee') {
          execMeleeAttack(
            Alfred.getRandomNumber(min: 100, max: 500).toDouble(),
          );
        }
      }
    }
    super.joystickAction(event);
  }

  void execMeleeAttack(double attack) {
    simpleAttackMelee(
      damage: attack,
      animationRight: PlayerSpriteSheet.whiteAttackEffectRight,
      size: Vector2.all(128),
      centerOffset: Vector2.zero(),
    );
  }

  void execRangeAttack(double damage) {
    List<Enemy> enemies = gameRef.livingEnemies().sortedByCompare(
        (element) => element.position,
        (a, b) => (a.distanceTo(position) - b.distanceTo(position)).toInt());

    simpleAttackRangeByAngle(
      attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
      animation: PlayerSpriteSheet.fireBallRight,
      animationDestroy: PlayerSpriteSheet.explosionAnimation,
      angle: enemies.firstOrNull?.getInverseAngleFromPlayer() ??
          Alfred.getRandomNumber(min: 0, max: 360).toDouble(),
      size: Vector2.all(width * 0.7),
      damage: damage,
      speed: speed * 10,
      marginFromOrigin: 100,
      lightingConfig: LightingConfig(
        radius: width / 2,
        blurBorder: width,
        color: Colors.orange.withOpacity(0.3),
      ),
    );
  }

  @override
  @override
  void receiveDamage(attacker, damage, identify) {
    /// Called when the enemy receive damage
    showDamage(
      damage,
      onlyUp: true,
      config: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
        fontSize: 40,
      ),
    );
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void die() {
    removeFromParent();
    // gameRef.pauseEngine();
    super.die();
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(
      canvas,
      '${gameStateController.state.collectedGems.toString()} gems',
      Vector2(
        position.x + 60,
        position.y + 200,
      ),
      anchor: Anchor.bottomCenter,
    );
    super.render(canvas);
  }
}

class PlayerController extends StateController<Player> {
  asy.Timer? dayCycleTimer;
  final int maxEnemies = 99;
  int currentEnemies = 0;
  asy.Timer? enemySpawnTimer;
  Player? player;
  asy.Timer? rangeAttackTimer;

  @override
  void onReady(Player component) {
    player = component;
    currentEnemies = 0;
    component.toggleLighting(true);
    super.onReady(component);
    handleDayTimeCycle();
    spawnEnemiesHandler();
    rangeAttackTimer = asy.Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (gameRef.livingEnemies().isNotEmpty) {
        component.execRangeAttack(
            Alfred.getRandomNumber(min: 100, max: 999).toDouble());
      }
    });
  }

  @override
  void onRemove(Player component) {
    // TODO: implement onRemove
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
