import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

void main() {
  Future<double> elevationWhileHeld(WidgetTester tester, Widget button) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp(theme: SACTheme.light(), home: Scaffold(body: Center(child: button))),
      ),
    );
    final gesture = await tester.startGesture(tester.getCenter(find.byType(ElevatedButton)));
    await tester.pumpAndSettle();
    final material = tester.widget<Material>(
      find.descendant(of: find.byType(ElevatedButton), matching: find.byType(Material)).first,
    );
    await gesture.up();
    await tester.pumpAndSettle();
    return material.elevation;
  }

  testWidgets('holding a button down gives it no shadow', (tester) async {
    final buttons = <Widget>[
      AppElevatedButton(title: 'Go', onPressed: () {}),
      NormalElevatedButton(title: 'Go', onPressed: () {}),
      AppSecondaryElevatedButton(label: 'Go', onPressed: () {}),
      AppIconButton(icon: Icons.add, onPressed: () {}),
    ];
    for (final button in buttons) {
      expect(await elevationWhileHeld(tester, button), 0, reason: button.runtimeType.toString());
    }
  });

  testWidgets('a plain ElevatedButton under the theme does not lift either', (tester) async {
    expect(await elevationWhileHeld(tester, ElevatedButton(onPressed: () {}, child: const Text('Go'))), 0);
  });

  testWidgets('a button that asks for elevation keeps it, without lifting further', (tester) async {
    expect(await elevationWhileHeld(tester, AppElevatedButton(title: 'Go', elevation: 3, onPressed: () {})), 3);
  });
}
