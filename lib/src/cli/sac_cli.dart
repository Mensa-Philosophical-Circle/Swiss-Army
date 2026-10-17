import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'scaffold.dart';

/// Where the package is, for `sac install --git`.
const gitUrl = 'https://github.com/Mensa-Philosophical-Circle/Swiss-Army.git';

/// What `sac` exits with: [ok], a command it does not know or a bad option ([usage]), or no pubspec.yaml ([noInput]).
const exitOk = 0;
const exitUsage = 64;
const exitNoInput = 66;

/// Runs a program and gives its result; swapped out in tests.
typedef RunProcess =
    Future<ProcessResult> Function(
      String executable,
      List<String> arguments, {
      String? workingDirectory,
    });

/// What the project template uses besides this package.
const templateDependencies = {
  'get': '^4.7.2',
  'flutter_screenutil': '^5.9.3',
  'liquid_glass_widgets': '^1.11.1',
};

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
    ..addFlag(
      'template',
      defaultsTo: true,
      help:
          'Set up the GetX folders and the splash, sign in and bottom bar screens.',
    )
    ..addFlag(
      'cli',
      defaultsTo: true,
      help: 'Install the GetX command line (get create page:name).',
    )
    ..addFlag(
      'force',
      defaultsTo: false,
      negatable: false,
      help: 'Overwrite template files that already exist.',
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
        template: command['template'] as bool,
        installCli: command['cli'] as bool,
        force: command['force'] as bool,
        run: run ?? Process.run,
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
      '  install [-g] [-p .]   Set up a project: dependency, GetX folders, theme, splash,\n'
      '                        sign in, bottom bar, and the GetX command line',
    )
    ..writeln('  examples              Show usage examples')
    ..writeln('')
    ..writeln('Options:')
    ..writeln('  -g, --git             Install dependency from GitHub')
    ..writeln('  -p, --path            Path to app root (default: .)')
    ..writeln('  --no-template         Only add the dependency, no files')
    ..writeln('  --no-cli              Do not install the GetX command line')
    ..writeln('  --force               Overwrite template files that exist');
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
  required bool template,
  required bool installCli,
  required bool force,
  required RunProcess run,
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
  if (template) {
    final dependencies = (editor.parseAt(['dependencies']).value as Map);
    templateDependencies.forEach((name, constraint) {
      // What the project already asks for stays.
      if (!dependencies.containsKey(name)) {
        editor.update(['dependencies', name], constraint);
      }
    });
  }

  file.writeAsStringSync(editor.toString());
  out.writeln('Added swiss_army_component to $pubspecPath');
  if (!template) {
    out.writeln('Run: flutter pub get');
    return exitOk;
  }

  final root = file.parent;
  final name = projectName(pubspecPath) ?? 'app';
  final result = scaffoldProject(root, name: name, force: force);
  out.writeln(
    'Wrote ${result.written.length} files (lib/app: routes, bindings, modules, data, utils, widgets).',
  );
  for (final kept in result.kept) {
    out.writeln('Kept your $kept (use --force to replace it).');
  }

  await _step(out, run, 'flutter', ['pub', 'get'], root.path, 'Packages');
  if (installCli) {
    await _step(
      out,
      run,
      'dart',
      ['pub', 'global', 'activate', 'get_cli'],
      root.path,
      'GetX command line',
    );
  }
  out
    ..writeln('')
    ..writeln('Ready. Run the app: flutter run')
    ..writeln('Make a screen:      get create page:orders')
    ..writeln('(if "get" is not found, add ~/.pub-cache/bin to your PATH)');
  return exitOk;
}

/// Runs one setup step. A step that fails is said plainly and left for the person to run, it does not undo the rest.
Future<void> _step(
  StringSink out,
  RunProcess run,
  String executable,
  List<String> arguments,
  String directory,
  String what,
) async {
  final command = '$executable ${arguments.join(' ')}';
  try {
    final result = await run(
      executable,
      arguments,
      workingDirectory: directory,
    );
    if (result.exitCode == 0) {
      out.writeln('$what: done ($command).');
      return;
    }
    out.writeln('$what: "$command" failed, run it yourself.\n${result.stderr}');
  } catch (e) {
    out.writeln('$what: could not run "$command" ($e), run it yourself.');
  }
}
