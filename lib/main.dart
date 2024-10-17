import 'package:flutter/material.dart';
import 'package:schere_stein_papier/action_selection.dart';
import 'package:schere_stein_papier/board.dart';
import 'package:schere_stein_papier/game_controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Schere Stein Papier'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Board(
          gameState: GameState(),
        ),
        ActionSelection(
          onScherePressed: () => print("test schere"),
          onSteinPressed: () => print("test stein"),
          onPapierPressed: () => print("test papier"),
        )
      ]),
    );
  }
}
