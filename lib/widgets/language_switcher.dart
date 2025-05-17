import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../l10n/app_localizations.dart';

/// A widget that allows users to switch between available languages.
/// 
/// This widget displays a dropdown menu with language options and handles
/// the language change through the LocaleProvider.
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.translate('language'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: localeProvider.locale.languageCode,
            underline: Container(
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                localeProvider.setLocale(Locale(newValue));
              }
            },
            items: [
              DropdownMenuItem<String>(
                value: 'ar',
                child: Text(localizations.translate('arabic')),
              ),
              DropdownMenuItem<String>(
                value: 'en',
                child: Text(localizations.translate('english')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
