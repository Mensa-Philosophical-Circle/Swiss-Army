// ignore_for_file: avoid_print

import 'dart:io';

/// Nothing is written twice.
///   1. A module does not define a widget that already exists in `lib/app/widgets/`.
///   2. Two modules do not define a widget with the same name: it is promoted to `lib/app/widgets/`.
///   3. A formatter (money, phone, date) is not rewritten in a screen: it lives in `lib/app/utils/formatters/`.
///   4. A network client (`Dio(`) is made once, in `lib/app/data/`, nowhere else.
///   5. A colour is not typed into a view or widget: it comes from the theme.
void main() {
  String posix(String path) => path.replaceAll('\\', '/');
  List<File> dartFiles(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) return [];
    return dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).toList();
  }

  final classRegex = RegExp(r'^class\s+([A-Z][A-Za-z0-9_]+)\b', multiLine: true);
  final shared = <String, String>{
    for (final file in dartFiles('lib/app/widgets'))
      for (final m in classRegex.allMatches(file.readAsStringSync())) m.group(1)!: posix(file.path),
  };

  var violations = 0;
  void fail(String message) {
    stderr.writeln('❌ $message');
    violations++;
  }

  final seen = <String, List<String>>{};
  for (final file in dartFiles('lib/app/modules')) {
    final path = posix(file.path);
    final text = file.readAsStringSync();
    for (final m in classRegex.allMatches(text)) {
      final name = m.group(1)!;
      if (name.endsWith('Controller') || name.endsWith('Binding') || name.endsWith('State')) continue;
      if (shared.containsKey(name)) fail('"$name" in $path already exists in ${shared[name]}. Reuse it.');
      seen.putIfAbsent(name, () => []).add(path);
    }
    if (RegExp(r'\b(String|void)\s+format(Currency|PhoneNumber|Date(Time)?)\s*\(').hasMatch(text)) {
      fail('A formatter is written in $path. Use lib/app/utils/formatters/.');
    }
    if (path.contains('/views/') || path.contains('/widgets/')) {
      if (RegExp(r'\bColor\(0x[0-9a-fA-F]{8}\)').hasMatch(text)) {
        fail('A colour is typed into $path. Take it from Theme.of(context).');
      }
    }
  }
  for (final entry in seen.entries) {
    if (entry.value.length > 1) {
      fail('"${entry.key}" is defined in ${entry.value.join(' and ')}. Move it to lib/app/widgets/.');
    }
  }

  for (final file in dartFiles('lib')) {
    final path = posix(file.path);
    if (!path.contains('lib/app/data/') && file.readAsStringSync().contains('Dio(')) {
      fail('A network client is made in $path. Make it once, in lib/app/data/.');
    }
  }

  if (violations > 0) exit(1);
  print('✅ Nothing is written twice.');
}
