import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/objects/weather/rain.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "player/knight_idle_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "player/knight_idle.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "player/knight_run.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "player/knight_run_left.png",
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Player extends SimplePlayer with ObjectCollision, Lighting {
  double nightVisionMultiplier = 3;
  Player(Vector2 position)
      : super(
          position: position,
          size: Vector2(128, 128),
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          speed: 1000,
        ) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(128, 128),
            align: Vector2(0, 0),
          ),
        ],
      ),
    );
  }

  toggleLighting(bool enable) {
    if (enable) {
      setupLighting(
        LightingConfig(
          radius: Alfred.tileSize * nightVisionMultiplier,
          color: Colors.blue[800]!.withOpacity(0.2),
          blurBorder: nightVisionMultiplier * Alfred.tileSize,
        ),
      );
    } else {
      setupLighting(
        LightingConfig(
          radius: Alfred.tileSize * nightVisionMultiplier,
          color: Colors.white.withOpacity(0.01),
          blurBorder: 40,
        ),
      );
    }
  }
}
