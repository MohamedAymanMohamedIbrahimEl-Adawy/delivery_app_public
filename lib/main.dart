import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'serivce_locator.dart';
import 'providers/app_providers.dart';
import 'services/localization/localization.dart';
import 'services/notifications/notifications_services.dart';
import 'services/routes/app_rotues.dart';
import 'services/theme/app_theme.dart';
import 'ui/screens/splash/screen/splash_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigatorState => navigatorKey.currentState;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init localization
  await EasyLocalization.ensureInitialized();

  // Init adaptive theme
  final AdaptiveThemeMode? savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Inject dependancies
  await initServices();

  // Init firebase
  await Firebase.initializeApp();

  // Handle firebase background notifications
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: AppLocalization.getSupportedLocales,
      fallbackLocale: AppLocalization.fallbackLocale,
      startLocale: AppLocalization.startLocale,
      saveLocale: true,
      child: MyApp(
        savedTheme: savedThemeMode,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedTheme;
  const MyApp({super.key, this.savedTheme});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders().getProviders,
      child: AdaptiveTheme(
        light: AppTheme.getTheme(false),
        dark: AppTheme.getTheme(true),
        initial: savedTheme ?? AdaptiveThemeMode.light,
        builder: (light, dark) => MaterialApp(
          navigatorKey: navigatorKey,
          darkTheme: dark,
          theme: light,
          title: 'AG DEVELOPMENT',
          themeAnimationStyle: AnimationStyle(
            duration: const Duration(
              seconds: 250,
            ),
            curve: Curves.linear,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: AppRoutes().getRoutes,
          // initialRoute: AppRoutes().getInitialRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
