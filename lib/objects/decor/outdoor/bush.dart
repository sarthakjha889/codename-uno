import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class BushDecoration extends GameDecoration {
  BushDecoration(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load(getAsset()),
          position: position,
          size: Vector2(64, 64),
        );

  static String getAsset() {
    return 'terrain/sprites/Bush - ${Alfred.getRandomNumber(min: 1, max: 2).toInt()}.png';
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
