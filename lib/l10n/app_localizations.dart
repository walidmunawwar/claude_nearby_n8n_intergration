import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class that handles localization for the application.
/// 
/// This class loads and provides access to translated strings based on the current locale.
class AppLocalizations {
  /// The locale for which this AppLocalizations instance was created.
  final Locale locale;
  
  /// Map containing all translations for the current locale.
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  /// Helper method to keep the code in the widgets concise.
  /// 
  /// Usage:
  /// ```dart
  /// AppLocalizations.of(context).translate('key')
  /// ```
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Static delegate that loads the localized resources.
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// Loads the language JSON file from the "assets/translations" folder.
  Future<bool> load() async {
    // Load the language JSON file from the "assets/translations" folder
    String jsonString = await rootBundle.loadString('assets/translations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap;
    return true;
  }

  /// Translates a string key to its localized value.
  /// 
  /// If the key is not found, returns the key itself as a fallback.
  /// 
  /// @param key The key to translate.
  /// @param args Optional arguments to replace placeholders in the translated string.
  /// @return The translated string.
  String translate(String key, {Map<String, String>? args}) {
    String translation = _localizedStrings[key] ?? key;
    
    if (args != null) {
      args.forEach((argKey, argValue) {
        translation = translation.replaceAll('{$argKey}', argValue);
      });
    }
    
    return translation;
  }
}

/// LocalizationsDelegate implementation for AppLocalizations.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  /// Supported locales for the application.
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  /// Loads the localizations for the given locale.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  /// Whether the delegate should reload when the locale changes.
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
