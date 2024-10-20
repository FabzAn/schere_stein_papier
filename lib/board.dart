import 'package:flutter/material.dart';
import 'package:schere_stein_papier/game_controller.dart';

class Board extends StatelessWidget {
  final GameState gameState;

  const Board({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ScoreCard(
                    key: const Key("computerScore"),
                    score: gameState.computerScore),
                _ScoreCard(
                    key: const Key("playerScore"),
                    score: gameState.playerScore),
              ],
            )),
        Expanded(
            child: Column(
          children: [
            _ActionCard(
              action: gameState.computerAction,
            ),
            _ActionCard(
              action: gameState.playerAction,
            ),
          ],
        )),
        Expanded(
            child: Text(switch (gameState.lastGame) {
          GameResult.draw => "Unentschieden",
          GameResult.win => "Gewonnen",
          GameResult.loss => "Verloren",
          _ => "",
        }))
      ],
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final int score;

  const _ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.5,
        child: Text(
          score.toString(),
          style: const TextStyle(fontSize: 22),
        ));
  }
}

class _ActionCard extends StatelessWidget {
  final GameAction? action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: Card(
            elevation: 0.5,
            shape: const RoundedRectangleBorder(),
            child: Center(
                child: Text(
              action?.emoji ?? "",
              style: const TextStyle(fontSize: 42),
            ))));
  }
}
