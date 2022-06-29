import 'package:flutter/cupertino.dart';
import 'package:framework/utils/shared_preferences_manager.dart';
import 'package:x_bank/configs/key_config.dart';

class LanguageUtil {
  static Future<void> updateSelectLanguageLocale(Locale locale) async {
    String language = locale.languageCode;
    await SharedPreferencesManager()
        .putString(KeyConfig.language_key, language);
  }

  static Locale getSelectLanguageLocale() {
    String? languageCode =
        SharedPreferencesManager().getString(KeyConfig.language_key);
    if (languageCode == null) {
      languageCode = "en";
    }
    return getLanguageLocale(languageCode);
  }

  static String? getConfigLanguage(Locale locale) {
    String configLanguage = "";
    String language = locale.languageCode;
    switch (language) {
      case "en":
        configLanguage = "en-US";
        break;
      case "zh":
        configLanguage = "zh-CN";
        break;
    }
    return configLanguage;
  }

  static String getLanguageCode(Locale locale) {
    return locale.languageCode;
  }

  static Locale getLanguageLocale(String languageCode) {
    return Locale(languageCode);
  }

  static String getShowLanguage(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    String language = locale.languageCode;
    String result = "";
    switch (language) {
      case "en":
        result = "English";
        break;
      case "zh":
        result = "中文";
        break;
    }
    return result;
  }
}
