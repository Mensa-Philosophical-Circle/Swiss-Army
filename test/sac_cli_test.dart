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

  // Every program `sac` would run, so no test installs anything for real.
  late List<String> ran;
  setUp(() => ran = []);

  Future<int> sac(
    List<String> args, {
    String? version = '1.2.3',
    RunProcess? run,
  }) => runSac(
    args,
    out: out,
    err: err,
    version: version,
    run:
        run ??
        (exe, a, {workingDirectory}) async {
          ran.add('$exe ${a.join(' ')}');
          return ProcessResult(1, 0, '', '');
        },
  );
  bool has(String path) => File('${app.path}/$path').existsSync();
  String read(String path) => File('${app.path}/$path').readAsStringSync();
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

  group('install template', () {
    test('sets up the GetX folders and the ready screens', () async {
      expect(await sac(['install', '-p', app.path]), exitOk);
      for (final path in [
        'lib/main.dart',
        'lib/app/routes/app_pages.dart',
        'lib/app/routes/app_routes.dart',
        'lib/app/utils/theme/app_theme.dart',
        'lib/app/widgets/adaptive_bottom_nav.dart',
        'lib/app/modules/splash/views/splash_view.dart',
        'lib/app/modules/sign_in/controllers/sign_in_controller.dart',
        'lib/app/modules/main/views/main_view.dart',
        'lib/app/data/repositories/.gitkeep',
      ]) {
        expect(has(path), isTrue, reason: path);
      }
      expect(pubspec(), contains('get: ^4.7.2'));
      expect(pubspec(), contains('flutter_screenutil:'));
      expect(pubspec(), contains('liquid_glass_widgets:'));
      expect(
        read('lib/app/modules/splash/views/splash_view.dart'),
        contains("'Demo'"),
      );
      expect(read('test/widget_test.dart'), contains('package:demo/main.dart'));
    });

    test('gets the packages and installs the GetX command line', () async {
      await sac(['install', '-p', app.path]);
      expect(ran, ['flutter pub get', 'dart pub global activate get_cli']);
      expect(out.toString(), contains('get create page:orders'));
    });

    test(
      '--no-cli leaves the command line out, --no-template adds only the dependency',
      () async {
        await sac(['install', '--no-cli', '-p', app.path]);
        expect(ran, ['flutter pub get']);

        ran.clear();
        final other = Directory.systemTemp.createTempSync('sac_plain_');
        addTearDown(() => other.deleteSync(recursive: true));
        File('${other.path}/pubspec.yaml').writeAsStringSync('name: plain\n');
        await sac(['install', '--no-template', '-p', other.path]);
        expect(ran, isEmpty);
        expect(File('${other.path}/lib/main.dart').existsSync(), isFalse);
        expect(
          File('${other.path}/pubspec.yaml').readAsStringSync(),
          isNot(contains('get:')),
        );
      },
    );

    test(
      'keeps a main.dart that is theirs, but replaces the one flutter create makes',
      () async {
        Directory('${app.path}/lib').createSync();
        File(
          '${app.path}/lib/main.dart',
        ).writeAsStringSync('void main() => print("mine");');
        await sac(['install', '--no-cli', '-p', app.path]);
        expect(read('lib/main.dart'), contains('mine'));
        expect(out.toString(), contains('Kept your lib/main.dart'));

        await sac(['install', '--no-cli', '--force', '-p', app.path]);
        expect(read('lib/main.dart'), contains('GetMaterialApp'));

        File(
          '${app.path}/lib/main.dart',
        ).writeAsStringSync('// You have pushed the button this many times');
        await sac(['install', '--no-cli', '-p', app.path]);
        expect(read('lib/main.dart'), contains('GetMaterialApp'));
      },
    );

    test('keeps the versions the project already asks for', () async {
      File(
        '${app.path}/pubspec.yaml',
      ).writeAsStringSync('name: demo\ndependencies:\n  get: ^4.6.0\n');
      await sac(['install', '--no-cli', '-p', app.path]);
      expect(pubspec(), contains('get: ^4.6.0'));
    });

    test('a step that fails is reported, and the rest still happens', () async {
      final code = await sac(
        ['install', '-p', app.path],
        run: (_, _, {workingDirectory}) async =>
            ProcessResult(1, 1, '', 'no network'),
      );
      expect(code, exitOk);
      expect(out.toString(), contains('failed, run it yourself'));
      expect(has('lib/main.dart'), isTrue);
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
        await sac(
          ['doctor'],
          run: (_, _, {workingDirectory}) async =>
              ProcessResult(1, 0, 'Flutter 3.x', ''),
        ),
        exitOk,
      );
      expect(out.toString(), contains('Flutter is installed.'));
    });

    test('fails, and says why, when Flutter is not there', () async {
      expect(
        await sac(
          ['doctor'],
          run: (_, _, {workingDirectory}) async =>
              throw const ProcessException('flutter', [], 'not found'),
        ),
        1,
      );
      expect(out.toString(), contains('Ensure Flutter is installed'));
    });

    test('fails when Flutter answers with an error', () async {
      expect(
        await sac(
          ['doctor'],
          run: (_, _, {workingDirectory}) async =>
              ProcessResult(1, 2, '', 'broken'),
        ),
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
