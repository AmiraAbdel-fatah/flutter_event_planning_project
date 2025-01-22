import 'package:event_planning/provider/app_language_provider.dart';
import 'package:event_planning/provider/app_theme_provider.dart';
import 'package:event_planning/provider/event_list_provider.dart';
import 'package:event_planning/provider/user_provider.dart';
import 'package:event_planning/splash_screen.dart';
import 'package:event_planning/ui/auth/login/login_screen.dart';
import 'package:event_planning/ui/auth/register/register_screen.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/on_boarding_screen/Introduction_screen.dart';
import 'package:event_planning/ui/on_boarding_screen/on_boarding_screen.dart';
import 'package:event_planning/ui/tabs/home/add_event/add_event.dart';
import 'package:event_planning/ui/tabs/home/add_event/edit_event.dart';
import 'package:event_planning/ui/tabs/home/add_event/event_details.dart';
import 'package:event_planning/utils/app_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();    /// Offline
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventListProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: RegisterScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
        IntroductionScreen.routeName: (context) => IntroductionScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddEvent.routeName: (context) => AddEvent(),
        EventDetails.routeName: (context) => EventDetails(),
        EditEvent.routeName: (context) => EditEvent(),
      },
    );
  }
}