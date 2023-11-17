import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _appLocaleKey = 'LOCALE';

class LanguageController extends GetxController {
  Rx<Locale> locale = Rx<Locale>(Locale(Language.en.name));
  late final SharedPreferences _pref;

  void _checkLanguage() async {
    _pref = await SharedPreferences.getInstance();
    final savedLocale = _pref.getString(_appLocaleKey) ?? 'en';
    locale.value = Locale(savedLocale);
    update();
    refresh();
  }

  void _setCurrentLanguage(Language language) async {
    _pref.setString(_appLocaleKey, language.name);
  }

  void changeLanguage(Language language) {
    _setCurrentLanguage(language);
    locale.value = Locale(language.name);
    update();
    refresh();
  }

  void toggleLanguage() {
    if (locale.value == Locale(Language.en.name)) {
      changeLanguage(Language.km);
    } else {
      changeLanguage(Language.en);
    }
  }

  @override
  void onInit() {
    _checkLanguage();
    super.onInit();
  }

  bool get isKhmer => locale.value == Locale(Language.km.name);
}

//Don't change
enum Language {
  en,
  km,
}
