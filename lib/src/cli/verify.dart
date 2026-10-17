import 'dart:io';

import 'sac_cli.dart';

/// Files `sac install` is not finished without.
const _essentialFiles = [
  'lib/main.dart',
  'lib/app/routes/app_pages.dart',
  'lib/app/routes/app_routes.dart',
  'lib/app/utils/theme/app_theme.dart',
  'lib/app/utils/localization/app_translations.dart',
  'lib/app/modules/splash/views/splash_view.dart',
  'lib/app/modules/sign_in/views/sign_in_view.dart',
  'lib/app/modules/main/views/main_view.dart',
  'AGENTS.md',
  'scripts/quality_gate.sh',
  'scripts/verify_security.sh',
  'scripts/verify_localization.dart',
];

const _essentialPackages = [
  'swiss_army_component',
  'get',
  'flutter_screenutil',
  'liquid_glass_widgets',
];

/// Checks that `sac install` was done in the project at [path]: packages asked for and fetched, the files in
/// place, the GetX command line there. Says what is wrong and how to fix it. Exits ok only when all is well.
Future<int> verifyProject(
  StringSink out,
  StringSink err, {
  required String path,
  required RunProcess run,
}) async {
  final pubspec = File(
    path.endsWith('pubspec.yaml') ? path : '$path/pubspec.yaml',
  );
  if (!pubspec.existsSync()) {
    err.writeln('pubspec.yaml not found at: ${pubspec.path}');
    return exitNoInput;
  }
  final root = pubspec.parent;
  final pubspecText = pubspec.readAsStringSync();
  final problems = <String>[];

  void check(String what, bool ok, String fix) {
    out.writeln('${ok ? '✓' : '✗'} $what');
    if (!ok) problems.add('$what: $fix');
  }

  for (final package in _essentialPackages) {
    check(
      'pubspec.yaml asks for $package',
      RegExp('^\\s+$package:', multiLine: true).hasMatch(pubspecText),
      'run sac install',
    );
  }

  final config = File('${root.path}/.dart_tool/package_config.json');
  check(
    'packages are fetched',
    config.existsSync() &&
        config.readAsStringSync().contains('"name": "swiss_army_component"'),
    'run flutter pub get',
  );

  for (final file in _essentialFiles) {
    check(
      file,
      File('${root.path}/$file').existsSync(),
      'run sac install (add --force to restore it)',
    );
  }

  var cli = false;
  try {
    cli = (await run('get', ['--version'])).exitCode == 0;
  } catch (_) {}
  check(
    'GetX command line (get create page:name)',
    cli,
    'run dart pub global activate get_cli, and put ~/.pub-cache/bin on your PATH',
  );

  if (problems.isEmpty) {
    out.writeln('\nAll set up.');
    return exitOk;
  }
  out
    ..writeln('\n${problems.length} thing(s) to fix:')
    ..writeln(problems.map((p) => '  - $p').join('\n'));
  return 1;
}
