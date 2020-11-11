// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:core_values_app/global_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Finds base main screen components', (WidgetTester tester) async {
    await tester.pumpWidget(GlobalProvider());

    expect(find.text('Favourites'), findsOneWidget);
    expect(find.text('Values'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(InkWell), findsWidgets);

  });

  testWidgets('Finds floating action button shows dialog', (WidgetTester tester) async {
    await tester.pumpWidget(GlobalProvider());

    final button = find.byType(FloatingActionButton);
    await tester.tap(button);
    await tester.pump();
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Add Your Core Value'), findsOneWidget);

  });
}
