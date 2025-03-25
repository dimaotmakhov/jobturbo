import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'dart:io';
import 'package:path/path.dart' as path; // Changed from dart:path

// Import all screen tests
import 'golden_tests/request_screen_test.dart' as request_screen;
import 'golden_tests/apply_screen_test.dart' as apply_screen;
import 'golden_tests/progress_screen_test.dart' as progress_screen;
import 'package:flutter/material.dart';

void main() {
  setUpAll(() {
    // Initialize any required dependencies before running tests
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // 5 * 3 * 7 = 105 screenshots

  group('Screenshot Tests', () {
    const locales = [
      Locale('de'),
      Locale('en'),
      Locale('es'),
      Locale('fr'),
      Locale('it'),
      Locale('ja'),
      Locale('ko'),
      Locale('pt'),
      Locale('vi'),
      Locale('zh'),
    ];

    final localeToCountry = {
      'de': 'DE',
      'en': 'US',
      'es': 'ES',
      'fr': 'FR',
      'it': '',
      'ja': '',
      'ko': '',
      'pt': 'PT',
      'vi': '',
      'zh': 'Hans',
    };

    const devices = [
      [
        Device(
          name: 'ipad_13_display',
          size: Size(1032 / 2, 1376 / 2),
          devicePixelRatio: 2,
        ),
        Device(
          name: 'ipad_13_display',
          size: Size(2048 / 3, 2732 / 3),
          devicePixelRatio: 3,
        ),
      ],
      [
        Device(
          name: 'iphone_6.9_display',
          size: Size(750 / 2, 1344 / 2),
          devicePixelRatio: 3,
        ),
        Device(
          name: 'iphone_6.9_display',
          size: Size(1290 / 3, 2796 / 3),
          devicePixelRatio: 3,
        ),
      ],
      [
        Device(
          name: 'iphone_6.5_display',
          size: Size(750 / 2, 1344 / 2),
          devicePixelRatio: 3,
        ),
        Device(
          name: 'iphone_6.5_display',
          size: Size(1242 / 3, 2688 / 3),
          devicePixelRatio: 3,
        ),
      ],
    ];

    // Clean up goldens directory first
    final screenshotsDir = Directory('test/goldens');
    if (screenshotsDir.existsSync()) {
      print('Cleaning up existing goldens directory...'); // Debug log
      screenshotsDir.delete(recursive: true);
    }

    // first device for screenshot of app
    // second device for screenshot of app with marketing text
    request_screen.runTests(locales, devices);
    apply_screen.runTests(locales, devices);
    progress_screen.runTests(locales, devices);

    tearDownAll(() async {
      await appStoreScreenshots(locales, localeToCountry);
      await welcomeScreenshots(locales);
    });
  });
}

Future<void> appStoreScreenshots(
    List<Locale> locales, Map<String, String> localeToCountry) async {
  // Map of locale codes to their corresponding country codes

  print('Starting cleanup and file movement process...'); // Debug log

  // Clean up target directory first
  final screenshotsDir = Directory('ios/fastlane/screenshots');
  if (screenshotsDir.existsSync()) {
    print('Cleaning up existing screenshots directory...'); // Debug log
    await screenshotsDir.delete(recursive: true);
  }
  await screenshotsDir.create(recursive: true);

  // Process each locale
  for (final locale in locales) {
    final localeCode = locale.languageCode;
    final countryCode = localeToCountry[localeCode];
    if (countryCode == null) continue;

    final sourceDir = Directory('test/goldens');
    final targetDir = Directory(
        'ios/fastlane/screenshots/${localeCode}${countryCode.isEmpty ? '' : '-' + countryCode}');

    print('Processing $localeCode-$countryCode'); // Debug log
    print('Source directory: ${sourceDir.path}'); // Debug log
    print('Target directory: ${targetDir.path}'); // Debug log

    // Create target directory if it doesn't exist
    if (!targetDir.existsSync()) {
      await targetDir.create(recursive: true);
    }

    // Move all files that contain the locale code
    final files = sourceDir.listSync();
    print('Found ${files.length} files in source directory'); // Debug log

    for (final file in files) {
      if (file is File &&
          file.path.contains('/${localeCode}.') &&
          file.path.contains('final')) {
        final fileName = path.basename(file.path);
        final targetPath = path.join(targetDir.path, fileName);

        await File(file.path).rename(targetPath);
      }
    }
  }

  print('File movement process completed'); // Debug log
}

Future<void> welcomeScreenshots(List<Locale> locales) async {
  print('Starting cleanup and file movement process...'); // Debug log

  // Clean up target directory first
  final screenshotsDir = Directory('assets/images/welcome');
  if (screenshotsDir.existsSync()) {
    print('Cleaning up existing welcome images directory...'); // Debug log
    await screenshotsDir.delete(recursive: true);
  }
  await screenshotsDir.create(recursive: true);

  // Process each locale
  for (final locale in locales) {
    final localeCode = locale.languageCode;

    final sourceDir = Directory('test/goldens');
    final targetDir = Directory('assets/images/welcome/${localeCode}');

    print('Source directory: ${sourceDir.path}'); // Debug log
    print('Target directory: ${targetDir.path}'); // Debug log

    // Create target directory if it doesn't exist
    if (!targetDir.existsSync()) {
      await targetDir.create(recursive: true);
    }

    // Move all files that contain the locale code
    final files = sourceDir.listSync();
    print('Found ${files.length} files in source directory'); // Debug log

    for (final file in files) {
      if (file is File &&
          file.path.contains('/${localeCode}.') &&
          !file.path.contains('final') &&
          file.path.contains('iphone_6.5_display')) {
        final fileName = path.basename(file.path);
        final targetPath = path.join(targetDir.path, fileName);

        await File(file.path).rename(targetPath);
      }
    }
  }

  print('File movement process completed'); // Debug log
}
