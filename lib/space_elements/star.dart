import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class Star extends GameDecoration with Lighting, ObjectCollision {
  final String spritesheetPath;
  final Color lightiningColor;

  Star(
    Vector2 position, {
    required this.spritesheetPath,
    required this.lightiningColor,
  }) : super.withAnimation(
          animation: SpriteAnimation.load(
            spritesheetPath,
            SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.1,
              textureSize: Vector2(128, 128),
              amountPerRow: 4,
            ),
          ),
          position: position,
          size: Vector2(256, 256),
        ) {
    setupLighting(
      LightingConfig(
        radius: 200,
        color: lightiningColor,
        withPulse: true,
      ),
    );
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(size: Vector2(256, 256)),
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
