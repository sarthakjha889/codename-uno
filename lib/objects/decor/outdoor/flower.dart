import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class FlowerDecoration extends GameDecoration with ObjectCollision {
  FlowerDecoration(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load(getAsset()),
          position: position,
          size: Vector2(32, 32),
        ) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.circle(radius: 8),
        ],
      ),
    );
  }

  static String getAsset() {
    return 'terrain/sprites/Flower_${Alfred.getRandomNumber(min: 1, max: 4).toInt()} - ${Alfred.getRandomNumber(min: 1, max: 4).toInt()}.png';
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
