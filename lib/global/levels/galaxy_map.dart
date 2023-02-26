import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_test_bonfire/global/controller/game_state_controller.dart';
import 'package:game_test_bonfire/global/helpers.dart';
import 'package:game_test_bonfire/global/levels/solar_system.dart';
import 'package:game_test_bonfire/global/model/game_state.dart';
import 'package:game_test_bonfire/global/solar_system.dart';
import 'package:game_test_bonfire/main.dart';

class GalaxyMap extends StatefulWidget {
  const GalaxyMap({super.key});

  @override
  State<GalaxyMap> createState() => _GalaxyMapState();
}

class _GalaxyMapState extends State<GalaxyMap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStateController, GameState>(
        bloc: gameStateController,
        builder: (context, state) {
          return Material(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 1000,
                  minHeight: 1000,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 1000,
                      width: 1000,
                      color: Colors.black,
                    ),
                    ...state.galaxy.solarSystems.map(
                      (e) => Positioned(
                        top: e.position.x,
                        left: e.position.y,
                        child: GestureDetector(
                          onTap: () {
                            Alfred.pushNewLevel(
                              context: context,
                              destination: LevelMap(
                                system: SolarSystem(solarSystemData: e),
                              ),
                            );
                          },
                          child: Container(
                            color:
                                Alfred.getRandomValueFromList(Colors.primaries),
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              state.galaxy.solarSystems.indexOf(e).toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
