import 'package:flutter/material.dart';
import 'package:kanban_flutter/src/core/constants/shared_pref_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///languages code
const String english = 'en';
const String hindi = 'hi';

Future<Locale> setLocale(String languageCode) async {
  await appState.encryptedSharedPreferences.setString(SharedPrefConstants.languageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await appState.encryptedSharedPreferences.getString(SharedPrefConstants.languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return const Locale(english, '');
    case hindi:
      return const Locale(hindi, '');
    default:
      return const Locale(english, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
