import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_byte/screen/login_screen.dart';
import 'package:task_byte/screen/register_screen.dart';

class LoginRegisterLandingScreen extends StatelessWidget {
  const LoginRegisterLandingScreen({super.key});

  static const String route = "loginRegisterLandingScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/TaskByte_logo.svg',
                    height: 150,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.route);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.route);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      child: const Text(
                        "LOG IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
