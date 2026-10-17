import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

/// Every widget draws its colours from the theme, so one SACThemeConfig changes them all.
void main() {
  const purple = Color(0xFF7B1FA2);
  const orange = Color(0xFFEF6C00);
  const darkSurface = Color(0xFF102030);

  Future<void> show(WidgetTester t, Widget child, {ThemeData? theme}) async {
    await t.pumpWidget(const SizedBox());
    await t.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          theme:
              theme ??
              SACTheme.light(
                const SACThemeConfig(primary: purple, success: orange),
              ),
          home: Scaffold(body: Center(child: child)),
        ),
      ),
    );
    await t.pump();
  }

  Color? borderColor(InputBorder? b) =>
      b is OutlineInputBorder ? b.borderSide.color : null;

  testWidgets(
    'a text field is outlined in the primary colour when it has focus',
    (t) async {
      await show(t, const AppTextField(label: 'Name'));
      await t.tap(find.byType(TextField));
      await t.pump();
      expect(
        borderColor(
          t.widget<TextField>(find.byType(TextField)).decoration?.focusedBorder,
        ),
        purple,
      );
    },
  );

  group('the phone field', () {
    testWidgets('has a cursor in the primary colour', (t) async {
      await show(t, const AppPhoneTextField());
      final field = t.widget<TextField>(
        find.descendant(
          of: find.byType(TextFormField),
          matching: find.byType(TextField),
        ),
      );
      expect(field.cursorColor, purple);
    });

    testWidgets(
      'marks the chosen country in the picker with the primary colour',
      (t) async {
        await show(t, const AppPhoneTextField(initialCountryCode: 'NG'));
        await t.tap(find.text('+234'));
      await t.pumpAndSettle();
      // The list builds only what is on screen: narrowed to Nigeria and Niger, both are.
      await t.enterText(find.widgetWithText(TextField, 'Search country or code...').last, 'Nige');
      await t.pumpAndSettle();
      Color? dialCodeColor(String country, String code) =>
          t.widget<Text>(find.descendant(of: find.widgetWithText(ListTile, country), matching: find.text(code))).style?.color;
      expect(dialCodeColor('Nigeria', '+234'), purple);
      expect(dialCodeColor('Niger', '+227'), isNot(purple));
    });
  });

  testWidgets('a profit is in the success colour', (t) async {
    await show(t, const PriceText(price: '5', isProfit: true));
    expect(t.widget<Text>(find.byType(Text)).style?.color, orange);
  });

  testWidgets('a verified code says so in the success colour', (t) async {
    await show(
      t,
      OTPVerificationWidget(
        onVerify: (_) async => true,
        successText: 'Verified',
      ),
    );
    expect(t.widget<Text>(find.text('Verified')).style?.color, orange);
  });

  testWidgets(
    'a dropdown takes its menu from the surface colour of the theme, not white or grey',
    (t) async {
      final dark = SACTheme.dark(
        const SACThemeConfig(surfaceDark: darkSurface),
      );
      await show(
        t,
        AppDropdown<String>(
          items: const [DropdownMenuItem(value: 'a', child: Text('A'))],
          onChanged: (_) {},
        ),
        theme: dark,
      );
      expect(
        t
            .widget<DropdownButton<String>>(find.byType(DropdownButton<String>))
            .dropdownColor,
        darkSurface,
      );
    },
  );

  test('the theme carries its success colour for the widgets to use', () {
    expect(
      SACTheme.light(
        const SACThemeConfig(success: orange),
      ).extension<SACThemeExtension>()!.success,
      orange,
    );
    expect(SACTheme.light().extension<SACThemeExtension>()!.success, isNotNull);
  });
}
