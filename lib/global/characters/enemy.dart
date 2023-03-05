import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

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

class MyEnemy extends SimpleEnemy with ObjectCollision {
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
          CollisionArea.rectangle(size: Vector2.all(32)),
        ],
      ),
    );
  }

  @override
  void receiveDamage(AttackFromEnum, double, dynamic) {
    /// Called when the enemy receive damage
    super.receiveDamage(AttackFromEnum, double, dynamic);
  }

  @override
  void die() {
    removeFromParent();

    /// Called when the enemy die
    super.die();
  }

  @override
  void update(double dt) {
    // seeAndMoveToPlayer(

    //   closePlayer: (player) {
    //     positionsItselfAndKeepDistance(
    //       gameRef.player!,
    //       positioned: (p0) {},
    //     );
    //   },
    //   radiusVision: Alfred.tileSize * 10,
    // );
    super.update(dt);
  }
}
