import 'dart:io';

import 'package:swiss_army_component/src/cli/sac_cli.dart';

Future<void> main(List<String> arguments) async {
  exitCode = await runSac(arguments);
}
