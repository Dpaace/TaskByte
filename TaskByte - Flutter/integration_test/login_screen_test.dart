import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_byte/app/routes.dart';
import 'package:task_byte/screen/TestDshboard.dart';
import 'package:task_byte/screen/login_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Enter login credentials and login", (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          // initialRoute: '/',
          home: const LoginScreen(),
          routes: getAppRoutes,
        ),
      ),
    );

    // Finder txtEmail = find.byKey(const ValueKey('txtEmail'));
    // await tester.enterText(txtEmail, 'dipeshnepali767@gmail.com');
    // Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
    // await tester.enterText(txtPassword, 'password');
    Finder btnContinue = find.byKey(const ValueKey('btnContinue'));
    await tester.tap(btnContinue);

    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    // await tester.pumpAndSettle();
    // await tester.pump();
    Finder homepage = find.byType(TestDashBoard);
    expect(homepage, findsOneWidget);

    // expect(find.text("taskbyte"), findsOneWidget);
  });
}
