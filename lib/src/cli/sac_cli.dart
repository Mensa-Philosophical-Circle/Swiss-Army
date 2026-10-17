import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// Where the package is, for `sac install --git`.
const gitUrl = 'https://github.com/Mensa-Philosophical-Circle/Swiss-Army.git';

/// What `sac` exits with: [ok], a command it does not know or a bad option ([usage]), or no pubspec.yaml ([noInput]).
const exitOk = 0;
const exitUsage = 64;
const exitNoInput = 66;

/// Runs a program and gives its result; swapped out in tests.
typedef RunProcess =
    Future<ProcessResult> Function(String executable, List<String> arguments);

/// The version of this package, read from its own pubspec.yaml, so `install` and `examples` never go
/// stale. Null when it cannot be found (a compiled copy of the tool): then any version will do.
Future<String?> ownVersion() async {
  try {
    final lib = await Isolate.resolvePackageUri(
      Uri.parse('package:swiss_army_component/swiss_army_component.dart'),
    );
    if (lib == null) return null;
    final pubspec = File.fromUri(lib.resolve('../pubspec.yaml'));
    final match = RegExp(
      r'^version:\s*([^\s#]+)',
      multiLine: true,
    ).firstMatch(await pubspec.readAsString());
    return match?.group(1);
  } catch (_) {
    return null;
  }
}

ArgParser _parser() {
  final parser = ArgParser()
    ..addCommand('doctor')
    ..addCommand('examples');
  parser.addCommand('install')
    ..addFlag(
      'git',
      abbr: 'g',
      defaultsTo: false,
      help: 'Install using Git dependency (from GitHub).',
    )
    ..addOption(
      'path',
      abbr: 'p',
      defaultsTo: '.',
      help: 'Path to the app root containing pubspec.yaml',
    );
  return parser;
}

/// The `sac` command line. Returns what it should exit with. [out] and [err] are where it writes, [version]
/// the package version to put in the pubspec (this package's own when left out) and [run] how programs are run.
Future<int> runSac(
  List<String> arguments, {
  StringSink? out,
  StringSink? err,
  String? version,
  RunProcess? run,
}) async {
  final stdoutSink = out ?? stdout;
  final stderrSink = err ?? stderr;
  final parser = _parser();

  ArgResults args;
  try {
    args = parser.parse(arguments);
  } on FormatException catch (e) {
    stderrSink.writeln(e.message);
    _usage(stdoutSink);
    return exitUsage;
  }

  final command = args.command;
  if (command == null) {
    _usage(stdoutSink);
    // `sac` on its own shows what it does; `sac something` it does not know is a mistake.
    if (args.rest.isEmpty) return exitOk;
    stderrSink.writeln('Unknown command: ${args.rest.first}');
    return exitUsage;
  }

  switch (command.name) {
    case 'doctor':
      return _doctor(stdoutSink, run ?? Process.run);
    case 'examples':
      _examples(stdoutSink, version ?? await ownVersion());
      return exitOk;
    default:
      return _install(
        stdoutSink,
        stderrSink,
        path: command['path'] as String,
        useGit: command['git'] as bool,
        version: version ?? await ownVersion(),
      );
  }
}

void _usage(StringSink out) {
  out
    ..writeln('Swiss Army Component CLI')
    ..writeln('Usage: sac <command> [options]')
    ..writeln('')
    ..writeln('Commands:')
    ..writeln('  doctor                Check Flutter environment and versions')
    ..writeln(
      '  install [-g] [-p .]   Add swiss_army_component to pubspec.yaml',
    )
    ..writeln('  examples              Show usage examples')
    ..writeln('')
    ..writeln('Options:')
    ..writeln('  -g, --git             Install dependency from GitHub')
    ..writeln('  -p, --path            Path to app root (default: .)');
}

Future<int> _doctor(StringSink out, RunProcess run) async {
  out.writeln('Checking Flutter environment...');
  try {
    final result = await run('flutter', ['--version']);
    if (result.exitCode == 0) {
      out
        ..writeln(result.stdout)
        ..writeln('Flutter is installed.');
      return exitOk;
    }
    out
      ..writeln(result.stderr)
      ..writeln(
        'Flutter check failed. Ensure Flutter is installed and on PATH.',
      );
  } catch (e) {
    out
      ..writeln('Error running flutter: $e')
      ..writeln('Ensure Flutter is installed and available in PATH.');
  }
  // A check that finds Flutter missing has not passed: scripts can tell.
  return 1;
}

/// The constraint to put in a pubspec: this version and its compatible ones, or any when it is not known.
String constraintFor(String? version) => version == null ? 'any' : '^$version';

void _examples(StringSink out, String? version) {
  out
    ..writeln('Usage examples for Swiss Army Component')
    ..writeln('')
    ..writeln('Add to pubspec.yaml:')
    ..writeln('  dependencies:')
    ..writeln('    swiss_army_component: ${constraintFor(version)}')
    ..writeln('')
    ..writeln('Import and use:')
    ..writeln(
      "  import 'package:swiss_army_component/swiss_army_component.dart';",
    )
    ..writeln('')
    ..writeln('AppTheme example:')
    ..writeln('  MaterialApp(')
    ..writeln('    theme: SACTheme.light(),')
    ..writeln('    darkTheme: SACTheme.dark(),')
    ..writeln('  )')
    ..writeln('')
    ..writeln('Custom theme colors:')
    ..writeln('  final config = SACThemeConfig(')
    ..writeln('    primary: Colors.blue,')
    ..writeln('    secondary: Colors.amber,')
    ..writeln('  );')
    ..writeln('  MaterialApp(')
    ..writeln('    theme: SACTheme.light(config),')
    ..writeln('    darkTheme: SACTheme.dark(config),')
    ..writeln('  )')
    ..writeln('')
    ..writeln('Widgets example:')
    ..writeln("  AppElevatedButton(title: 'Click Me', onPressed: () {});")
    ..writeln("  AppTextField(label: 'Name', hint: 'Enter your name');")
    ..writeln("  AppPhoneTextField(hint: 'Enter phone number', fontSize: 13);");
}

Future<int> _install(
  StringSink out,
  StringSink err, {
  required String path,
  required bool useGit,
  required String? version,
}) async {
  final absolute = File(path).absolute.path;
  final pubspecPath = absolute.endsWith('pubspec.yaml')
      ? absolute
      : '${Directory(path).absolute.path}/pubspec.yaml';
  final file = File(pubspecPath);
  if (!file.existsSync()) {
    err.writeln('pubspec.yaml not found at: $pubspecPath');
    return exitNoInput;
  }

  final editor = YamlEditor(file.readAsStringSync());
  try {
    editor.parseAt(['dependencies']);
  } catch (_) {
    editor.update(['dependencies'], {});
  }
  editor.update(
    ['dependencies', 'swiss_army_component'],
    useGit
        ? {
            'git': {'url': gitUrl, 'ref': 'main'},
          }
        : constraintFor(version),
  );

  file.writeAsStringSync(editor.toString());
  out
    ..writeln('Added swiss_army_component to $pubspecPath')
    ..writeln('Run: flutter pub get');
  return exitOk;
}
