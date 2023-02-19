import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/solar_system.dart';
import 'package:game_test_bonfire/objects/dec_test.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/bush.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/flower.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/grass.dart';
import 'package:game_test_bonfire/objects/decor/outdoor/tree.dart';
import 'package:game_test_bonfire/space_elements/planet.dart';
import 'dart:ui' as ui;
import 'package:game_test_bonfire/objects/enemy.dart';
import 'package:game_test_bonfire/objects/player.dart';
import 'package:game_test_bonfire/space_elements/star.dart';
import 'package:helpers/helpers.dart';

GameController gameController = GameController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void print2dList(e) {
    print('\n');
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    List<List<double>> test = Alfred.generateNoiseMap(
      size: Alfred.mapSize,
      frequency: 0.1,
      gain: 0.1,
    );
    Alfred.getForestDecorations(mapSize: Alfred.mapSize);
    Knight player = Knight(Vector2(
      (Alfred.mapSize / 2 * Alfred.tileSize) + 400,
      (Alfred.mapSize / 2 * Alfred.tileSize) + 400,
    ));
    SolarSystem system1 = SolarSystem();
    return BonfireWidget(
      lightingColorGame: Colors.white.withOpacity(0.01),
      overlayBuilderMap: {
        'miniMap': (context, game) => MiniMap(
              game: game,
              zoom: 0.3,
              margin: EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(10),
              size: Vector2.all(100),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              // backgroundColor: Color(),
              // tileCollisionColor: Color(),
              // tileColor: Color(),
              // playerColor: Color(),
              // enemyColor: Color(),
              // npcColor: Color(),
              // allyColor: Color(),
              // decorationColor: Color(),
            ),
      },
      decorations: system1.getSystem(),
      // decorations: [
      //   Star(
      //     Alfred.getMapCenter(),
      //     spritesheetPath: "planets/Suns/Yellow Sun/spritesheet.png",
      //   ),
      //   Planet(
      //     Alfred.getMapCenter(),
      //     name: 'Earth',
      //     planetSize: Vector2(192, 192),
      //     revolutionSpeed: 0.02,
      //     starDistance: (2 * Alfred.tileSize).toDouble(),
      //     spritesheetPath: "planets/Solid/Tropical/spritesheet.png",
      //   ),
      //   Planet(
      //     Alfred.getMapCenter(),
      //     name: 'Volkan',
      //     planetSize: Vector2(128, 128),
      //     revolutionSpeed: 0.03,
      //     starDistance: (4 * Alfred.tileSize).toDouble(),
      //     spritesheetPath: "planets/Solid/Magma/spritesheet.png",
      //   ),
      //   Planet(
      //     Alfred.getMapCenter(),
      //     name: 'Oseania',
      //     planetSize: Vector2(256, 256),
      //     revolutionSpeed: 0.01,
      //     starDistance: (6 * Alfred.tileSize).toDouble(),
      //     spritesheetPath: "planets/Solid/Ocean/spritesheet.png",
      //   ),
      // ],
      // decorations: Alfred.getForestDecorations(mapSize: mapSize),
      initialActiveOverlays: [
        'miniMap',
      ],
      joystick: Joystick(
        directional: JoystickDirectional(isFixed: false),
      ),
      player: player,
      // enemies: List.generate(
      //   5,
      //   (index) => MyEnemy(Vector2(((index * 50) + 50), ((index * 50) + 50))),
      // ),

      cameraConfig: CameraConfig(
        moveOnlyMapArea: false,
        target: player,
        sizeMovementWindow: Vector2(50, 50),
        zoom: 0.4,
      ),
      gameController: gameController,
      // decorations: [
      //   ...List.generate(
      //     999,
      //     (index) => BushDecoration(
      //       Vector2(
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //       ),
      //     ),
      //   ),
      //   ...List.generate(
      //     999,
      //     (index) => TreeDecoration(
      //       Vector2(
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //       ),
      //     ),
      //   ),
      //   ...List.generate(
      //     999,
      //     (index) => FlowerDecoration(
      //       Vector2(
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //       ),
      //     ),
      //   ),
      //   ...List.generate(
      //     999,
      //     (index) => GrassDecoration(
      //       Vector2(
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //         Alfred.getRandomNumber(max: mapSize * 64, min: 0),
      //       ),
      //     ),
      //   ),
      // ],

      map: MatrixMapGenerator.generate(
        axisInverted: true,
        matrix: test,
        builder: (ItemMatrixProperties prop) {
          TileModelSprite? sprite = TileModelSprite(
            path: 'space/Space_Stars2.png',
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
