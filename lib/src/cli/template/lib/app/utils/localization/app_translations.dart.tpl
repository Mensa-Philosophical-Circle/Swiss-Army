import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'languages/de_de.dart';
import 'languages/en_us.dart';
import 'languages/es_es.dart';
import 'languages/fr_fr.dart';

/// Every word the user reads is a key: screens say `'sign_in_title'.tr`, never the text itself. The words
/// are in `languages/`, one file per language with the same keys as English (scripts/verify_localization.dart
/// checks it). To add a language, add a file and a line here.
class AppTranslations extends Translations {
  static const defaultLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'es_ES': esES,
    'fr_FR': frFR,
    'de_DE': deDE,
  };
}
