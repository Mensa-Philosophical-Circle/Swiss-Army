import 'dart:io';
import 'dart:isolate';

/// What [scaffoldProject] did, by path from the project root.
class ScaffoldResult {
  final written = <String>[];
  final kept = <String>[];
}

/// What a new `flutter create` leaves in these files. They are replaced without `--force`, because nobody
/// has written anything in them yet.
const untouchedFlutterFiles = <String, List<String>>{
  'lib/main.dart': [
    'You have pushed the button this many times', // flutter create
    'Hello World!', // flutter create --empty
  ],
  'test/widget_test.dart': ['Counter increments smoke test'],
};

/// Where the project template is: real files under `lib/src/cli/template/`, laid out as they are in a
/// project. A file ends in `.tpl` (so nothing in the package reads it as its own code) and a folder or file
/// that starts with `dot_` starts with a dot in the project (`dot_githooks` is `.githooks`).
/// Null when the package cannot be found on disk (a compiled copy of the tool).
Future<Directory?> templateDirectory() async {
  try {
    final lib = await Isolate.resolvePackageUri(
      Uri.parse('package:swiss_army_component/swiss_army_component.dart'),
    );
    if (lib == null) return null;
    final dir = Directory.fromUri(lib.resolve('src/cli/template/'));
    return dir.existsSync() ? dir : null;
  } catch (_) {
    return null;
  }
}

/// The `name:` of the pubspec at [pubspecPath], which is also the package other files import from.
String? projectName(String pubspecPath) {
  final match = RegExp(
    r'^name:\s*([A-Za-z0-9_]+)',
    multiLine: true,
  ).firstMatch(File(pubspecPath).readAsStringSync());
  return match?.group(1);
}

/// Copies the [template] files into [root]. A file that is already there is kept, unless it is what a new
/// `flutter create` leaves ([untouchedFlutterFiles]) or [force] is on.
ScaffoldResult scaffoldProject(
  Directory template,
  Directory root, {
  required String name,
  required bool force,
}) {
  final result = ScaffoldResult();
  final files = template.listSync(recursive: true).whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  for (final source in files) {
    if (!source.path.endsWith('.tpl')) continue;
    final relative = source.path
        .substring(template.path.length)
        .replaceAll('\\', '/')
        .replaceFirst(RegExp('^/'), '');
    final path = _projectPath(relative);
    final file = File('${root.path}/$path');
    if (file.existsSync()) {
      final text = file.readAsStringSync();
      final untouched = (untouchedFlutterFiles[path] ?? const <String>[]).any(
        text.contains,
      );
      if (!force && !untouched) {
        result.kept.add(path);
        continue;
      }
    }
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(
      source
          .readAsStringSync()
          .replaceAll('{{app}}', _title(name))
          .replaceAll('{{package}}', name),
    );
    result.written.add(path);
  }
  return result;
}

String _projectPath(String relative) => relative
    .substring(0, relative.length - '.tpl'.length)
    .split('/')
    .map((part) => part.startsWith('dot_') ? '.${part.substring(4)}' : part)
    .join('/');

/// `my_app` as `My App`, for what people read.
String _title(String name) => name
    .split('_')
    .where((word) => word.isNotEmpty)
    .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
    .join(' ');
