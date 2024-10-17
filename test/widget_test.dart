import 'package:flutter_test/flutter_test.dart';
import 'package:schere_stein_papier/main.dart';

void main() {
  testWidgets('Displays action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text("✌️🏻"), findsOneWidget);
    expect(find.text("✊🏻"), findsOneWidget);
    expect(find.text("✋🏻"), findsOneWidget);
  });
}
