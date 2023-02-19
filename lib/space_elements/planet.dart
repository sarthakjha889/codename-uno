import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/planet_data.dart';

class Planet extends GameDecoration with Lighting, ObjectCollision, Movement {
  late double orbitAngle;
  late Vector2 mapCenter;
  final PlanetData data;

  TextPaint textPaint = TextPaint(
      style: const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ));

  Planet(this.data)
      : super.withAnimation(
          animation: SpriteAnimation.load(
            data.spritesheetPath,
            SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.15,
              textureSize: Vector2(128, 128),
              amountPerRow: 4,
            ),
          ),
          position: data.starPosition,
          size: data.planetSize,
        ) {
    mapCenter = Alfred.getMapCenter();
    anchor = Anchor.center;
    orbitAngle = Random().nextDouble() * 2 * pi;
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.circle(radius: 32),
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    orbitAngle = orbitAngle + data.revolutionSpeed * dt;
    position = Vector2(
      mapCenter.x + data.starDistance * cos(orbitAngle),
      mapCenter.y + data.starDistance * sin(orbitAngle),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPaint.render(
      canvas,
      data.name.toUpperCase(),
      Vector2(
        position.x + ((data.planetSize.x / 2) + (data.name.length * 0.5)),
        position.y + data.planetSize.y + 30,
      ),
      anchor: Anchor.bottomCenter,
    );
  }
}
