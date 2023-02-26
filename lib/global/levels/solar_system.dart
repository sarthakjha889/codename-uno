import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/characters/player_space_ship.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/galaxy_map.dart';
import 'package:game_test_bonfire/global/solar_system.dart';

class LevelMap extends StatelessWidget {
  const LevelMap({
    super.key,
    required this.system,
  });

  final SolarSystem system;

  @override
  Widget build(BuildContext context) {
    PlayerSpaceShip player = PlayerSpaceShip(Vector2(
      (Alfred.mapSize / 2 * Alfred.tileSize) + 400,
      (Alfred.mapSize / 2 * Alfred.tileSize) + 400,
    ));
    GameController gameController = GameController();
    return BonfireWidget(
      lightingColorGame: Colors.white.withOpacity(0.01),
      overlayBuilderMap: {
        'miniMap': (context, game) => MiniMap(
              game: game,
              zoom: 0.3,
              margin: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(10),
              size: Vector2.all(100),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
        'mapView': (context, game) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GalaxyMap(),
                  ),
                );
              },
              child: Text('Open map'),
            ),
      },
      decorations: system.getDecorations(),
      initialActiveOverlays: [
        'miniMap',
        'mapView',
      ],
      joystick: Joystick(
        directional: JoystickDirectional(isFixed: false),
      ),
      player: player,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        target: player,
        sizeMovementWindow: Vector2(50, 50),
        zoom: 0.4,
      ),
      gameController: gameController,
      map: MatrixMapGenerator.generate(
        axisInverted: true,
        matrix: Alfred.generateNoiseMap(
          size: Alfred.mapSize,
          frequency: 0.1,
          gain: 0.1,
        ),
        builder: (ItemMatrixProperties prop) {
          TileModelSprite? sprite = TileModelSprite(
            path: system.solarSystemData.backgroundSpritePath,
          );
          return TileModel(
            x: prop.position.x,
            y: prop.position.y,
            sprite: sprite,
            height: Alfred.tileSize.toDouble(),
            width: Alfred.tileSize.toDouble(),
            // color: Colors.blue, // You could use only color also
          );
        },
      ),
    );
  }
}
