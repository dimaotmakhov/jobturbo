import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:jobturbo/screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jobturbo/l10n/app_localizations.dart';
import '../mocks/request_screen_mock.dart';
import '../golden_test_utils.dart';
import 'package:jobturbo/theme.dart';

void runTests(List<Locale> locales, List<List<Device>> devices) {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Request Screen Tests', () {
    // request screen list
    for (final locale in locales) {
      for (final device in devices) {
        testGoldens('${locale.languageCode} ${device[0].name} Request Screen',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              themeMode: ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              locale: locale,
              home: MainScreen(
                mockQueryProvider: RequestScreenMock.mockList,
              ),
            ),
          );

          await tester.pumpAndSettle();

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[0].name}.request.list',
            devices: [
              Device(
                name: "screen",
                size: device[0].size,
                textScale: 1,
                devicePixelRatio: device[0].devicePixelRatio,
              ),
            ],
          );

          final screenFile = File(
              "test/goldens/${locale.languageCode}.${device[0].name}.request.list.screen.png");
          final memoryImage = MemoryImage(screenFile.readAsBytesSync());
          final image = Image(image: memoryImage);

          final l10n = await AppLocalizations.delegate.load(locale);

          final text = Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilyWithFallbacks,
                    height: 1.25,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '${l10n.jobSearchAppGetsYou}\n',
                    ),
                    const WidgetSpan(
                      child: SizedBox(height: 50),
                    ),
                    WidgetSpan(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1a3366),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          l10n.hired,
                          style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamilyWithFallbacks,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

          final decoratedScreen = getDecoratedScreen(image, device[1], text);

          await tester.pumpWidgetBuilder(decoratedScreen);

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[1].name}.request.list',
            devices: [
              Device(
                name: "final",
                size: device[1].size,
                textScale: 1,
                devicePixelRatio: device[1].devicePixelRatio,
              ),
            ],
          );
        });
      }
    }

    // request dialog
    for (final locale in locales) {
      for (final device in devices) {
        testGoldens('${locale.languageCode} ${device[0].name} Request Dialog',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              themeMode: ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              locale: locale,
              home: MainScreen(
                mockQueryProvider: RequestScreenMock.mockList,
              ),
            ),
          );

          await tester.pumpAndSettle();

          await tester.tap(find.byType(FloatingActionButton));
          await tester.pumpAndSettle();

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[0].name}.request.dialog',
            devices: [
              Device(
                name: "screen",
                size: device[0].size,
                textScale: 1,
                devicePixelRatio: device[0].devicePixelRatio,
              ),
            ],
          );

          final screenFile = File(
              "test/goldens/${locale.languageCode}.${device[0].name}.request.dialog.screen.png");
          final memoryImage = MemoryImage(screenFile.readAsBytesSync());
          final image = Image(image: memoryImage);

          final l10n = await AppLocalizations.delegate.load(locale);

          final text = Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilyWithFallbacks,
                    height: 1.25,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.applyPositionsInDays,
                    ),
                  ],
                ),
              ),
            ),
          );

          final decoratedScreen = getDecoratedScreen(image, device[1], text);

          await tester.pumpWidgetBuilder(decoratedScreen);

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[1].name}.request.dialog',
            devices: [
              Device(
                name: "final",
                size: device[1].size,
                textScale: 1,
                devicePixelRatio: device[1].devicePixelRatio,
              ),
            ],
          );
        });
      }
    }
  });
}
