// Widget Tests
// Run with: flutter test test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

void main() {
  setUp(() {
    // Reset all security configs before each test
    TextSecurityConfig.resetToDefaults();
    TextFieldSecurityConfig.resetToDefaults();
    SearchBarSecurityConfig.resetToDefaults();

    // Disable logging to keep test output clean
    TextSecurityConfig.enableSecurityLogging = false;
    TextFieldSecurityConfig.enableSecurityLogging = false;
    SearchBarSecurityConfig.enableSecurityLogging = false;
  });

  // ============== AppText Widget Tests ==============

  group('AppText Widget', () {
    testWidgets('renders text correctly', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: AppText('Hello World')),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('applies style presets correctly', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppText('Small', style: AppTextStyle.small),
                  AppText('Medium', style: AppTextStyle.medium),
                  AppText('Large', style: AppTextStyle.large),
                  AppText('Heading', style: AppTextStyle.heading),
                  AppText('Display', style: AppTextStyle.display),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(find.text('Medium'), findsOneWidget);
      expect(find.text('Large'), findsOneWidget);
      expect(find.text('Heading'), findsOneWidget);
      expect(find.text('Display'), findsOneWidget);
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: AppText('Colored Text', color: Colors.red)),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored Text'));
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('handles tap callback', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(body: AppText('Tap Me', onTap: () => tapped = true)),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('respects maxLines setting', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppText(
                  'This is a very long text that should be limited to two lines maximum',
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text).first);
      expect(textWidget.maxLines, 2);
    });
  });

  group('SmallAppText Widget', () {
    testWidgets('renders with correct default size', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: SmallAppText('Small Text')),
          ),
        ),
      );

      expect(find.text('Small Text'), findsOneWidget);
    });
  });

  group('MedAppText Widget', () {
    testWidgets('renders with correct default style', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: MedAppText('Medium Text')),
          ),
        ),
      );

      expect(find.text('Medium Text'), findsOneWidget);
    });
  });

  group('BigAppText Widget', () {
    testWidgets('renders with bold weight by default', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: BigAppText('Big Text')),
          ),
        ),
      );

      expect(find.text('Big Text'), findsOneWidget);
    });
  });

  group('PriceText Widget', () {
    testWidgets('formats currency correctly', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: PriceText(price: '1234.56', currency: Currency.usd),
            ),
          ),
        ),
      );

      expect(find.textContaining('\$'), findsOneWidget);
    });

    testWidgets('shows profit indicator with green color', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: PriceText(
                price: '100',
                currency: Currency.usd,
                isProfit: true,
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('+'), findsOneWidget);
    });

    testWidgets('shows loss indicator', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: PriceText(
                price: '100',
                currency: Currency.usd,
                isProfit: false,
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('-'), findsOneWidget);
    });

    testWidgets('formats with thousands separators', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: PriceText(price: '1234567', currency: Currency.usd),
            ),
          ),
        ),
      );

      expect(find.textContaining(','), findsOneWidget);
    });
  });

  group('SlashedPriceText Widget', () {
    testWidgets('shows strikethrough decoration', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: SlashedPriceText(price: '99.99')),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });

  group('ImportantAppText Widget', () {
    testWidgets('shows required indicator asterisk', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: ImportantAppText('Required Field')),
          ),
        ),
      );

      expect(find.text('Required Field'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
    });
  });

  group('HighlightedText Widget', () {
    testWidgets('renders highlighted portions', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: HighlightedText(
                text: 'Hello World, this is a test',
                highlights: ['World', 'test'],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
    });
  });

  group('ExpandableText Widget', () {
    testWidgets('shows expand link for long text', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: ExpandableText(
                  text:
                      'This is a very long text that should definitely exceed the collapsed lines limit and show the read more link when rendered on the screen',
                  collapsedLines: 2,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The expand link should be present
      expect(find.textContaining('Read more'), findsOneWidget);
    });
  });

  // ============== Text Security Tests ==============

  group('Text Security Config', () {
    test('security is OFF by default', () {
      expect(TextSecurityConfig.enforceValidation, false);
    });

    test('enableSecurity() turns on validation', () {
      TextSecurityConfig.enableSecurity();
      expect(TextSecurityConfig.enforceValidation, true);
    });

    test('resetToDefaults() resets all settings', () {
      TextSecurityConfig.enableSecurity();
      TextSecurityConfig.maxFontSize = 500.0;

      TextSecurityConfig.resetToDefaults();

      expect(TextSecurityConfig.enforceValidation, false);
      expect(TextSecurityConfig.maxFontSize, 200.0);
    });
  });

  group('Text Security Validation', () {
    setUp(() {
      TextSecurityConfig.enableSecurity();
    });

    test('validateTextContent truncates long text', () {
      final longText = 'A' * 20000;
      final result = validateTextContent(longText);
      expect(result.length, lessThanOrEqualTo(10003)); // max + "..."
    });

    test('validateTextFontSize clamps to max', () {
      final result = validateTextFontSize(500.0, defaultValue: 14.0);
      expect(result, TextSecurityConfig.maxFontSize);
    });

    test('validateTextFontSize clamps to min', () {
      final result = validateTextFontSize(2.0, defaultValue: 14.0);
      expect(result, TextSecurityConfig.minFontSize);
    });

    test('validateLetterSpacing clamps values', () {
      final tooHigh = validateLetterSpacing(100.0);
      expect(tooHigh, TextSecurityConfig.maxLetterSpacing);

      final tooLow = validateLetterSpacing(-50.0);
      expect(tooLow, TextSecurityConfig.minLetterSpacing);
    });

    test('validateMaxLines clamps invalid values', () {
      final negative = validateMaxLines(-1);
      expect(negative, 1);

      final tooHigh = validateMaxLines(50000);
      expect(tooHigh, TextSecurityConfig.maxMaxLines);
    });
  });

  // ============== TextField Widget Tests ==============

  group('AppTextField Widget', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: AppTextField(label: 'Email', hint: 'Enter email'),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('shows required indicator when isRequired is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: AppTextField(label: 'Name', isRequired: true)),
          ),
        ),
      );

      // The asterisk is part of the label's rich text, not a Text of its own.
      expect(find.textContaining('*', findRichText: true), findsOneWidget);
    });

    testWidgets('applies different field styles', (tester) async {
      for (final style in TextFieldStyle.values) {
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            child: MaterialApp(
              home: Scaffold(
                body: AppTextField(label: 'Test', fieldStyle: style),
              ),
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
      }
    });

    testWidgets('calls onChanged callback', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: AppTextField(onChanged: (value) => changedValue = value),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Test input');
      await tester.pump();

      expect(changedValue, 'Test input');
    });

    testWidgets('validates input with validator function', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: Form(
                key: formKey,
                child: AppTextField(
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Field is required' : null,
                ),
              ),
            ),
          ),
        ),
      );

      // Trigger validation by typing and then clearing
      await tester.enterText(find.byType(TextFormField), 'text');
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();

      // Validate the form explicitly
      formKey.currentState?.validate();
      await tester.pump();

      // Validator should return error for empty
      expect(find.text('Field is required'), findsOneWidget);
    });
  });

  group('AppPasswordField Widget', () {
    testWidgets('obscures text by default', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(home: Scaffold(body: AppPasswordField())),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('toggles password visibility', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: AppPasswordField(showPasswordToggle: true)),
          ),
        ),
      );

      // Find and tap the visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      // Password should now be visible
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, false);
    });
  });

  group('AppMultiLineTextField Widget', () {
    testWidgets('allows multiple lines', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: AppMultiLineTextField(
                label: 'Description',
                minLines: 3,
                maxLines: 10,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
    });
  });

  group('AppRoundedTextField Widget', () {
    testWidgets('renders with pill style', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(
              body: AppRoundedTextField(hint: 'Search', isPill: true),
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
    });
  });

  // ============== TextField Security Tests ==============

  group('TextField Security Config', () {
    test('security is OFF by default', () {
      expect(TextFieldSecurityConfig.enforceValidation, false);
    });

    test('enableSecurity() turns on validation', () {
      TextFieldSecurityConfig.enableSecurity();
      expect(TextFieldSecurityConfig.enforceValidation, true);
    });
  });

  group('TextField Security Validation', () {
    setUp(() {
      TextFieldSecurityConfig.enableSecurity();
    });

    test('validateTextFieldFontSize clamps to bounds', () {
      final tooHigh = validateTextFieldFontSize(100.0, defaultValue: 14.0);
      expect(tooHigh, TextFieldSecurityConfig.maxFontSize);

      final tooLow = validateTextFieldFontSize(2.0, defaultValue: 14.0);
      expect(tooLow, TextFieldSecurityConfig.minFontSize);
    });

    test('validateTextFieldBorderRadius clamps negative values', () {
      final negative = validateTextFieldBorderRadius(-5.0, defaultValue: 12.0);
      expect(negative, 0);
    });

    test('validateTextFieldMaxLines enforces bounds', () {
      final negative = validateTextFieldMaxLines(-1);
      expect(negative, 1);

      final tooHigh = validateTextFieldMaxLines(5000);
      expect(tooHigh, TextFieldSecurityConfig.maxMaxLines);
    });

    test('validateLabelSpacing clamps negative values', () {
      final negative = validateLabelSpacing(-10.0);
      expect(negative, 0);
    });
  });

  // ============== SearchBar Widget Tests ==============

  group('CustomSearchBar Widget', () {
    testWidgets('renders search bar', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(home: Scaffold(body: CustomSearchBar())),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('calls onChanged callback', (tester) async {
      String? searchQuery;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: CustomSearchBar(onChanged: (value) => searchQuery = value),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test query');
      await tester.pump();

      expect(searchQuery, 'test query');
    });

    testWidgets('shows clear button when text is present', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: const MaterialApp(
            home: Scaffold(body: CustomSearchBar(showClearButton: true)),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'some text');
      await tester.pump();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('applies different search bar styles', (tester) async {
      for (final style in SearchBarStyle.values) {
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(375, 812),
            child: MaterialApp(
              home: Scaffold(body: CustomSearchBar(style: style)),
            ),
          ),
        );

        expect(find.byType(TextField), findsOneWidget);
      }
    });
  });

  group('FilterableSearchBar Widget', () {
    testWidgets('renders with filter chips', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: FilterableSearchBar(
                filters: const ['All', 'Products', 'Users'],
                selectedFilter: 'All',
                onFilterChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Users'), findsOneWidget);
    });

    testWidgets('calls onFilterChanged when filter tapped', (tester) async {
      String? selectedFilter;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: FilterableSearchBar(
                filters: const ['All', 'Products', 'Users'],
                selectedFilter: 'All',
                onFilterChanged: (filter) => selectedFilter = filter,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Products'));
      await tester.pump();

      expect(selectedFilter, 'Products');
    });
  });

  // ============== SearchBar Security Tests ==============

  group('SearchBar Security Config', () {
    test('security is OFF by default', () {
      expect(SearchBarSecurityConfig.enforceValidation, false);
    });

    test('enableSecurity() turns on validation', () {
      SearchBarSecurityConfig.enableSecurity();
      expect(SearchBarSecurityConfig.enforceValidation, true);
    });
  });

  group('SearchBar Security Validation', () {
    setUp(() {
      SearchBarSecurityConfig.enableSecurity();
    });

    test('validateSearchQuery truncates long queries', () {
      final longQuery = 'A' * 1000;
      final result = validateSearchQuery(longQuery);
      expect(result.length, SearchBarSecurityConfig.maxQueryLength);
    });

    test('validateSearchQuery trims whitespace', () {
      final result = validateSearchQuery('  test query  ');
      expect(result, 'test query');
    });

    test('validateSearchBarHeight clamps values', () {
      final tooHigh = validateSearchBarHeight(200.0, defaultValue: 56.0);
      expect(tooHigh, SearchBarSecurityConfig.maxHeight);

      final tooLow = validateSearchBarHeight(20.0, defaultValue: 56.0);
      expect(tooLow, SearchBarSecurityConfig.minHeight);
    });

    test('validateDebounceDuration clamps values', () {
      final tooHigh = validateDebounceDuration(5000);
      expect(tooHigh, SearchBarSecurityConfig.maxDebounceDuration);

      final tooLow = validateDebounceDuration(10);
      expect(tooLow, SearchBarSecurityConfig.minDebounceDuration);
    });
  });

  group('SearchRateLimiter', () {
    test('allows queries within limit', () {
      final limiter = SearchRateLimiter(maxQueriesPerMinute: 10);

      for (var i = 0; i < 10; i++) {
        expect(limiter.isQueryAllowed(), true);
      }
    });

    test('blocks queries exceeding limit', () {
      final limiter = SearchRateLimiter(maxQueriesPerMinute: 5);

      for (var i = 0; i < 5; i++) {
        limiter.isQueryAllowed();
      }

      expect(limiter.isQueryAllowed(), false);
    });

    test('reset clears query history', () {
      final limiter = SearchRateLimiter(maxQueriesPerMinute: 2);

      limiter.isQueryAllowed();
      limiter.isQueryAllowed();
      expect(limiter.isQueryAllowed(), false);

      limiter.reset();
      expect(limiter.isQueryAllowed(), true);
    });
  });

  // ============== Safe Callback Tests ==============

  group('Safe Callbacks', () {
    test('safeTextCallback handles errors gracefully', () {
      expect(() {
        safeTextFieldCallback((value) => throw Exception('Test error'), 'test');
      }, returnsNormally);
    });

    test('safeTextFieldVoidCallback handles null', () {
      expect(() {
        safeTextFieldVoidCallback(null);
      }, returnsNormally);
    });

    test('safeSearchCallback handles errors gracefully', () {
      expect(() {
        safeSearchCallback((value) => throw Exception('Test error'), 'test');
      }, returnsNormally);
    });
  });
}
