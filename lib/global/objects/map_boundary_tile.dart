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
      if (side != MapBoundarySide.none &&
          BonfireInjector.instance.get<PlayerController>().canChangePlanetMap) {
        List<List<double>> rawMap =
            BonfireInjector.instance.get<PlayerController>().currentMap;
        List<List<String>> matrixMap = List.generate(rawMap.length,
            (index) => List.generate(rawMap.length, (index) => 'L'));
        for (int i = 0; i < rawMap.length; i++) {
          for (int j = 0; j < rawMap.length; j++) {
            matrixMap[i][j] = matrixMappingToMap[rawMap[i][j]] ?? 'L';
          }
        }
        switch (side) {
          case MapBoundarySide.top:
            Alfred.pushNewLevel(
              context: context,
              destination: PlanetSurface(bottomEdge: matrixMap.first),
            );
            break;
          case MapBoundarySide.bottom:
            Alfred.pushNewLevel(
              context: context,
              destination: PlanetSurface(topEdge: matrixMap.last),
            );
            break;
          case MapBoundarySide.left:
            List<String> edge = matrixMap.map((e) => e.first).toList();
            Alfred.pushNewLevel(
              context: context,
              destination: PlanetSurface(rightEdge: edge),
            );
            break;
          case MapBoundarySide.right:
            List<String> edge = matrixMap.map((e) => e.last).toList();
            Alfred.pushNewLevel(
              context: context,
              destination: PlanetSurface(leftEdge: edge),
            );
            break;
          default:
        }

        BonfireInjector.instance
            .get<PlayerController>()
            .resetPlayerCanChangePlanetMap();
      }
    }
  }
}
