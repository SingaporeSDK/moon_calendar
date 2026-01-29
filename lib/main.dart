import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'utils/app_localization.dart';

void main() {
  runApp(const MoonCalendarApp());
}

class MoonCalendarApp extends StatefulWidget {
  const MoonCalendarApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MoonCalendarAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MoonCalendarApp> createState() => _MoonCalendarAppState();
}

class _MoonCalendarAppState extends State<MoonCalendarApp> {
  Locale _locale = const Locale('en', 'US');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moon Calendar',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalization.supportedLocales,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0a0e27),
      ),
      home: const HomeScreen(),
    );
  }
}

