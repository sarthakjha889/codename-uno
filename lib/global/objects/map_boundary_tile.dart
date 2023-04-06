import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/characters/player/player_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/map_gen_test.dart';
import 'package:game_test_bonfire/global/levels/planet_surface.dart';
import 'package:helpers/helpers.dart';

enum MapBoundarySide {
  top,
  left,
  right,
  bottom,
  none,
}

class MapBoundaryTile extends GameDecoration with ObjectCollision, Sensor {
  final MapBoundarySide side;

  MapBoundaryTile(
    Vector2 tilePosition, {
    this.side = MapBoundarySide.none,
  }) : super(
          position: tilePosition,
          size: Vector2(
            Alfred.tileSize.toDouble(),
            Alfred.tileSize.toDouble(),
          ),
        ) {
    position = tilePosition;
    // printLime(side);
    if (side == MapBoundarySide.none) {
      setupCollision(
        CollisionConfig(
          enable: true,
          collisions: [
            CollisionArea.rectangle(
              size: Vector2(
                Alfred.tileSize.toDouble(),
                Alfred.tileSize.toDouble(),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      BonfireInjector.instance
          .get<PlayerController>()
          .changeCurrentMapNode(side, context);
    }
  }
}

class WaterTile extends GameDecoration with ObjectCollision {
  WaterTile(Vector2 tilePosition)
      : super(
          position: tilePosition,
          size: Vector2(
            Alfred.tileSize.toDouble(),
            Alfred.tileSize.toDouble(),
          ),
        ) {
    position = tilePosition;
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              Alfred.tileSize.toDouble(),
              Alfred.tileSize.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is FlyingAttackObject) {
      return false;
    } else {
      return super.onCollision(component, active);
    }
  }
}
