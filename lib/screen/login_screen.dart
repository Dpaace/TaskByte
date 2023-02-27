import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/repository/user_repo.dart';
import 'package:task_byte/screen/home_page.dart';
import 'package:task_byte/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'dipeshnepali767@gmail.com');
  final _passwordController = TextEditingController(text: 'password');
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  // Check Shared Preferences for logged in user
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    //Here we check if user already logged in or credential already available
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) => const LoginScreen(),
      //     ),
      //     (route) => false);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, HomePage.route);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  _loginUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    print("The email is: $email and password is: $password");

    final isLogin = await UserRepositoryImpl().loginUser(email, password);
    _showMessage(isLogin);
  }

  _showMessage(bool checkLogin) {
    checkLogin == true
        ? MotionToast.success(
            description: const Text("Logged In successfully"),
            onClose: () {
              Navigator.pushReplacementNamed(context, HomePage.route);
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 1,
                  channelKey: 'basic_channel',
                  title: "Logged In",
                  body: "You are now logged in to your account!",
                ),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => const DashBoardScreen(),
              //   ),
              // );
            },
          ).show(context)
        : MotionToast.error(
            description: const Text("Invalid Email or Password"),
          ).show(context);
  }
  // _showMessage(bool checkLogin) {
  //   checkLogin == false
  //       ? MotionToast.error(
  //           description: const Text("Invalid Email or Password"),
  //         ).show(context)
  //       : MotionToast.success(
  //           description: const Text("Logged In successfully"),
  //           onClose: () {
  //             Navigator.pushReplacementNamed(context, '/homePage');
  //           },
  //         ).show(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 60,
                top: 100,
              ),
              child: const Text(
                "Welcome\nBack",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.38,
                  left: 35,
                  right: 35,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('txtEmail'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "example@gmail.com",
                          labelText: 'Enter Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        key: const ValueKey('txtPassword'),
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          labelText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        key: const ValueKey('btnContinue'),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _loginUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Forgotten Your Password?",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.route);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
