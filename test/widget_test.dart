import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:schere_stein_papier/game_controller.dart';
import 'package:schere_stein_papier/main.dart';

@GenerateNiceMocks([MockSpec<Random>()])
import 'widget_test.mocks.dart';

Finder findSchereButton = find.descendant(
    of: find.byType(MaterialButton),
    matching: find.text(GameAction.schere.emoji));
Finder findSteinButton = find.descendant(
    of: find.byType(MaterialButton),
    matching: find.text(GameAction.stein.emoji));
Finder findPapierButton = find.descendant(
    of: find.byType(MaterialButton),
    matching: find.text(GameAction.papier.emoji));

Finder findComputerScore = find.descendant(
    of: find.byKey(const Key("computerScore")), matching: find.byType(Text));
Finder findPlayerScore = find.descendant(
    of: find.byKey(const Key("playerScore")), matching: find.byType(Text));

void main() {
  testWidgets('Displays action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(findSchereButton, findsOneWidget);
    expect(findSteinButton, findsOneWidget);
    expect(findPapierButton, findsOneWidget);
  });

  testWidgets("Increment computer score on loss", (WidgetTester tester) async {
    var rnd = MockRandom();
    when(rnd.nextInt(3)).thenReturn(1); // Stein

    await tester.pumpWidget(MaterialApp(home: GameWidget(random: rnd)));

    expect(tester.widget<Text>(findComputerScore).data, equals("0"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("0"));

    await tester.tap(findSchereButton);
    await tester.pump();

    expect(tester.widget<Text>(findComputerScore).data, equals("1"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("0"));
    expect(find.text("Verloren"), findsOneWidget);
  });

  testWidgets("Increment player score on win", (WidgetTester tester) async {
    var rnd = MockRandom();
    when(rnd.nextInt(3)).thenReturn(0); // Schere

    await tester.pumpWidget(MaterialApp(home: GameWidget(random: rnd)));

    expect(tester.widget<Text>(findComputerScore).data, equals("0"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("0"));

    await tester.tap(findSteinButton);
    await tester.pump();

    expect(tester.widget<Text>(findComputerScore).data, equals("0"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("1"));
    expect(find.text("Gewonnen"), findsOneWidget);
  });

  testWidgets("Increment no score on draw", (WidgetTester tester) async {
    var rnd = MockRandom();
    when(rnd.nextInt(3)).thenReturn(2); // Papier

    await tester.pumpWidget(MaterialApp(home: GameWidget(random: rnd)));

    expect(tester.widget<Text>(findComputerScore).data, equals("0"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("0"));

    await tester.tap(findPapierButton);
    await tester.pump();

    expect(tester.widget<Text>(findComputerScore).data, equals("0"));
    expect(tester.widget<Text>(findPlayerScore).data, equals("0"));
    expect(find.text("Unentschieden"), findsOneWidget);
  });
}
