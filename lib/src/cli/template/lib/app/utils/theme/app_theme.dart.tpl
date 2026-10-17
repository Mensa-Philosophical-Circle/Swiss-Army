import 'package:flutter/material.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

/// The one place the look of the app is set. Change the colours here and every screen and every
/// swiss_army_component widget follows.
class AppTheme {
  AppTheme._();

  static const _config = SACThemeConfig(primary: Color(0xFF009788));

  static ThemeData get light => SACTheme.light(_config);
  static ThemeData get dark => SACTheme.dark(_config);
}
