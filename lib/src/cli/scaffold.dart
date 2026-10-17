import 'dart:io';

import 'project_template.dart';

/// What [scaffoldProject] did, by path from the project root.
class ScaffoldResult {
  final written = <String>[];
  final kept = <String>[];
}

/// The `name:` of the pubspec at [pubspecPath], which is also the package other files import from.
String? projectName(String pubspecPath) {
  final match = RegExp(
    r'^name:\s*([A-Za-z0-9_]+)',
    multiLine: true,
  ).firstMatch(File(pubspecPath).readAsStringSync());
  return match?.group(1);
}

/// Writes the [projectTemplate] files into [root]. A file that is already there is kept, unless it is what a
/// new `flutter create` leaves ([untouchedFlutterFiles]) or [force] is on.
ScaffoldResult scaffoldProject(
  Directory root, {
  required String name,
  required bool force,
}) {
  final result = ScaffoldResult();
  projectTemplate.forEach((path, content) {
    final file = File('${root.path}/$path');
    if (file.existsSync()) {
      final text = file.readAsStringSync();
      final untouched = (untouchedFlutterFiles[path] ?? const <String>[]).any(
        text.contains,
      );
      if (!force && !untouched) {
        result.kept.add(path);
        return;
      }
    }
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(
      content
          .replaceAll('{{app}}', _title(name))
          .replaceAll('{{package}}', name),
    );
    result.written.add(path);
  });
  return result;
}

/// `my_app` as `My App`, for what people read.
String _title(String name) => name
    .split('_')
    .where((word) => word.isNotEmpty)
    .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
    .join(' ');
