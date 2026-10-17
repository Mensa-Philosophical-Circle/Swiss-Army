// ignore_for_file: avoid_print

import 'dart:io';

/// A widget lives next to the one screen that uses it.
///
/// 1. A widget in `lib/app/widgets/` is used by at least two modules (`lib/app/modules/NAME/`). Used by
///    one, it moves to that module's `widgets/` folder; used by none, it goes. lib/app/widgets/shell/ (the
///    not-found screen, update prompt, network banner) is app-wide by definition and is left alone.
/// 2. A module never imports another module's widgets: a widget two modules need is promoted to
///    lib/app/widgets/.
void main() {
  final classRegex = RegExp(
    r'^class\s+([A-Z][A-Za-z0-9_]+)\s+extends\s+(StatelessWidget|StatefulWidget|GetView|GetWidget)',
    multiLine: true,
  );
  String posix(String path) => path.replaceAll('\\', '/');
  final moduleFiles = Directory('lib/app/modules')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();
  String moduleOf(String path) => posix(path).split('lib/app/modules/')[1].split('/').first;

  var violations = 0;

  final shared = Directory('lib/app/widgets');
  if (shared.existsSync()) {
    for (final file in shared.listSync(recursive: true).whereType<File>()) {
      final path = posix(file.path);
      if (!path.endsWith('.dart') || path.contains('lib/app/widgets/shell/')) continue;
      for (final match in classRegex.allMatches(file.readAsStringSync())) {
        final name = match.group(1)!;
        final users = <String>{
          for (final f in moduleFiles)
            if (RegExp('\\b$name\\b').hasMatch(f.readAsStringSync())) moduleOf(f.path),
        };
        if (users.length >= 2) continue;
        stderr.writeln(
          '❌ "$name" ($path) is used by ${users.isEmpty ? 'no module' : 'only "${users.first}"'}. '
          '${users.isEmpty ? 'Delete it' : 'Move it to lib/app/modules/${users.first}/widgets/'}.',
        );
        violations++;
      }
    }
  }

  final crossImport = RegExp(r'''import\s+['"][^'"]*modules/([a-z_]+)/widgets/''');
  for (final file in moduleFiles) {
    final own = moduleOf(file.path);
    for (final m in crossImport.allMatches(file.readAsStringSync())) {
      if (m.group(1) == own) continue;
      stderr.writeln(
        '❌ ${file.path} imports a widget from "${m.group(1)}". Two modules use it: promote it to lib/app/widgets/.',
      );
      violations++;
    }
  }

  if (violations > 0) exit(1);
  print('✅ Every shared widget is shared, and every screen keeps its own widgets.');
}
