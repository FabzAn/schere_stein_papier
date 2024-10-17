import 'package:flutter/material.dart';
import 'package:schere_stein_papier/game_controller.dart';

class ActionSelection extends StatelessWidget {
  final VoidCallback onScherePressed;
  final VoidCallback onSteinPressed;
  final VoidCallback onPapierPressed;

  const ActionSelection(
      {super.key,
      required this.onScherePressed,
      required this.onSteinPressed,
      required this.onPapierPressed});

  @override
  Widget build(BuildContext context) {
    return OverflowBar(spacing: 8, children: [
      _ActionButton(
        text: GameAction.schere.emoji,
        onPressed: onScherePressed,
      ),
      _ActionButton(
        text: GameAction.stein.emoji,
        onPressed: onSteinPressed,
      ),
      _ActionButton(
        text: GameAction.papier.emoji,
        onPressed: onPapierPressed,
      ),
    ]);
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}
