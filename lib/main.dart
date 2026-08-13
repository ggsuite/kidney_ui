// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter/material.dart';

/// Global variable to allow overriding runApp function for testing.
var runAppFunction = runApp;

/// A simple Flutter UI that displays 'Kidney UI' centrally on the screen
/// in large text.
class KidneyUIView extends StatelessWidget {
  /// Creates an instance of [KidneyUIView].
  const KidneyUIView({super.key});

  /// Builds the KidneyUIView widget.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Kidney UI',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// The main app widget that initializes Flutter with [KidneyUIView].
class KidneyUIApp extends StatelessWidget {
  /// Creates an instance of [KidneyUIApp].
  const KidneyUIApp({super.key});

  /// Builds the main app widget.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: KidneyUIView());
  }
}

/// Function to initialize the Kidney UI application.
void kidneyAppMain() {
  runAppFunction(const KidneyUIApp());
}

/// The entry point of the Flutter application.
void main() {
  kidneyAppMain();
}
