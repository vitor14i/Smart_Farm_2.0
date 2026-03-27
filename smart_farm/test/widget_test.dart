// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:smart_farm/main.dart';

void main() {
  testWidgets('App loads and shows greeting', (WidgetTester tester) async {
    // Build the app and wait for frames to settle.
    await tester.pumpWidget(const SmartFarmApp());
    await tester.pumpAndSettle();

    // Verify the home screen greeting is present.
    expect(find.text('Olá LITA'), findsOneWidget);
  });
}
