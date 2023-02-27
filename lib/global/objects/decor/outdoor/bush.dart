import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class BushDecoration extends GameDecoration {
  static double multiplier = 0.5;
  BushDecoration(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            'terrain/sprites/bush.png',
            SpriteAnimationData.sequenced(
              amount: 2,
              stepTime: 0.2,
              textureSize: Vector2(407, 230),
            ),
          ),
          position: position,
          size: Vector2(
            (Alfred.tileSize * multiplier).toDouble() +
                ((Alfred.tileSize * multiplier) / 2),
            (Alfred.tileSize * multiplier).toDouble(),
          ),
        );
  static String getAsset() {
    return 'terrain/sprites/Bush - ${Alfred.getRandomNumber(min: 1, max: 2).toInt()}.png';
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
