// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kidney_ui/main.dart' as app_main;

void main() {
  group('KidneyUIView Widget Tests', () {
    testWidgets('KidneyUIView displays centered text with correct style', (
      WidgetTester tester,
    ) async {
      // Build the KidneyUIView widget wrapped in MaterialApp
      await tester.pumpWidget(const MaterialApp(home: app_main.KidneyUIView()));

      // Verify that the text 'Kidney UI' is found
      final textFinder = find.text('Kidney UI');
      expect(
        textFinder,
        findsOneWidget,
        reason: 'The text Kidney UI should be displayed exactly once.',
      );

      // Verify text style properties by extracting the Text widget
      final Text textWidget = tester.firstWidget(textFinder);
      expect(textWidget.style?.fontSize, 48, reason: 'Font size should be 48.');
      expect(
        textWidget.style?.fontWeight,
        FontWeight.bold,
        reason: 'Font weight should be bold.',
      );
    });
  });

  group('KidneyUIApp Widget Tests', () {
    testWidgets('KidneyUIApp creates a MaterialApp with KidneyUIView as home', (
      WidgetTester tester,
    ) async {
      // Build the KidneyUIApp widget
      await tester.pumpWidget(const app_main.KidneyUIApp());

      // Verify that a MaterialApp is in the widget tree
      expect(
        find.byType(MaterialApp),
        findsOneWidget,
        reason: 'MaterialApp should be present.',
      );

      // Verify that the home of MaterialApp is KidneyUIView
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      expect(
        materialApp.home,
        isA<app_main.KidneyUIView>(),
        reason: 'The home widget should be KidneyUIView.',
      );
    });
  });

  group('Main Function Tests', () {
    testWidgets('kidneyAppMain() calls runAppFunction with KidneyUIApp', (
      WidgetTester tester,
    ) async {
      // Save the original runAppFunction
      final originalRunAppFunction = app_main.runAppFunction;

      // Variable to capture the widget passed to runAppFunction
      late Widget capturedWidget;

      // Override runAppFunction to intercept the widget
      app_main.runAppFunction = (Widget widget) {
        capturedWidget = widget;
      };

      // Call kidneyAppMain()
      app_main.kidneyAppMain();

      // Verify that the captured widget is indeed KidneyUIApp
      expect(
        capturedWidget,
        isA<app_main.KidneyUIApp>(),
        reason: 'kidneyAppMain() should call runAppFunction with KidneyUIApp',
      );

      // Restore the original runAppFunction
      app_main.runAppFunction = originalRunAppFunction;
    });

    testWidgets('main() calls kidneyAppMain() and uses runAppFunction', (
      WidgetTester tester,
    ) async {
      // Save the original runAppFunction
      final originalRunAppFunction = app_main.runAppFunction;

      // Variable to capture the widget passed to runAppFunction
      late Widget capturedWidget;

      // Override runAppFunction to intercept the widget
      app_main.runAppFunction = (Widget widget) {
        capturedWidget = widget;
      };

      // Call main() from lib/main.dart using the alias
      app_main.main();

      // Verify that the captured widget is indeed KidneyUIApp
      expect(
        capturedWidget,
        isA<app_main.KidneyUIApp>(),
        reason: 'main() should call runAppFunction with KidneyUIApp',
      );

      // Restore the original runAppFunction
      app_main.runAppFunction = originalRunAppFunction;
    });
  });
}
