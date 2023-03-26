import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/data_source/remote_data_source/user_data_source.dart';
import 'package:task_byte/model/user_model.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "login":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2VlNWUyNGI4YjM5NGZlN2IzNDE4YmUiLCJlbWFpbCI6ImRpcGVzaG5lcGFsaTc2N0BnbWFpbC5jb20iLCJpYXQiOjE2NzY1NjYwODAsImV4cCI6MTY3NjY1MjQ4MH0.17jJ-jQXbHS7yAneotJaOzOVRaBNaP0u_cn5Xj-yO_I"
    });
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String token = pref.getString('login')!;
    // Constant.token =
    //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2ViM2IwZjdmZjYxYTEwM2JhZGQ4MjciLCJlbWFpbCI6ImJydWNlYmFubmVyQGdtYWlsLmNvbSIsImlhdCI6MTY3NjM2MDQ3NCwiZXhwIjoxNjc2NDQ2ODc0fQ.aqoupzIQ4sw_K7A2qOwgm07dreHfK0jq_B75olnROa4";
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('User should be able to log in', () async {
    bool expectedResult = true;
    String email = "dipeshnepali767@gmail.com";
    String password = "password";
    bool actualResult = await UserRemoteDataSource().loginUser(email, password);
    expect(actualResult, expectedResult);
  });
  test('User should not be able to log in', () async {
    bool expectedResult = false;
    String email = "dipeshnepali17aa67@gmail.com";
    String password = "password";
    bool actualResult = await UserRemoteDataSource().loginUser(email, password);
    expect(actualResult, expectedResult);
  });
  test('User should be able to register', () async {
    int expectedResult = 1;
    File? img;
    User user = User(
      firstName: "Dipesh",
      lastName: "Nepali",
      email: "testaaaa@gmail.com",
      password: "password",
    );
    int actualResult = await UserRemoteDataSource().registerUser(img, user);
    expect(actualResult, expectedResult);
  });

  test('User should not be able to register', () async {
    int expectedResult = 0;
    File? img;
    User user = User(
      firstName: "Dipesh",
      lastName: "Nepali",
      email: "test123@gmail.com",
      password: "password",
    );
    int actualResult = await UserRemoteDataSource().registerUser(img, user);
    expect(actualResult, expectedResult);
  });

  test('Get All Users', () async {
    List<User> actualResult = await UserRemoteDataSource().getAllUsers();
    expect(actualResult, isNotEmpty);
  });

  test('Get User Details', () async {
    User? actualResult = await UserRemoteDataSource().getUserDetails();
    expect(actualResult, isNotNull);
  });

  test('Get All Friends', () async {
    List<User> actualResult = await UserRemoteDataSource().getAllFriends();
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to Update Profile', () async {
    int expectedResult = 1;
    User user = User(
      firstName: "Bruce",
      lastName: "Banner",
      phoneNumber: "5251405",
      interests: "Being Hulk",
      dateOfBirth: "11/14/2000",
    );
    int actualResult = await UserRemoteDataSource().updateUserProfile(user);
    expect(actualResult, expectedResult);
  });
}

// flutter test --coverage ./test/unit_test/user_test.dart 
// flutter pub run test_cov_console
