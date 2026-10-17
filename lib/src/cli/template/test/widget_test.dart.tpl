import 'package:flutter_test/flutter_test.dart';
import 'package:{{package}}/main.dart';

void main() {
  testWidgets('starts on the splash screen, then asks to sign in', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('{{app}}'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
