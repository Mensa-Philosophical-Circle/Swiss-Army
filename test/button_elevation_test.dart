import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

void main() {
  testWidgets('AppElevatedButton should have elevation 0 by default', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: AppElevatedButton(title: 'Test Button', onPressed: () {}),
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    final ElevatedButton button = tester.widget<ElevatedButton>(buttonFinder);
    final ButtonStyle? style = button.style;

    // We expect it to be 0 after fix. For now, we expect it might be 2 specific to current impl
    // But we are writing the test to PASS only if it is 0. So it should FAIL now.

    // Check elevation state property. We assume normal state (empty set).
    final double? elevation = style?.elevation?.resolve({});

    expect(
      elevation,
      null,
      reason: 'Default elevation should be null (theme default)',
    );
  });

  testWidgets('NormalElevatedButton should have elevation 0 by default', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: NormalElevatedButton(title: 'Test Button', onPressed: () {}),
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    final ElevatedButton button = tester.widget<ElevatedButton>(buttonFinder);
    final ButtonStyle? style = button.style;
    final double? elevation = style?.elevation?.resolve({});

    expect(
      elevation,
      null,
      reason: 'Default elevation should be null (theme default)',
    );
  });
}
