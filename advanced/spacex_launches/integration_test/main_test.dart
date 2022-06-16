import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spacex_launches/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('When tap the filter chip, the data still should be shown',
      (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    expect(find.byType(FilterChip), findsOneWidget);

    await tester.tap(find.byType(FilterChip));

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsWidgets);
  });
}
