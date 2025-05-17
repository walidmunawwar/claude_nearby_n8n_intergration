import 'package:flutter/material.dart';

/// A provider class that manages the application's locale state.
/// 
/// This class extends ChangeNotifier to notify listeners when the locale changes,
/// allowing the UI to update accordingly.
class LocaleProvider extends ChangeNotifier {
  /// The current locale of the application.
  Locale _locale = const Locale('ar');

  /// Gets the current locale.
  Locale get locale => _locale;

  /// Sets a new locale and notifies listeners.
  /// 
  /// @param newLocale The new locale to set.
  void setLocale(Locale newLocale) {
    if (newLocale != _locale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  /// Toggles between Arabic and English locales.
  void toggleLocale() {
    final newLocale = _locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    setLocale(newLocale);
  }

  /// Checks if the current locale is RTL (Right-to-Left).
  /// 
  /// @return True if the current locale is RTL, false otherwise.
  bool get isRtl => _locale.languageCode == 'ar';
}
