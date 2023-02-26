import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class TreeDecoration extends GameDecoration with ObjectCollision {
  static const double multiplier = 1.25;
  TreeDecoration(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load(getAsset()),
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

  static String getAsset() {
    return 'terrain/sprites/Tree_${Alfred.getRandomNumber(min: 1, max: 2).toInt()} - ${Alfred.getRandomNumber(min: 1, max: 4).toInt()}.png';
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
