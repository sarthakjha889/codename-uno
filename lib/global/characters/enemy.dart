import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/characters/player/player_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/objects/gem.dart';
import 'package:game_test_bonfire/global/objects/map_boundary_tile.dart';

class EnemySpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "enemy/goblin_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "enemy/goblin_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "enemy/goblin_run_right.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "enemy/goblin_run_left.png",
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

class MyEnemy extends SimpleEnemy with ObjectCollision, UseBarLife {
  PlayerController playerController = BonfireInjector().get<PlayerController>();
  int minAttack = 10;
  int maxAttack = 100;
  double attackMultiplier = 1;
  double visionMultiplier = 15;
  double currentSize = 128;
  double sizeMultiplier = 1;

  MyEnemy(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(128),
          life: 1000,
          speed: 400,
        ) {
    /// here we configure collision of the enemy
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(size.x / 2, size.y / 2),
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
    handleLightingUpdates();
    playerController.addListener(handleLightingUpdates);
  }

  void handleLightingUpdates() {
    switch (playerController.currentDayTimeType) {
      case DayTimeType.day:
        attackMultiplier = 1;
        sizeMultiplier = 1;
        break;
      case DayTimeType.evening:
        attackMultiplier = 1.2;
        sizeMultiplier = 1.2;
        break;
      case DayTimeType.night:
        attackMultiplier = 1.5;
        sizeMultiplier = 1.5;
        break;
      default:
    }
    size = Vector2.all(currentSize * sizeMultiplier);
  }

  @override
  void receiveDamage(attacker, damage, identify) {
    /// Called when the enemy receive damage
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

  void attackMelee() {
    simpleAttackMelee(
      damage: Alfred.getRandomNumber(
        min: (minAttack * attackMultiplier).toInt(),
        max: (maxAttack * attackMultiplier).toInt(),
      ).toDouble(),
      size: size,
    );
  }

  @override
  void die() {
    gameRef.add(Gem(position));
    removeFromParent();

    /// Called when the enemy die
    super.die();
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    super.onCollision(component, active);
    return ![MapBoundaryTile].contains(component.runtimeType);
  }

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
      closePlayer: (player) {
        attackMelee();
      },
      radiusVision: Alfred.tileSize * visionMultiplier,
    );
    super.update(dt);
  }
}
