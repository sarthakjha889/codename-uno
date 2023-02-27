import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class FlowerDecoration extends GameDecoration {
  static double multiplier = 0.5;
  FlowerDecoration(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            getAsset(),
            SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.2,
              textureSize: Vector2(512, 512),
            ),
          ),
          position: position,
          size: Vector2(
            (Alfred.tileSize * multiplier).toDouble(),
            (Alfred.tileSize * multiplier).toDouble(),
          ),
        );

  static String getAsset() {
    return 'terrain/sprites/flower_${Alfred.getRandomNumber(min: 2, max: 4).toInt()}_sprite.png';
  }

  @override
  int get priority => LayerPriority.MAP + 1;

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
