import 'dart:ui';

import 'package:bonfire/bonfire.dart';

class MyCustomDecoration extends GameDecoration with ObjectCollision {
  MyCustomDecoration(
    Vector2 position,
    String asset,
    Vector2 size,
  ) : super.withSprite(
          sprite: Sprite.load(asset),
          size: size,
          position: position,
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
