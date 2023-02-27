// import 'package:bonfire/bonfire.dart';

import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test_bonfire/global/characters/player.dart' as p;
import 'package:game_test_bonfire/global/controller/game_state_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/galaxy_map.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/main.dart';

class PlanetSurface extends StatefulWidget {
  const PlanetSurface({super.key});

  @override
  State<PlanetSurface> createState() => _PlanetSurfaceState();
}

class _PlanetSurfaceState extends State<PlanetSurface> {
  @override
  void initState() {
    BonfireInjector().put((i) => p.PlayerController());

    super.initState();
    gameStateController.handlePlanetSurfaceStart();
  }

  @override
  Widget build(BuildContext context) {
    p.Player player = p.Player(Alfred.getMapCenter());
    GameController gameController = GameController();

    return BlocBuilder<GameStateController, GameState>(
      bloc: gameStateController,
      builder: (context, state) {
        return BonfireWidget(
          lightingColorGame: state.dayTimeType == DayTimeType.night
              ? Colors.blueGrey[900]
              : state.dayTimeType == DayTimeType.evening
                  ? Colors.black.withOpacity(0.8)
                  : Colors.transparent,
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
                        builder: (context) => const GalaxyMap(),
                      ),
                    );
                  },
                  child: const Text('Open map'),
                ),
          },
          decorations: Alfred.getForestDecorations(),
          initialActiveOverlays: const [
            'miniMap',
            'mapView',
          ],
          joystick: Joystick(
            directional: JoystickDirectional(isFixed: false),
          ),
          player: player,
          cameraConfig: CameraConfig(
            moveOnlyMapArea: true,
            angle: 45 * pi / 180,
            target: player,
            sizeMovementWindow: Vector2(50, 50),
            zoom: 0.5,
          ),
          gameController: gameController,
          map: MatrixMapGenerator.generate(
            matrix: Alfred.generateNoiseMap(
              size: Alfred.mapSize,
              frequency: 0.08,
              gain: 0.3,
            ),
            builder: (ItemMatrixProperties prop) {
              TileModelSprite? sprite = TileModelSprite(
                path: 'terrain/tiles/dirt_lighted_rocks.png',
              );
              if (prop.value > 0 && prop.value < 0.1) {
                sprite = TileModelSprite(
                  path: 'terrain/tiles/Grass_normal.png',
                );
              } else if (prop.value >= 0.1 && prop.value < 0.23) {
                sprite = TileModelSprite(
                  path: 'terrain/tiles/Grass_darked.png',
                );
              } else if (prop.value <= 0 && prop.value > -0.1) {
                sprite = TileModelSprite(
                  path: 'terrain/tiles/Grass_normal.png',
                );
              } else if (prop.value <= -0.1 && prop.value > -0.3) {
                sprite = TileModelSprite(
                  path: 'terrain/tiles/Grass_lighted.png',
                );
              } else if (prop.value <= -0.3) {
                sprite = TileModelSprite(
                  path: 'terrain/tiles/dirt_lighted_rocks.png',
                );
              }
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
      },
    );
  }
}
