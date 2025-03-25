import 'package:flutter/material.dart';
import 'package:jobturbo/l10n/app_localizations.dart';
import 'package:jobturbo/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:jobturbo/l10n/amplify_resolvers.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final List<TutorialPage> _pages = [
      TutorialPage(
        title: l10n.welcomeTitle1,
        description: l10n.welcomeDesc1,
        color: const Color(0xFF6366F1),
        image:
            'assets/images/welcome/${locale.languageCode}/${locale.languageCode}.iphone_6.5_display.request.list.screen.png',
      ),
      TutorialPage(
        title: l10n.welcomeTitle2,
        description: l10n.welcomeDesc2,
        color: const Color(0xFF10B981),
        image:
            'assets/images/welcome/${locale.languageCode}/${locale.languageCode}.iphone_6.5_display.request.dialog.screen.png',
      ),
      TutorialPage(
        title: l10n.welcomeTitle3,
        description: l10n.welcomeDesc3,
        color: const Color(0xFF8B5CF6),
        image:
            'assets/images/welcome/${locale.languageCode}/${locale.languageCode}.iphone_6.5_display.apply.to_apply.screen.png',
      ),
      TutorialPage(
        title: l10n.welcomeTitle4,
        description: l10n.welcomeDesc4,
        color: const Color(0xFFEC4899),
        image:
            'assets/images/welcome/${locale.languageCode}/${locale.languageCode}.iphone_6.5_display.apply.applied.screen.png',
      ),
      TutorialPage(
        title: l10n.welcomeTitle5,
        description: l10n.welcomeDesc5,
        color: const Color(0xFF3B82F6),
        image:
            'assets/images/welcome/${locale.languageCode}/${locale.languageCode}.iphone_6.5_display.progress.screen.png',
      ),
      TutorialPage(
        title: l10n.welcomeTitle6,
        description: l10n.welcomeDesc6,
        color: const Color(0xFFF59E0B),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == _pages.length - 1;
              });
            },
            children: _pages,
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TextButton(
                //   onPressed: () {
                //     _controller.jumpToPage(_pages.length - 1);
                //   },
                //   child: Text(l10n.skip,
                //       style: const TextStyle(color: Colors.white)),
                // ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: _pages.length,
                  effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Authenticator(
                            stringResolver: const AuthStringResolver(
                              buttons: LocalizedButtonResolver(),
                              inputs: LocalizedInputResolver(),
                              messages: LocalizedMessageResolver(),
                              titles: LocalizedTitleResolver(),
                            ),
                            child: MaterialApp(
                                builder: Authenticator.builder(),
                                theme: Theme.of(context),
                                localizationsDelegates:
                                    AppLocalizations.localizationsDelegates,
                                supportedLocales:
                                    AppLocalizations.supportedLocales,
                                home: const MyApp()),
                          ),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    isLastPage ? l10n.done : l10n.next,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String? image;

  const TutorialPage({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  if (image != null)
                    Flexible(
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.75,
                          child: Image(
                            image: AssetImage(image!),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $image');
                              print('Error details: $error');
                              return Container(
                                color: Colors.grey.withOpacity(0.3),
                                child: const Icon(
                                  Icons.error_outline,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
