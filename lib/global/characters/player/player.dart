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
  double nightVisionMultiplier = 3;
  int? countDownSeconds;
  JoystickMoveDirectional _lastDirection = JoystickMoveDirectional.IDLE;

  @override
  PlayerController get controller => BonfireInjector().get<PlayerController>();

  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );

  PlayerCharacter(Vector2 position)
      : super(
          position: position,
          size: Vector2(128, 128),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 1000,
          life: 2000,
        ) {
    dPadAngles = false;

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
    asy.Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (attackCount++ < maxAttackLimit) {
        if (angle > 360) {
          angle = 0;
        }
        execRangeAttack(
          Alfred.getRandomNumber(min: 100, max: 999).toDouble(),
          angle: angle++,
          speed: speed * 10,
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
      size: Vector2.all(width * 0.7),
      damage: damage,
      speed: speed ?? this.speed * 10,
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
