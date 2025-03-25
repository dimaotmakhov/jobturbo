import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'request_screen.dart';
import 'apply_screen.dart';
import 'progress_screen.dart';
import 'welcome_screen.dart';
import 'package:jobturbo/models/Setting.dart';
import 'package:jobturbo/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:jobturbo/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  final dynamic mockQueryProvider;
  final dynamic mockJobListingProvider;
  final dynamic mockJobListingByStatusProvider;

  const MainScreen({
    super.key,
    this.mockQueryProvider,
    this.mockJobListingProvider,
    this.mockJobListingByStatusProvider,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  StreamSubscription<String>? _tokenSubscription;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Initialize screens with mock providers
    _screens = [
      RequestScreen(mockQueryProvider: widget.mockQueryProvider),
      ApplyScreen(mockQueryProvider: widget.mockJobListingProvider),
      ProgressScreen(mockQueryProvider: widget.mockJobListingByStatusProvider),
    ];

    if (!kIsWeb && widget.mockQueryProvider == null) {
      _saveDeviceToken();
      handlePermissions();
    }
  }

  Future<void> _saveDeviceToken() async {
    try {
      _tokenSubscription =
          Amplify.Notifications.Push.onTokenReceived.listen((token) async {

        final response = await Amplify.API
            .query(request: ModelQueries.list(Setting.classType))
            .response;

        final settings = response.data?.items;

        if (settings == null || settings.isEmpty) {
          await Amplify.API.mutate(
              request: ModelMutations.create(Setting(deviceTokens: [token])));
        } else {
          final firstSetting = settings.first;
          if (firstSetting == null) {
            await Amplify.API.mutate(
                request: ModelMutations.create(Setting(deviceTokens: [token])));
          } else {
            final existingTokens = firstSetting.deviceTokens ?? [];
            if (!existingTokens.contains(token)) {

              final updateMutation = '''
                mutation UpdateSetting(
                  \$id: ID!
                  \$deviceTokens: [String]
                ) {
                  updateSetting(input: {
                    id: \$id
                    deviceTokens: \$deviceTokens
                  }) {
                    id
                    deviceTokens
                  }
                }
              ''';

              final request = GraphQLRequest<String>(
                document: updateMutation,
                variables: {
                  'id': firstSetting.id,
                  'deviceTokens': [...existingTokens, token]
                },
              );

              await Amplify.API.mutate(request: request).response;
            }
          }
        }

        _tokenSubscription?.cancel();
      });
    } catch (e) {
      safePrint('Error setting up token listener: $e');
    }
  }

  void handlePermissions() async {
    final status = await Amplify.Notifications.Push.getPermissionStatus();
    switch (status) {
      case PushNotificationPermissionStatus.granted:
        break;
      case PushNotificationPermissionStatus.denied:
        break;
      case PushNotificationPermissionStatus.shouldRequest:
        await Amplify.Notifications.Push.requestPermissions();
        break;
      case PushNotificationPermissionStatus.shouldExplainThenRequest:
        await Amplify.Notifications.Push.requestPermissions();
        break;
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await Amplify.Auth.deleteUser();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: ${e.message}')),
        );
      }
    }
  }

  void _showDeleteAccountDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteAccount),
          content: Text(l10n.deleteAccountConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                l10n.delete,
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? l10n.navRequest
            : _selectedIndex == 1
                ? l10n.navApply
                : l10n.navProgress),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                          title: Text(l10n.deleteAccount),
                          onTap: () {
                            Navigator.pop(context);
                            _showDeleteAccountDialog();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: isDark
            ? Colors.white.withOpacity(0.6)
            : Colors.black.withOpacity(0.6),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.search),
            label: l10n.navRequest,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.collections),
            label: l10n.navApply,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.graph_circle),
            label: l10n.navProgress,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
