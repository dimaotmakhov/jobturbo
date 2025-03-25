import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:jobturbo/screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jobturbo/l10n/app_localizations.dart';
import '../mocks/request_screen_mock.dart';
import '../mocks/apply_screen_mock.dart';
import '../golden_test_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobturbo/theme.dart';

void runTests(List<Locale> locales, List<List<Device>> devices) {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Apply Screen Tests', () {
    // apply screen - to apply tab
    for (final locale in locales) {
      for (final device in devices) {
        testGoldens(
            '${locale.languageCode} ${device[0].name} Apply Screen To Apply Tab',
            (tester) async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
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
                  mockJobListingProvider: ApplyScreenMock.mockList,
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final l10n = await AppLocalizations.delegate.load(locale);

          await tester.tap(find.text(l10n.navApply));
          await tester.pumpAndSettle();

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[0].name}.apply.to_apply',
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
              "test/goldens/${locale.languageCode}.${device[0].name}.apply.to_apply.screen.png");
          final memoryImage = MemoryImage(screenFile.readAsBytesSync());
          final image = Image(image: memoryImage);

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
                      text: '${l10n.trackYourApplications}\n',
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
                          l10n.efficiently,
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
            '${locale.languageCode}.${device[1].name}.apply.to_apply',
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

    // apply screen - applied tab
    for (final locale in locales) {
      for (final device in devices) {
        testGoldens(
            '${locale.languageCode} ${device[0].name} Apply Screen Applied Tab',
            (tester) async {
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
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
                  mockJobListingProvider: ApplyScreenMock.mockList,
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final l10n = await AppLocalizations.delegate.load(locale);

          await tester.tap(find.text(l10n.navApply));
          await tester.pumpAndSettle();

          await tester.tap(find.text(l10n.applied));
          await tester.pumpAndSettle();

          await multiScreenGolden(
            tester,
            '${locale.languageCode}.${device[0].name}.apply.applied',
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
              "test/goldens/${locale.languageCode}.${device[0].name}.apply.applied.screen.png");
          final memoryImage = MemoryImage(screenFile.readAsBytesSync());
          final image = Image(image: memoryImage);

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
                      text: '${l10n.monitorYourProgress}\n',
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
                          l10n.effectively,
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
            '${locale.languageCode}.${device[1].name}.apply.applied',
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
