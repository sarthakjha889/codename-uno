import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';

class MapBoundaryTile extends GameDecoration with ObjectCollision {
  MapBoundaryTile(Vector2 tilePosition)
      : super(
          position: tilePosition,
          size: Vector2(Alfred.tileSize.toDouble(), Alfred.tileSize.toDouble()),
        ) {
    position = tilePosition;
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size:
                Vector2(Alfred.tileSize.toDouble(), Alfred.tileSize.toDouble()),
          ),
        ],
      ),
    );
  }
}
