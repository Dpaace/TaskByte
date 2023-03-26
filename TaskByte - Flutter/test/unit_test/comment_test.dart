import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/data_source/remote_data_source/comment_data_source.dart';
import 'package:task_byte/model/comments_model.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "login":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2Y5MTYxMDM4NDUzOTAwMWEwMmJiYTQiLCJlbWFpbCI6Im9jZWFuQGdtYWlsLmNvbSIsImlhdCI6MTY3NzUxMzQyMSwiZXhwIjoxNjc3NTk5ODIxfQ.5liMnMWv_oZBnkCwFghQQSzPCa_NSjm3j4LrmAc7Aus"
    });
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('Get All Posts', () async {
    String postId = "63f91622384539001a02bba8";
    List<Comment> actualResult =
        await CommentRemoteDataSource().getAllPostComments(postId);
    expect(actualResult, isNotEmpty);
  });

  test('User should be able to add comment in a post', () async {
    int expectedResult = 1;
    String postId = "63f91622384539001a02bba8";

    Comment comment = Comment(
      content: "test comment",
    );
    int actualResult =
        await CommentRemoteDataSource().addComment(postId, comment);
    expect(actualResult, expectedResult);
  });
}
