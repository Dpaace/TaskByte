import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_byte/app/routes.dart';
import 'package:task_byte/screen/login_screen.dart';
import 'package:task_byte/screen/register_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Enter Registration credentials and Register",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          home: const RegisterScreen(),
          routes: getAppRoutes,
        ),
      ),
    );

    // Finder txtFname = find.byKey(const ValueKey('txtFname'));
    // await tester.enterText(txtFname, 'Dipesh');
    // Finder txtLname = find.byKey(const ValueKey('txtLname'));
    // await tester.enterText(txtLname, 'Nepali');
    // Finder txtEmail = find.byKey(const ValueKey('txtEmail'));
    // await tester.enterText(txtEmail, 'test1@gmail.com');
    // Finder txtPassword = find.byKey(const ValueKey('txtPassword'));
    // await tester.enterText(txtPassword, 'password');
    Finder btnContinue = find.byKey(const ValueKey('btnRegister'));
    await tester.tap(btnContinue);

    await tester.pumpAndSettle(const Duration(seconds: 3));
    // await tester.pumpAndSettle();
    // await tester.pump();
    // Finder loginScreen = find.text("Welcome");
    Finder login = find.byType(LoginScreen);
    expect(login, findsOneWidget);
  });
}
