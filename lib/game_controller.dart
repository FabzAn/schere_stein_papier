import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schere_stein_papier/action_selection.dart';
import 'package:schere_stein_papier/board.dart';

enum GameAction {
  schere,
  stein,
  papier;

  String get emoji => switch (this) {
        schere => "✌️🏻",
        stein => "✊🏻",
        papier => "✋🏻",
      };

  /// Returns 1 for win, 0 for draw, -1 for loss
  int compareTo(GameAction other) {
    switch (this) {
      case schere:
        return switch (other) {
          schere => 0,
          stein => -1,
          papier => 1,
        };
      case stein:
        return switch (other) {
          schere => 1,
          stein => 0,
          papier => -1,
        };
      case papier:
        return switch (other) {
          schere => -1,
          stein => 1,
          papier => 0,
        };
    }
  }
}

class GameState {
  int computerScore = 0;
  int playerScore = 0;
  GameAction? computerAction;
  GameAction? playerAction;
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
    int result = playerAction.compareTo(computerAction);

    setState(() {
      if (result == -1) {
        _gameState.computerScore++;
      } else if (result == 1) {
        _gameState.playerScore++;
      }

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
