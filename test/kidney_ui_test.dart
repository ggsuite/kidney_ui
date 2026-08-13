// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gg_capture_print/gg_capture_print.dart';
import 'package:kidney_ui/kidney_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gg_args/gg_args.dart';

void main() {
  final messages = <String>[];

  setUp(() {
    messages.clear();
  });

  group('KidneyUi()', () {
    // #########################################################################
    group('KidneyUi', () {
      final kidneyUi = KidneyUi(ggLog: messages.add);

      final CommandRunner<void> runner = CommandRunner<void>(
        'kidneyUi',
        'Description goes here.',
      )..addCommand(kidneyUi);

      test('should allow to run the code from command line', () async {
        await capturePrint(
          ggLog: messages.add,
          code: () async =>
              await runner.run(['kidneyUi', 'my-command', '--input', 'foo']),
        );
        expect(messages, contains('Running my-command with param foo'));
      });

      // .......................................................................
      test('should show all sub commands', () async {
        final (subCommands, errorMessage) = await missingSubCommands(
          directory: Directory('lib/src/commands'),
          command: kidneyUi,
        );

        expect(subCommands, isEmpty, reason: errorMessage);
      });
    });
  });
}
