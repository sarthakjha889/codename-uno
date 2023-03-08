import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/characters/player.dart' as lp;
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/main.dart';
import 'package:helpers/helpers.dart';

class Gem extends GameDecoration with Sensor {
  static double multiplier = 0.5;
  Gem(Vector2 position)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            'Coin_Gems/spr_coin_azu.png',
            SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.2,
              textureSize: Vector2(16, 16),
              loop: true,
            ),
          ),
          position: position,
          size: Vector2.all(Alfred.tileSize / 4),
        );

  @override
  int get priority => LayerPriority.MAP + 1;

  @override
  void onContact(GameComponent component) {
    // do anything with the Component that take contact
    if (component is Player) {
      BonfireInjector().get<lp.PlayerController>().incrementGemCount();
      removeFromParent();
    }
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
