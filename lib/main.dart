import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:game_test_bonfire/global/controller/game_state_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/solar_system.dart';
import 'package:game_test_bonfire/objects/player.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

GameController gameController = GameController();
GameStateController gameStateController = GameStateController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
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
    SolarSystem system1 =
        SolarSystem(solarSystemData: gameStateController.getSolarSystemData());
    return BlocBuilder<GameStateController, GameState>(
        bloc: gameStateController,
        builder: (context, state) {
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
            decorations: system1.getDecorations(),
            initialActiveOverlays: [
              'miniMap',
            ],
            joystick: Joystick(
              directional: JoystickDirectional(isFixed: false),
            ),
            player: player,
            cameraConfig: CameraConfig(
              moveOnlyMapArea: false,
              target: player,
              sizeMovementWindow: Vector2(50, 50),
              zoom: 0.4,
            ),
            gameController: gameController,
            map: MatrixMapGenerator.generate(
              axisInverted: true,
              matrix: test,
              builder: (ItemMatrixProperties prop) {
                TileModelSprite? sprite = TileModelSprite(
                  path: system1.solarSystemData.backgroundSpritePath,
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
        });
  }
}
