// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter_test/flutter_test.dart';

import '../../bin/kidney_ui.dart';

void main() {
  // ###########################################################################
  group('run(args, log)', () {
    group('with args=[my-command, --input, 5]', () {
      test('should print "Running my-command with param 5"', () async {
        // Execute run function and check if it prints the expected output
        final messages = <String>[];
        await run(args: ['my-command', '--input', '5'], ggLog: messages.add);

        final expectedMessages = ['Running my-command with param 5'];

        for (final msg in expectedMessages) {
          expect(messages, contains(msg));
        }
      });
    });
  });
}
