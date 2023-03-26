import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/repository/user_repo.dart';
import 'package:task_byte/screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  File? _img;

  _registerUser() async {
    User user = User(
      firstName: _fnameController.text,
      lastName: _lnameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    int registered = await UserRepositoryImpl().registerUser(_img, user);
    _showMessage(registered);
  }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text(
          "User Added Successfully",
        ),
        onClose: () {
          Navigator.pushNamed(context, LoginScreen.route);
        },
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text(
          "Error in Adding User",
        ),
      ).show(context);
    }
  }

  InputDecoration _getInputDecorationStyle(
      {String? hintText, String? labelText}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  InputDecoration _getInputDecorationStylePassword(
      {String? hintText, String? labelText}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: const Color.fromARGB(255, 144, 151, 164),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 70),
              child: const Text(
                "Create\nAccount",
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
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: 35,
                  right: 35,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('txtFname'),
                        controller: _fnameController,
                        decoration: _getInputDecorationStyle(
                          labelText: "Enter First Name",
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        key: const Key('txtLname'),
                        controller: _lnameController,
                        decoration: _getInputDecorationStyle(
                          labelText: "Enter Last Name",
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        key: const Key('txtEmail'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _getInputDecorationStyle(
                          labelText: "Enter Email",
                          hintText: "example@gmail.com",
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
                        key: const Key('txtPassword'),
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: _getInputDecorationStylePassword(
                          labelText: "Enter Password",
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
                        key: const ValueKey('btnRegister'),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              // _saveUser();
                              _registerUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
