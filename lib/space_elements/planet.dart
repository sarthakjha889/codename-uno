import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class Planet extends GameDecoration with Lighting, ObjectCollision, Movement {
  final String spritesheetPath;
  late double orbitAngle;
  late Vector2 mapCenter;
  final Vector2 planetSize;
  final String name;
  double starDistance;
  double revolutionSpeed;

  TextPaint textPaint = TextPaint(
      style: const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ));

  Planet(
    Vector2 position, {
    required this.spritesheetPath,
    required this.starDistance,
    required this.revolutionSpeed,
    required this.planetSize,
    required this.name,
  }) : super.withAnimation(
          animation: SpriteAnimation.load(
            spritesheetPath,
            SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.15,
              textureSize: Vector2(128, 128),
              amountPerRow: 4,
            ),
          ),
          position: position,
          size: planetSize,
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
    orbitAngle = orbitAngle + revolutionSpeed * dt;
    position = Vector2(
      mapCenter.x + starDistance * cos(orbitAngle),
      mapCenter.y + starDistance * sin(orbitAngle),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPaint.render(
      canvas,
      name.toUpperCase(),
      Vector2(
        position.x + ((planetSize.x / 2) + (name.length * 0.5)),
        position.y + planetSize.y + 30,
      ),
      anchor: Anchor.bottomCenter,
    );
  }
}
