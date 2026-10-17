import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/src/cli/sac_cli.dart';

void main() {
  late Directory app;
  late StringBuffer out;
  late StringBuffer err;

  setUp(() {
    app = Directory.systemTemp.createTempSync('sac_cli_');
    File('${app.path}/pubspec.yaml').writeAsStringSync(
      'name: demo\nenvironment:\n  sdk: ^3.0.0\ndependencies:\n  flutter:\n    sdk: flutter\n',
    );
    out = StringBuffer();
    err = StringBuffer();
  });
  tearDown(() => app.deleteSync(recursive: true));

  Future<int> sac(
    List<String> args, {
    String? version = '1.2.3',
    RunProcess? run,
  }) => runSac(args, out: out, err: err, version: version, run: run);
  String pubspec() => File('${app.path}/pubspec.yaml').readAsStringSync();

  test('no command shows what it can do and succeeds', () async {
    expect(await sac([]), exitOk);
    expect(
      out.toString(),
      allOf(contains('doctor'), contains('install'), contains('examples')),
    );
  });

  test('a command it does not know is a mistake, not a success', () async {
    expect(await sac(['nope']), exitUsage);
    expect(err.toString(), contains('Unknown command: nope'));
    expect(out.toString(), contains('Usage: sac <command>'));
  });

  test('a bad option is a mistake too', () async {
    expect(await sac(['install', '--nope']), exitUsage);
  });

  group('install', () {
    test(
      'adds this package at the version that is out now, not an old one',
      () async {
        expect(await sac(['install', '-p', app.path]), exitOk);
        expect(pubspec(), contains('swiss_army_component: ^1.2.3'));
        expect(
          pubspec(),
          contains('flutter:\n    sdk: flutter'),
          reason: 'what was there stays',
        );
      },
    );

    test('takes any version when its own is not known', () async {
      await sac(['install', '-p', app.path], version: null);
      expect(pubspec(), contains('swiss_army_component: any'));
    });

    test(
      '--git points at the repository, and installing again replaces rather than repeats',
      () async {
        await sac(['install', '-p', app.path]);
        expect(await sac(['install', '--git', '-p', app.path]), exitOk);
        expect(pubspec(), contains('git:'));
        expect(pubspec(), contains(gitUrl));
        expect('swiss_army_component'.allMatches(pubspec()), hasLength(1));
      },
    );

    test(
      'works on a pubspec with no dependencies yet, and when given the file itself',
      () async {
        File('${app.path}/pubspec.yaml').writeAsStringSync('name: bare\n');
        expect(
          await sac(['install', '-p', '${app.path}/pubspec.yaml']),
          exitOk,
        );
        expect(pubspec(), contains('swiss_army_component: ^1.2.3'));
      },
    );

    test('says so, and fails, when there is no pubspec.yaml', () async {
      expect(await sac(['install', '-p', '${app.path}/missing']), exitNoInput);
      expect(err.toString(), contains('pubspec.yaml not found'));
    });
  });

  group('examples', () {
    test('show the version out now and widgets that exist', () async {
      expect(await sac(['examples']), exitOk);
      final text = out.toString();
      expect(text, contains('swiss_army_component: ^1.2.3'));
      expect(text, contains('AppElevatedButton('));
      expect(text, isNot(contains('AppButton(')));
      expect(text, contains('SACTheme.light'));
    });
  });

  group('doctor', () {
    test('passes when Flutter answers', () async {
      expect(
        await sac([
          'doctor',
        ], run: (_, _) async => ProcessResult(1, 0, 'Flutter 3.x', '')),
        exitOk,
      );
      expect(out.toString(), contains('Flutter is installed.'));
    });

    test('fails, and says why, when Flutter is not there', () async {
      expect(
        await sac(
          ['doctor'],
          run: (_, _) async =>
              throw const ProcessException('flutter', [], 'not found'),
        ),
        1,
      );
      expect(out.toString(), contains('Ensure Flutter is installed'));
    });

    test('fails when Flutter answers with an error', () async {
      expect(
        await sac([
          'doctor',
        ], run: (_, _) async => ProcessResult(1, 2, '', 'broken')),
        1,
      );
    });
  });

  test(
    'the real tool reads its own version from its pubspec, as `dart run sac` runs it',
    () async {
      final pubspecVersion = RegExp(
        r'^version:\s*(\S+)',
        multiLine: true,
      ).firstMatch(File('pubspec.yaml').readAsStringSync())!.group(1);
      final result = await Process.run('dart', [
        'run',
        'bin/sac.dart',
        'examples',
      ]);
      expect(result.exitCode, 0);
      expect(result.stdout, contains('swiss_army_component: ^$pubspecVersion'));
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
