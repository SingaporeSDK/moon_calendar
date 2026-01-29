import 'package:flutter/material.dart';
import 'app_strings.dart';

class AppLocalization {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ja', 'JP'),
    Locale('ko', 'KR'),
    Locale('zh', 'CN'),
    Locale('hi', 'IN'),
  ];

  static const Map<String, String> appNames = {
    'en': 'Moon Calendar',
    'ja': 'ムーンカレンダー',
    'ko': '달 달력',
    'zh': '月亮日历',
    'hi': 'चंद्र कैलेंडर',
  };

  static String getAppName(String languageCode) {
    return appNames[languageCode] ?? 'Moon Calendar';
  }

  static String getString(String languageCode, String key) {
    final strings = AppStrings.getStrings(languageCode);
    return strings[key] ?? AppStrings.enUS[key] ?? key;
  }

  static String getCountryCodeFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ja':
        return 'ja';
      case 'ko':
        return 'ko';
      case 'zh':
        return 'zh';
      case 'hi':
        return 'hi';
      default:
        return 'en';
    }
  }

  static Locale getLocaleFromString(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return const Locale('ja', 'JP');
      case 'ko':
        return const Locale('ko', 'KR');
      case 'zh':
        return const Locale('zh', 'CN');
      case 'hi':
        return const Locale('hi', 'IN');
      default:
        return const Locale('en', 'US');
    }
  }
}
