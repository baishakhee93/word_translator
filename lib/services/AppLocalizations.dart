import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/intl/messages_all.dart';

/// A collection of localized strings for the app.
class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  // Declare all localized strings here using Intl package
  String get title {
    return Intl.message(
      'Flutter Intl Demo',
      name: 'title',
    );
  }

  // Example with parameterized message
  String greetUser(String username) {
    return Intl.message(
      'Hello $username!',
      name: 'greetUser',
      args: [username],
    );
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final String localeName = Intl.canonicalizedLocale(locale.toString());
    await initializeMessages(localeName);
    return AppLocalizations();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
