import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Every word the user reads, by key: screens say `'sign_in_title'.tr`, never the text itself.
/// To add a language, add its map under keys with the same keys as English.
class AppTranslations extends Translations {
  static const defaultLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {'en_US': _en};

  static const _en = {
    'nav_home': 'Home',
    'nav_profile': 'Profile',
    'not_found_title': 'Page not found',
    'sign_in_title': 'Welcome back',
    'sign_in_subtitle': 'Sign in to continue',
    'sign_in_submit': 'Sign in',
    'email_label': 'Email',
    'email_hint': 'you@example.com',
    'email_required': 'Enter your email',
    'email_invalid': 'Enter a valid email',
    'password_label': 'Password',
    'password_hint': 'Your password',
    'password_required': 'Enter your password',
    'home_pressed': 'Pressed @count times',
    'home_press_me': 'Press me',
    'profile_sign_out': 'Sign out',
  };
}
