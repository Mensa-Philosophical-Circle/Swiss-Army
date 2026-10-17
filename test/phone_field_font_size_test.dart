import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

void main() {
  Future<void> pump(WidgetTester tester, {double? fontSize, double? hintFontSize}) => tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        home: Scaffold(body: AppPhoneTextField(hint: 'Enter phone', fontSize: fontSize, hintFontSize: hintFontSize)),
      ),
    ),
  );

  double typed(WidgetTester tester) => tester.widget<EditableText>(find.byType(EditableText)).style.fontSize!;
  double hint(WidgetTester tester) => tester.widget<Text>(find.text('Enter phone')).style!.fontSize!;
  double dialCode(WidgetTester tester) => tester.widget<Text>(find.text('+234')).style!.fontSize!;

  testWidgets('keeps drawing the number the hint and the dial code at 14 unless told otherwise', (tester) async {
    await pump(tester);
    expect(typed(tester), 14.sp);
    expect(hint(tester), 14.sp);
    expect(dialCode(tester), 14.sp);
  });

  testWidgets('fontSize sets the number the hint and the dial code together', (tester) async {
    await pump(tester, fontSize: 13);
    expect(typed(tester), 13.sp);
    expect(hint(tester), 13.sp);
    expect(dialCode(tester), 13.sp);
  });

  testWidgets('hintFontSize sets the hint alone', (tester) async {
    await pump(tester, fontSize: 13, hintFontSize: 12);
    expect(typed(tester), 13.sp);
    expect(hint(tester), 12.sp);
  });
}
