import 'dart:math';
import 'dart:async' as asy;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/characters/player/player_controller.dart';
import 'package:game_test_bonfire/global/characters/player/player_spritesheet.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:collection/collection.dart';

class PlayerCharacter extends SimplePlayer
    with
        ObjectCollision,
        Lighting,
        UseStateController<PlayerController>,
        UseBarLife {
  // TextPaint to render text on hit
  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );

  //
  JoystickMoveDirectional _lastDirection = JoystickMoveDirectional.IDLE;

  int movementSpeed = 500;
  int rangedAttackInterval = 2000;
  int rangedAttackSpeed = 1000;
  double maxRangedAttackSpeed = 3000;

  double nightVisionMultiplier = 2;
  double movementSpeedMultiplier = 1;
  double rangedAttackSpeedMultiplier = 1;
  double rangedAttackIntervalMultiplier = 1;

  PlayerCharacter(Vector2 position)
      : super(
          position: position,
          size: Vector2(128, 128),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 1,
          life: 5000,
        ) {
    dPadAngles = false;
    setPlayerMovementSpeed();
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(size.x / 3, size.y / 3),
            align: Vector2(size.x / 3, size.y / 3),
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

  void setPlayerMovementSpeed() {
    speed = movementSpeedMultiplier * movementSpeed;
  }

  double getPlayerRangedAttackSpeed() {
    return rangedAttackSpeedMultiplier + rangedAttackSpeed;
  }

  toggleLighting(bool enable) {
    if (enable) {
      setupLighting(
        LightingConfig(
          radius: min(Alfred.tileSize * nightVisionMultiplier,
              MediaQuery.of(context).size.shortestSide),
          color: Colors.black.withOpacity(0.1),
          blurBorder: nightVisionMultiplier * Alfred.tileSize,
        ),
      );
    } else {
      setupLighting(
        LightingConfig(
          radius: min(Alfred.tileSize * nightVisionMultiplier,
              MediaQuery.of(context).size.shortestSide),
          color: Colors.white.withOpacity(0.01),
          blurBorder: nightVisionMultiplier * Alfred.tileSize,
        ),
      );
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (_lastDirection != event.directional) {
      switch (event.directional) {
        case JoystickMoveDirectional.IDLE:
          if ([
            JoystickMoveDirectional.MOVE_DOWN_LEFT,
            JoystickMoveDirectional.MOVE_LEFT,
            JoystickMoveDirectional.MOVE_UP_LEFT
          ].contains(_lastDirection)) {
            animation?.play(SimpleAnimationEnum.idleLeft);
          }
          if ([
            JoystickMoveDirectional.MOVE_DOWN_RIGHT,
            JoystickMoveDirectional.MOVE_RIGHT,
            JoystickMoveDirectional.MOVE_UP_RIGHT
          ].contains(_lastDirection)) {
            animation?.play(SimpleAnimationEnum.idleRight);
          }
          break;
        case JoystickMoveDirectional.MOVE_LEFT:
          animation?.play(SimpleAnimationEnum.runLeft);
          break;
        case JoystickMoveDirectional.MOVE_RIGHT:
          animation?.play(SimpleAnimationEnum.runRight);
          break;
        case JoystickMoveDirectional.MOVE_DOWN:
          animation?.play(SimpleAnimationEnum.runRight);
          break;
        case JoystickMoveDirectional.MOVE_DOWN_LEFT:
          animation?.play(SimpleAnimationEnum.runLeft);
          break;
        case JoystickMoveDirectional.MOVE_DOWN_RIGHT:
          animation?.play(SimpleAnimationEnum.runRight);
          break;
        case JoystickMoveDirectional.MOVE_UP_LEFT:
          animation?.play(SimpleAnimationEnum.runLeft);
          break;
        case JoystickMoveDirectional.MOVE_UP_RIGHT:
          animation?.play(SimpleAnimationEnum.runRight);
          break;
        default:
      }
    }
    _lastDirection = event.directional;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) {
      return;
    }
    if (hasController) {
      if (event.event == ActionEvent.DOWN) {
        if (event.id == 'attack-range' && gameRef.livingEnemies().isNotEmpty) {
          execRangeSpecialAttack();
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

  void execRangeSpecialAttack() {
    int attackCount = 0;
    int maxAttackLimit = 100;
    controller.shouldAutoRangeAttack = false;
    double angle = 0;
    asy.Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (attackCount++ < maxAttackLimit) {
        if (angle > 360) {
          angle = 0;
        }
        execRangeAttack(
          Alfred.getRandomNumber(min: 100, max: 999).toDouble(),
          angle: angle++,
          speed: rangedAttackSpeedMultiplier * rangedAttackSpeed * 3,
        );
      } else {
        controller.shouldAutoRangeAttack = true;
        timer.cancel();
      }
    });
  }

  void execRangeAttack(
    double damage, {
    double? angle,
    double? speed,
  }) {
    List<Enemy> enemies = gameRef.livingEnemies().sortedByCompare(
          (element) => element.position,
          (a, b) => (a.distanceTo(position) - b.distanceTo(position)).toInt(),
        );
    simpleAttackRangeByAngle(
      attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
      animation: PlayerSpriteSheet.fireBallRight,
      animationDestroy: PlayerSpriteSheet.explosionAnimation,
      angle: angle ??
          enemies.firstOrNull?.getInverseAngleFromPlayer() ??
          Alfred.getRandomNumber(min: 0, max: 360).toDouble(),
      size: Vector2.all(width),
      damage: damage,
      marginFromOrigin: ((gameRef.player?.size.x ?? 144) / 3),
      collision: CollisionConfig(
        collisions: [
          CollisionArea.circle(
            radius: width * 0.2,
            align: Vector2((width * 0.7) / 4, (width * 0.7) / 4),
          ),
        ],
      ),
      speed: min(maxRangedAttackSpeed, speed ?? getPlayerRangedAttackSpeed()),
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
    showDamage(
      damage,
      onlyUp: true,
      config: const TextStyle(
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
    gameRef.lighting?.animateToColor(Colors.red.withOpacity(0.5));
    super.die();
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(
      canvas,
      '${controller.gemCount.toString()} gems',
      Vector2(
        position.x + 60,
        position.y + 200,
      ),
      anchor: Anchor.bottomCenter,
    );
    super.render(canvas);
  }
}
