import 'package:flutter/material.dart';
import 'package:task_byte/app/theme.dart';
import 'package:task_byte/controllers/socket_controller.dart';

import '../screen/login_screen.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SocketController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter for learning',
        theme: getApplicationTheme(),
        initialRoute: LoginScreen.route,
        routes: getAppRoutes,
      ),
    );
  }
}
