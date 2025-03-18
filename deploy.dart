// @license
// Copyright (c) 2019 - 2025 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:io';

/// Deploys the Flutter web application by compiling it to HTML & JavaScript
/// and copying the build output to the target directory.
void main(List<String> arguments) async {
  // Build the web application using Flutter's build command.
  print('Building web application...');
  final buildResult = await Process.run(
    'flutter',
    ['build', 'web'],
    runInShell: true,
  );

  if (buildResult.exitCode != 0) {
    print('Error building web application:');
    print(buildResult.stderr);
    exit(buildResult.exitCode);
  }
  print('Web application built successfully.');

  // Define the source build directory and target deployment directory.
  final buildDir = Directory('build/web');
  if (!buildDir.existsSync()) {
    print('Build directory does not exist: ${buildDir.path}');
    exit(1);
  }

  final targetDir = Directory('../kidney/kidney_ui');
  // Create target directory if it doesn't exist.
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  // Clean target directory
  await deleteDirectoryContents(targetDir);

  // Copy the built web application to the target directory.
  print('Copying built application to ${targetDir.path} ...');
  await copyDirectory(buildDir, targetDir);
  print('Deployment finished successfully.');
}

/// Deletes all contents of a directory.
Future<void> deleteDirectoryContents(Directory dir) async {
  await for (final entity in dir.list()) {
    try {
      if (entity is File) {
        await entity.delete();
      } else if (entity is Directory) {
        await entity.delete(recursive: true);
      }
    } catch (e) {
      print('Failed to delete \\${entity.path}: \\$e');
    }
  }
}

/// Recursively copies a directory and its contents
/// while preserving the original folder structure.
Future<void> copyDirectory(Directory source, Directory destination) async {
  // List all files and directories recursively from the source.
  await for (final entity in source.list(recursive: true, followLinks: false)) {
    // Get the relative path from the source directory
    final relativePath = entity.path.substring(source.path.length);
    final newPath = destination.path + relativePath;
    if (entity is Directory) {
      // Create the directory in the destination
      await Directory(newPath).create(recursive: true);
    } else if (entity is File) {
      // Ensure the parent directory exists
      await Directory(newPath).parent.create(recursive: true);
      await entity.copy(newPath);
    }
  }
}
