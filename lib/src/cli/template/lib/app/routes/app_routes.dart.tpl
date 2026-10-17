// ignore_for_file: constant_identifier_names
part of 'app_pages.dart';
// `get create page:name` adds new routes here.

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const MAIN = _Paths.MAIN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const SIGN_IN = '/sign-in';
  static const MAIN = '/main';
}
