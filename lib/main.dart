import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobturbo/amplify_outputs.dart' as dev_config;
import 'package:jobturbo/amplify_outputs_production.dart' as prod_config;
import 'package:jobturbo/models/ModelProvider.dart';
import 'package:jobturbo/theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_screen.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:jobturbo/l10n/app_localizations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'store_config.dart';
import 'package:jobturbo/utils/constant.dart';

Future<void> main() async {
  try {
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isMacOS) {
        StoreConfig(
          store: Store.appStore,
          apiKey: appleApiKey,
        );
      } else if (Platform.isAndroid) {
        // Run the app passing --dart-define=AMAZON=true
        const useAmazon = bool.fromEnvironment("amazon");
        StoreConfig(
          store: useAmazon ? Store.amazon : Store.playStore,
          apiKey: useAmazon ? amazonApiKey : googleApiKey,
        );
      }
    }

    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      await _configureSDK();
    }
    await _configureAmplify();
    runApp(const ProviderScope(child: MyApp()));
  } on AmplifyException catch (e) {
    runApp(Text("Error configuring Amplify: ${e.message}"));
  }
}

Future<void> _configureSDK() async {
  // Enable debug logs before calling `configure`.
  // await Purchases.setLogLevel(LogLevel.debug);

  /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - PurchasesAreCompletedyBy is PurchasesAreCompletedByRevenueCat, so Purchases will automatically handle finishing transactions. Read more about completing purchases here: https://www.revenuecat.com/docs/migrating-to-revenuecat/sdk-or-not/finishing-transactions
    */
  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null;
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null;
  }
  await Purchases.configure(configuration);
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins(
      [
        AmplifyAuthCognito(),
        AmplifyAPI(
          options: APIPluginOptions(
            modelProvider: ModelProvider.instance,
          ),
        ),
      ],
    );

    if (!kIsWeb) {
      Amplify.addPlugin(AmplifyPushNotificationsPinpoint());
    }

    final config = const String.fromEnvironment('APP_MODE') == 'production'
        ? prod_config.amplifyConfig
        : dev_config.amplifyConfig;

    await Amplify.configure(config);
    safePrint(
        'Successfully configured with ${const String.fromEnvironment('APP_MODE') == 'production' ? 'production' : 'development'} config');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  bool _isLoading = true;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      setState(() {
        _isSignedIn = result.isSignedIn;
        _isLoading = false;
      });
    } on AuthException catch (e) {
      safePrint('Error fetching auth session: ${e.message}');
      setState(() {
        _isSignedIn = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: _themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isSignedIn
              ? MainScreen()
              : WelcomeScreen(),
    );
  }
}
