import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_byte/repository/user_repo.dart';
import 'package:task_byte/screen/wearos/wear_dashboard.dart';
import 'package:wear/wear.dart';

class WearOSLoginScreen extends StatefulWidget {
  const WearOSLoginScreen({super.key});

  static const String route = "wearOSloginScreen";

  @override
  State<WearOSLoginScreen> createState() => _WearOSLoginScreenState();
}

class _WearOSLoginScreenState extends State<WearOSLoginScreen> {
  final _globalKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController();
  final _passwordController = TextEditingController();

  _login() async {
    try {
      bool islogin = await UserRepositoryImpl()
          .loginUser(_emailController.text, _passwordController.text);
      if (islogin) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, WearOsDashboard.route);

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Logged In",
            body:
                "You are now logged in to your account from your smart wearos watch!",
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Either username or password is incorrect",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: "Error : ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.transparent,
        textColor: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          // decoration: const InputDecoration(
                          //   border: OutlineInputBorder(),
                          //   labelText: "Enter first number",
                          // ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          // decoration: const InputDecoration(
                          //   border: OutlineInputBorder(),
                          //   labelText: "Enter second number",
                          // ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              "Login",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
