import 'package:flutter/material.dart';

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
      ActionButton(
        text: "✌️🏻",
        onPressed: onScherePressed,
      ),
      ActionButton(
        text: "✊🏻",
        onPressed: onSteinPressed,
      ),
      ActionButton(
        text: "✋🏻",
        onPressed: onPapierPressed,
      ),
    ]);
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.text, required this.onPressed});

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
