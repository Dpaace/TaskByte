import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_byte/app/theme.dart';
import 'package:task_byte/screen/login_screen.dart';

void main() {
  testWidgets("Should have a title", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter for learning',
        theme: getApplicationTheme(),
        home: const LoginScreen(),
        // initialRoute: '/loginScreen',
      ),
    );
    Finder title = find.text("Welcome\nBack");
    expect(title, findsOneWidget);
  });
}
