import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/controller/game_state_controller.dart';

import 'package:game_test_bonfire/global/levels/solar_system.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/solar_system.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

GameStateController gameStateController = GameStateController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
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
      home: const StartScreen(),
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
  Widget build(BuildContext context) {
    return BlocBuilder<GameStateController, GameState>(
      bloc: gameStateController,
      builder: (context, state) {
        if (!state.isReady) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // return const StartScreen();
          // return PlanetSurface();
          SolarSystem system =
              SolarSystem(solarSystemData: state.currentSolarSystem!);
          return LevelMap(system: system);
        }
      },
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Codename Uno',
            style: TextStyle(
              fontSize: 72,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                child: const Text('Start game'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                  "This project, which was once one of my secondary endeavors, will no longer receive my attention. I initially embarked on this project to explore game engine capabilities in Flutter. Consequently, I developed a small game during my leisure time, utilizing Flutter and Bonfire.\n\nThe game currently includes the following features:\n1. Procedurally generated infinite maps that interconnect with one another. The game retains the memory of previous maps upon revisiting them, and these maps share edges with neighboring maps.\n4. Day-Night cycle. The enemies get bigger and more powerful in the evenings and the nights.\n4. Collect gems dropped after defeating enemies.\n5. Random enemy spawn points.\n6. Distinct ranged and melee attacks.\n\nI had initially planned to incorporate the following elements but did not have the opportunity to do so:\n1. Multiple biomes representing various types of planets, such as lava worlds, water worlds, and so on.\n2. Discoverable dungeons and one-of-a-kind maps.\n3. A diverse range of enemy types, including bosses and a system for generating unique adversaries."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('About this game'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Instructions:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  '~ Use WASD or arrow keys to move around.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '~ Touch a planet to visit the planet surface.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '~ Press Space to trigger the special ranged attack.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '~ Press Enter to trigger a melee attack.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '~ You can visit different solar systems via the Galaxy map button',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
