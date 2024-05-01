import 'package:flutter/material.dart';

class AppLocalization {
  static const List<Locale> _spportedLocales = [
    Locale('en', "US"),
    Locale('ar', "DZ"),
  ];
  static const Locale _fallbackLocale = Locale('en', "US");
  static const Locale _startLocale = Locale('en', "US");

  static List<Locale> get getSupportedLocales {
    return [..._spportedLocales];
  }

  static Locale get fallbackLocale {
    return _fallbackLocale;
  }

  static Locale get startLocale {
    return _startLocale;
  }
}
