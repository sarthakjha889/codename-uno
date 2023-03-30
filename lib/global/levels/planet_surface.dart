// import 'package:bonfire/bonfire.dart';

import 'dart:io';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_test_bonfire/global/characters/player/player.dart';
import 'package:game_test_bonfire/global/characters/player/player_controller.dart';
import 'package:game_test_bonfire/global/controller/game_state_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/galaxy_map.dart';
import 'package:game_test_bonfire/global/levels/map_gen_test.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/main.dart';
import 'package:helpers/helpers.dart';

int count = 0;

class PlanetSurface extends StatefulWidget {
  final List<String>? topEdge;
  final List<String>? bottomEdge;
  final List<String>? leftEdge;
  final List<String>? rightEdge;
  final List<List<double>>? mapNode;

  const PlanetSurface({
    super.key,
    this.topEdge,
    this.bottomEdge,
    this.leftEdge,
    this.rightEdge,
    this.mapNode,
  });

  @override
  State<PlanetSurface> createState() => _PlanetSurfaceState();
}

class _PlanetSurfaceState extends State<PlanetSurface> {
  late PlayerController playerController;
  bool isLoading = true;
  late List<List<double>> map;

  @override
  void initState() {
    super.initState();
    handleInit();
  }

  void handleInit() {
    try {
      playerController = BonfireInjector().get<PlayerController>();
    } catch (e) {
      playerController = PlayerController();
      BonfireInjector().put((i) => playerController);
    }
    BonfireInjector().put((i) => GameController());
    map = widget.mapNode ??
        playerController.getPlanetMapNode(
          topEdge: widget.topEdge,
          bottomEdge: widget.bottomEdge,
          leftEdge: widget.leftEdge,
          rightEdge: widget.rightEdge,
        );
    playerController.currentMap = map;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PlayerCharacter player = PlayerCharacter(Alfred.getMapCenter());

    return BlocBuilder<GameStateController, GameState>(
      bloc: gameStateController,
      builder: (context, state) {
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : BonfireWidget(
                lightingColorGame: playerController.currentDayTimeType.lighting,
                // constructionMode: true,
                // collisionAreaColor: Colors.red.withOpacity(0.5),
                // showCollisionArea: true,
                overlayBuilderMap: {
                  'minimap': (context, game) => MiniMap(
                        game: game,
                        zoom: 0.2,
                        margin: const EdgeInsets.all(20),
                        borderRadius: BorderRadius.circular(10),
                        size: Vector2.all(100),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5)),
                      ),
                  'gemCount': (context, game) => Positioned(
                        child: StateControllerConsumer<PlayerController>(
                            builder: (BuildContext context,
                                PlayerController controller) {
                          return Text(
                            controller.gemCount.toString(),
                            style: const TextStyle(fontSize: 42),
                          );
                        }),
                      ),
                  'galaxyMap': (context, game) => Positioned(
                        top: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const GalaxyMap(),
                              ),
                            );
                          },
                          child: const Text('Open map'),
                        ),
                      ),
                },
                decorations: Alfred.getForestDecorationAsPerMap(map),
                initialActiveOverlays: const [
                  'minimap',
                  'gemCount',
                  'galaxyMap',
                ],
                joystick: Joystick(
                  directional: JoystickDirectional(
                    isFixed: false,
                  ),
                  actions: [
                    JoystickAction(
                      actionId: 'attack-range',
                      margin: const EdgeInsets.all(100),
                      color: Colors.red,
                    ),
                    JoystickAction(
                      actionId: 'attack-melee',
                      margin: const EdgeInsets.all(150),
                      color: Colors.yellow,
                    ),
                  ],
                ),
                player: player,
                cameraConfig: CameraConfig(
                  // moveOnlyMapArea: true,
                  setZoomLimitToFitMap: true,
                  angle: 45 * pi / 180,
                  target: player,
                  sizeMovementWindow: Vector2(50, 50),
                  zoom: 0.1,
                  // zoom: MediaQuery.of(context).size.shortestSide > 800
                  //     ? MediaQuery.of(context).size.shortestSide / 1500
                  //     : MediaQuery.of(context).size.shortestSide / 1000,
                ),
                gameController: BonfireInjector().get<GameController>(),
                map: MatrixMapGenerator.generate(
                  matrix: map,
                  axisInverted: true,
                  builder: (ItemMatrixProperties prop) {
                    int value = prop.value.toInt();
                    TileModelSprite? sprite = TileModelSprite(
                      path: 'terrain/tiles/dirt_clay.png',
                    );
                    if (value == 1) {
                      sprite = TileModelSprite(
                        path: 'terrain/tiles/dirt_clay.png',
                      );
                    }
                    if (value == 2) {
                      sprite = TileModelSprite(
                        path: 'terrain/tiles/water.png',
                      );
                    }
                    if (value == 3 || value == 4) {
                      sprite = TileModelSprite(
                        path: 'terrain/tiles/Grass_darked.png',
                      );
                    }
                    if (value == 6) {
                      sprite = TileModelSprite(
                        path: 'terrain/tiles/Grass_overcorrupted.png',
                      );
                    }
                    if (value == 7) {
                      sprite = TileModelSprite(
                        path: 'floor_1.png',
                      );
                    }
                    if (value == 5) {
                      sprite = TileModelSprite(
                        path: 'wall.png',
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
                // onReady: (value) =>
                //     value.addJoystickObserver(LocalJoystickListener()),
              );
      },
    );
  }
}
