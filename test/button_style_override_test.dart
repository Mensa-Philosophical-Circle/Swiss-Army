import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

/// An app's theme sets its buttons' colours; a colour given to the button itself must still win over it.
void main() {
  const teal = Color(0xFF009788);
  const red = Color(0xFFED3A3A);

  Widget host(Widget button, {bool themed = true}) => ScreenUtilInit(
    designSize: const Size(375, 812),
    child: MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: themed
            ? ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: teal, foregroundColor: Colors.white))
            : null,
        outlinedButtonTheme: themed
            ? OutlinedButtonThemeData(style: OutlinedButton.styleFrom(side: const BorderSide(color: teal)))
            : null,
      ),
      home: Scaffold(body: button),
    ),
  );

  Color? fillOf(WidgetTester tester) => tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style?.backgroundColor?.resolve({});

  group('AppElevatedButton', () {
    testWidgets('bgColor wins over the theme\'s background', (tester) async {
      await tester.pumpWidget(host(AppElevatedButton(title: 'Delete', bgColor: red, onPressed: () {})));
      expect(fillOf(tester), red);
    });

    testWidgets('with no bgColor the theme\'s background is used', (tester) async {
      await tester.pumpWidget(host(AppElevatedButton(title: 'Save', onPressed: () {})));
      expect(fillOf(tester), teal);
    });

    testWidgets('bgColor still applies when the theme gives buttons no style', (tester) async {
      await tester.pumpWidget(host(AppElevatedButton(title: 'Delete', bgColor: red, onPressed: () {}), themed: false));
      expect(fillOf(tester), red);
    });
  });

  testWidgets('NormalElevatedButton\'s colour wins over the theme\'s', (tester) async {
    await tester.pumpWidget(host(NormalElevatedButton(title: 'Delete', color: red, onPressed: () {})));
    expect(fillOf(tester), red);
  });

  testWidgets('AppOutlinedButton\'s border colour wins over the theme\'s', (tester) async {
    await tester.pumpWidget(host(AppOutlinedButton(label: 'Cancel', brdColor: red, onPressed: () {})));
    final side = tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style?.side?.resolve({}); // It is built on an ElevatedButton.
    expect(side?.color, red);
  });
}
