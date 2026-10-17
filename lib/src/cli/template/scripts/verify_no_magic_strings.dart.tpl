// ignore_for_file: avoid_print

import 'dart:io';

/// Words the user reads are translation keys (`'sign_in_title'.tr`), not text typed into a widget.
/// This looks for text, labels and hints written as plain words in lib/app/modules and lib/app/widgets.
void main() {
  final patterns = [
    RegExp(r'''\b(?:BigAppText|MedAppText|SmallAppText|Text)\s*\(\s*['"]([A-Za-z0-9\s]{3,})['"]'''),
    RegExp(r'''\b(?:label|title|hint|hintText):\s*['"]([A-Za-z0-9\s]{3,})['"]'''),
  ];
  final violations = <String>[];

  for (final path in ['lib/app/modules', 'lib/app/widgets']) {
    final dir = Directory(path);
    if (!dir.existsSync()) continue;
    for (final file in dir.listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.startsWith('//') || line.startsWith('import ')) continue;
        for (final pattern in patterns) {
          for (final match in pattern.allMatches(line)) {
            violations.add('${file.path}:${i + 1} -> "${match.group(1)}"');
          }
        }
      }
    }
  }

  if (violations.isNotEmpty) {
    stderr.writeln('❌ Words typed into a widget. Add a key to app_translations.dart and use key.tr:');
    violations.forEach(stderr.writeln);
    exit(1);
  }
  print('✅ No hard-coded words in screens.');
}
