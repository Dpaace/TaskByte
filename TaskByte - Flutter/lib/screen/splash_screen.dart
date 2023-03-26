import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_byte/screen/login_register_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String route = "splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, LoginRegisterLandingScreen.route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/TaskByte_logo.svg',
              height: 150,
              width: 200,
            ),
            // const Text("Splash Screen"),
            const SizedBox(
              height: 8,
            ),
            const CircularProgressIndicator(color: Colors.green),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "v1.0.0",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
