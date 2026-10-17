// ignore_for_file: avoid_print

import 'dart:io';

/// Every word is a translation key, and every language has every key.
///   1. Each file in `lib/app/utils/localization/languages/` has the same keys as the English one.
///   2. No value is empty.
///   3. Every key a screen uses (`'key'.tr`, `labelKey: 'key'`) exists in English.
void main() {
  final dir = Directory('lib/app/utils/localization/languages');
  if (!dir.existsSync()) {
    stderr.writeln('❌ ${dir.path} not found.');
    exit(1);
  }

  final entry = RegExp(r"'([a-zA-Z0-9_]+)'\s*:\s*'([^']*)'");
  final languages = <String, Map<String, String>>{
    for (final file in dir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart')))
      file.uri.pathSegments.last: {
        for (final m in entry.allMatches(file.readAsStringSync())) m.group(1)!: m.group(2)!,
      },
  };

  var violations = 0;
  void fail(String message) {
    stderr.writeln('❌ $message');
    violations++;
  }

  final english = languages['en_us.dart'];
  if (english == null) {
    stderr.writeln('❌ en_us.dart is missing: English is the language the others are checked against.');
    exit(1);
  }

  for (final language in languages.entries) {
    for (final word in language.value.entries) {
      if (word.value.trim().isEmpty) fail('${language.key}: "${word.key}" is empty.');
    }
    final missing = english.keys.toSet().difference(language.value.keys.toSet());
    if (missing.isNotEmpty) fail('${language.key} is missing ${missing.length} key(s): ${missing.join(', ')}');
    final extra = language.value.keys.toSet().difference(english.keys.toSet());
    if (extra.isNotEmpty) fail('${language.key} has key(s) English does not: ${extra.join(', ')}');
  }

  final used = RegExp(r"'([a-z0-9_]+)'\.(?:tr|trParams)\b|labelKey:\s*'([a-z0-9_]+)'");
  for (final file in Directory('lib/app').listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart') || file.path.contains('/localization/')) continue;
    for (final m in used.allMatches(file.readAsStringSync())) {
      final key = m.group(1) ?? m.group(2)!;
      if (!english.containsKey(key)) fail('${file.path} uses "$key", which is not in en_us.dart.');
    }
  }

  if (violations > 0) exit(1);
  print('✅ ${languages.length} languages, ${english.length} keys each, every key used exists.');
}
