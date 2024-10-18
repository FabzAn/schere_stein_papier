import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schere_stein_papier/action_selection.dart';
import 'package:schere_stein_papier/board.dart';

enum GameResult { win, loss, draw }

enum GameAction {
  schere,
  stein,
  papier;

  String get emoji => switch (this) {
        schere => "✌️🏻",
        stein => "✊🏻",
        papier => "✋🏻",
      };

  GameResult compareTo(GameAction other) => switch ((this, other)) {
        (schere, papier) ||
        (stein, schere) ||
        (papier, stein) =>
          GameResult.win,
        (schere, stein) ||
        (stein, papier) ||
        (papier, schere) =>
          GameResult.loss,
        (schere, schere) ||
        (stein, stein) ||
        (papier, papier) =>
          GameResult.draw,
      };
}

class GameState {
  int computerScore = 0;
  int playerScore = 0;
  GameAction? computerAction;
  GameAction? playerAction;
  GameResult? lastGame;
}

class GameWidget extends StatefulWidget {
  final Random random;

  GameWidget({super.key, Random? random}) : random = random ?? Random();

  @override
  State<GameWidget> createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {
  final GameState _gameState = GameState();

  GameAction _pickAction() {
    return switch (widget.random.nextInt(3)) {
      0 => GameAction.schere,
      1 => GameAction.stein,
      2 => GameAction.papier,
      _ => throw ArgumentError("int out of range"),
    };
  }

  void _play(GameAction playerAction) {
    GameAction computerAction = _pickAction();
    GameResult result = playerAction.compareTo(computerAction);

    setState(() {
      if (result == GameResult.loss) {
        _gameState.computerScore++;
      } else if (result == GameResult.win) {
        _gameState.playerScore++;
      }

      _gameState.lastGame = result;
      _gameState.playerAction = playerAction;
      _gameState.computerAction = computerAction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Board(
        gameState: _gameState,
      ),
      ActionSelection(
        onScherePressed: () => _play(GameAction.schere),
        onSteinPressed: () => _play(GameAction.stein),
        onPapierPressed: () => _play(GameAction.papier),
      )
    ]);
  }
}
