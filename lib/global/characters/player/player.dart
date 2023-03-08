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
          (a, b) => (a.distanceTo(position) - b.distanceTo(position)).toInt(),
        );

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
