import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tests_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'When has not text and after added an text, then should be passed',
      (WidgetTester tester) async {
    app.main();

    // Trigger a frame to ensure the callback has run
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    // Verify initial empty page
    expect(find.text('test'), findsNothing);

    // Finds textfield and enters text
    await tester.enterText(find.byType(TextField), 'test');

    // Finds the FAB and taps it
    await tester.tap(find.byType(FloatingActionButton));

    // Trigger a frame to ensure the callback has run
    await tester.pumpAndSettle();

    // Verify text is entered
    expect(find.text('test'), findsOneWidget);

    // Trigger a drag gesture on the text
    await tester.drag(find.byType(Dismissible), const Offset(1000, 0));

    // Trigger a frame to ensure the callback has run
    await tester.pumpAndSettle();

    // Verify text is removed
    expect(find.text('test'), findsNothing);
  });
}
