// html_utils.dart
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hously_flutter/state_managers/services/notification_service.dart';

import 'package:hously_flutter/tester.dart';

import 'package:hously_flutter/screens/add_client_form/add_client_form_pc.dart';

import 'platforms/html_utils_stub.dart'
    if (dart.library.html) 'platforms/html_utils_web.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:beamer/beamer.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import pakietu Riverpod
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/firebase_options.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/language/translation.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/data/internet_checker/internet_checker_widget.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:meta_seo/meta_seo.dart';

import 'language/language_provider.dart';
import 'routes/router.dart' as router;

final routerDelegate = router.generateRouterDelegate();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseDefaultOption);
  final languageNotifier = LanguageNotifier();
  await languageNotifier.initializeLanguage();
  final initialColorScheme = await loadColorScheme();
  final initialthemeMode = await loadSavedThemeMode();
  await ApiServices.init(null);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        'FCM Message received: ${message.notification?.title} - ${message.notification?.body}');
  });
  removeLoader();

  Beamer.setPathUrlStrategy();

  if (kIsWeb) MetaSEO().config();

  runApp(
    BeamerProvider(
      routerDelegate: routerDelegate,
      child: ProviderScope(overrides: [
        languageProvider.overrideWith((ref) => languageNotifier),
        colorSchemeProvider.overrideWith((ref) => initialColorScheme),
        themeProvider.overrideWith((ref) => initialthemeMode),
      ], child: Hously(routerDelegate: routerDelegate)),
    ),
  );
}

class Hously extends ConsumerStatefulWidget {
  final BeamerDelegate routerDelegate;

  const Hously({super.key, required this.routerDelegate});

  @override
  _HouslyState createState() => _HouslyState();
}

class _HouslyState extends ConsumerState<Hously> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(minutes: 3), () {
      if (!mounted) return;
      print("Setting popupVisibleProvider to true.");
      ref.read(popupVisibleProvider.notifier).state = true;
    });

    /// ---- TEMP -------------
    analytics.logEvent(
      name: 'event_name',
      parameters: {'parameter_name': 'value'},
    );
    analytics.logLogin(loginMethod: 'email');
    analytics.logSignUp(signUpMethod: 'google');

    /// ---------------------
    ref.read(navigationService).navigatorKey =
        widget.routerDelegate.navigatorKey;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeLogicalKeyboardKeys(ref);
      await ApiServices.init(ref);
      ref.read(languageProvider.notifier).detectSystemLanguage();
    });
    ref.read(navigationService).navigatorKey =
        widget.routerDelegate.navigatorKey;
    ref.read(languageProvider.notifier).initializeLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final currentLocale = ref.read(languageProvider);

    return BeamerProvider(
      routerDelegate: widget.routerDelegate,
      child: BetterFeedback(
        feedbackBuilder: null,
        theme: FeedbackThemeData(
          background: AppColors.backgroundOppacity1,
          feedbackSheetColor: AppColors.dark,
          drawColors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
          ],
        ),
        darkTheme: FeedbackThemeData.dark(),
        localizationsDelegates: [
          GlobalFeedbackLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeOverride: currentLocale,
        mode: FeedbackMode.draw,
        pixelRatio: 1,
        child: GetMaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CountryLocalizations.delegate,
          ],
          supportedLocales: mobilecodes,
          translations: AppTranslations(),
          locale: currentLocale,
          fallbackLocale: const Locale('en', 'US'),
          theme: resolveAppTheme(
              colorScheme: colorScheme,
              context: context,
              currentThemeMode: currentthememode!,
              ref: ref),
          darkTheme: getDarkTheme(
              colorScheme: colorScheme,
              context: context,
              currentThemeMode: currentthememode,
              ref: ref),
          themeMode: currentthememode,
          routeInformationParser: BeamerParser(),
          backButtonDispatcher: BeamerBackButtonDispatcher(
            delegate: widget.routerDelegate,
          ),
          debugShowCheckedModeBanner: false,
          title: Routes.getWebsiteTitle(context),
          routerDelegate: widget.routerDelegate,
          builder: (context, child) {
            return InternetCheckWidget(child: child!);
          },
          navigatorObservers: <NavigatorObserver>[observer],
        ),
      ),
    );
  }
}