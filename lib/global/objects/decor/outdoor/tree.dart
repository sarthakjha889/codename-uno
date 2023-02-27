import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class TreeDecoration extends GameDecoration with ObjectCollision {
  static const double multiplier = 1.25;
  TreeDecoration(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            getAsset(),
            SpriteAnimationData.sequenced(
              amount: 3,
              stepTime: 0.2,
              textureSize: Vector2(388, 430),
            ),
          ),
          position: position,
          size: Vector2(
            (Alfred.tileSize * multiplier).toDouble(),
            (Alfred.tileSize * multiplier).toDouble(),
          ),
        ) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              Alfred.tileSize / 2,
              Alfred.tileSize / 2,
            ),
            align: Vector2(
              Alfred.tileSize / 2,
              Alfred.tileSize / 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  int get priority => LayerPriority.MAP + 2;

  static String getAsset() {
    return 'terrain/sprites/tree_${Alfred.getRandomNumber(min: 1, max: 2).toInt()}_sprite.png';
  }

  @override
  void update(double dt) {
    // do anything
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // do anything
    super.render(canvas);
  }
}
