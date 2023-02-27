import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/data_source/remote_data_source/groups_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/post_data_souce.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/model/post_model.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "login":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2VlNWUyNGI4YjM5NGZlN2IzNDE4YmUiLCJlbWFpbCI6ImRpcGVzaG5lcGFsaTc2N0BnbWFpbC5jb20iLCJpYXQiOjE2NzY1NjYwODAsImV4cCI6MTY3NjY1MjQ4MH0.17jJ-jQXbHS7yAneotJaOzOVRaBNaP0u_cn5Xj-yO_I"
    });
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('Get All Posts', () async {
    List<UserPost> actualResult =
        await PostRemoteDataSource().getAllUserPosts();
    expect(actualResult, isNotEmpty);
  });
  test('Get All Groups', () async {
    List<Groups> actualResult = await GroupsRemoteDataSource().getGroups();
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to add post', () async {
    int expectedResult = 1;
    File? img;
    UserPost post = UserPost(
      title: "Test Post",
      description: "Is this added",
    );
    int actualResult = await PostRemoteDataSource().addPost(img, post);
    expect(actualResult, expectedResult);
  });

  test('User should be able to delete post', () async {
    int expectedResult = 1;
    String postId = "63eb4a3f7ff61a103badd85d";
    int actualResult = await PostRemoteDataSource().deletePost(postId);
    expect(actualResult, expectedResult);
  });
}

// flutter test --coverage ./test/unit_test/user_test.dart 
// flutter pub run test_cov_console
