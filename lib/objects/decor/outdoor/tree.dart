import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class TreeDecoration extends GameDecoration with ObjectCollision {
  TreeDecoration(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load(getAsset()),
          position: position,
          size: Vector2(128, 128),
        ) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(64, 64),
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
