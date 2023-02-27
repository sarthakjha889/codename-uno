import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class GrassDecoration extends GameDecoration {
  static double multiplier = 1.1;
  GrassDecoration(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            'terrain/sprites/grass_spritesheet.png',
            SpriteAnimationData.sequenced(
              amount: 3,
              stepTime: 0.1,
              textureSize: Vector2(388, 388),
            ),
          ),
          position: position,
          size: Vector2(
            (Alfred.tileSize * multiplier).toDouble(),
            (Alfred.tileSize * multiplier).toDouble(),
          ),
        );

  static String getAsset() {
    return 'terrain/sprites/Grass - ${Alfred.getRandomNumber(min: 1, max: 4).toInt()}.png';
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
