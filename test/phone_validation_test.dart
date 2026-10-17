import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

void main() {
  group('PhoneParts', () {
    test('only a real number for its country is valid, not one that merely looks long enough', () {
      expect(PhoneParts.isValid('+2348051234567'), isTrue);
      expect(PhoneParts.isValid('+14843153454'), isTrue);
      expect(PhoneParts.isValid('+23491438433443'), isFalse, reason: 'one digit too many for Nigeria');
      expect(PhoneParts.isValid('+2340805123456'), isFalse, reason: 'a leading 0 does not belong after the country code');
      expect(PhoneParts.isValid('+23480512345'), isFalse, reason: 'too short');
      expect(PhoneParts.isValid('08051234567'), isFalse, reason: 'no country code');
      expect(PhoneParts.isValid(''), isFalse);
      expect(PhoneParts.isValid('+'), isFalse);
    });

    test('splits a number into its country and what is typed', () {
      final ng = PhoneParts.parse('+2348051234567');
      expect([ng.isoCode, ng.dialCode, ng.national], ['NG', '+234', '8051234567']);
      final us = PhoneParts.parse('+14843153454');
      expect([us.isoCode, us.dialCode, us.national, us.full], ['US', '+1', '4843153454', '+14843153454']);
    });

    test('with no country code the number is kept whole under the fallback country', () {
      final p = PhoneParts.parse('0805 123 4567');
      expect([p.isoCode, p.dialCode, p.national], ['NG', '+234', '08051234567']);
      final gh = PhoneParts.parse('0241234567', fallbackIso: 'GH', fallbackDialCode: '+233');
      expect([gh.isoCode, gh.dialCode], ['GH', '+233']);
    });
  });

  group('FormValidator.isValidPhone', () {
    test('a number with a country code must be real for its country', () {
      expect(FormValidator.isValidPhone('+2348051234567'), isNull);
      expect(FormValidator.isValidPhone('+23491438433443'), isNotNull);
    });

    test('a number without one is only checked for shape, as before', () {
      expect(FormValidator.isValidPhone('8051234567'), isNull);
      expect(FormValidator.isValidPhone(''), isNotNull);
    });
  });

  group('AppPhoneTextField', () {
    final key = GlobalKey<FormState>();

    Future<void> pump(WidgetTester tester, {String? message}) => tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(body: Form(key: key, child: AppPhoneTextField(hint: 'Enter phone', invalidNumberMessage: message))),
        ),
      ),
    );

    testWidgets('refuses a number of a plausible length that does not exist, and accepts a real one', (tester) async {
      await pump(tester);
      await tester.enterText(find.byType(TextFormField), '91438433443');
      expect(key.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Enter a valid phone number'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '8051234567');
      expect(key.currentState!.validate(), isTrue);
    });

    testWidgets('says it in the app\'s own words when it is given them', (tester) async {
      await pump(tester, message: 'Check the number');
      await tester.enterText(find.byType(TextFormField), '91438433443');
      key.currentState!.validate();
      await tester.pump();
      expect(find.text('Check the number'), findsOneWidget);
    });

    testWidgets('an empty optional field is fine', (tester) async {
      await pump(tester);
      expect(key.currentState!.validate(), isTrue);
    });
  });
}
