import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _appLocaleKey = 'LOCALE';

class LanguageController extends GetxController {
  Locale locale = const Locale('en');
  late final SharedPreferences _pref;

  void _checkLanguage() async {
    _pref = await SharedPreferences.getInstance();
    final savedLocale = _pref.getString(_appLocaleKey) ?? 'en';
    locale = Locale(savedLocale);
    update();
    refresh();
  }

  void _setCurrentLanguage(Language language) async {
    _pref.setString(_appLocaleKey, language.name);
  }

  void changeLanguage(Language language) {
    _setCurrentLanguage(language);
    locale = Locale(language.name);
    update();
    refresh();
  }

  @override
  void onInit() {
    _checkLanguage();
    super.onInit();
  }
}

//Don't change
enum Language {
  en,
  km,
}
