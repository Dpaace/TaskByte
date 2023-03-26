import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/data_source/remote_data_source/response/comment_response.dart';
import 'package:task_byte/helper/http_service.dart';
import 'package:task_byte/model/comments_model.dart';

class CommentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addComment(String postId, Comment comment) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String token = pref.getString('login')!;

      Response response = await _httpServices.post(
        Constant.comment,
        queryParameters: {
          'id': postId,
        },
        data: {
          "content": comment.content,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Comment>> getAllPostComments(String postId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String token = pref.getString('login')!;

      Response response = await _httpServices.get(
        Constant.getAllPostComment,
        queryParameters: {
          'id': postId,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      List<Comment> lstPostComments = [];
      if (response.statusCode == 200) {
        CommentResponse postResponse = CommentResponse.fromJson(response.data);
        lstPostComments = postResponse.data!;
        return lstPostComments;
      } else {
        return [];
      }
    } catch (e) {
      // return [];
      throw Exception(e.toString());
    }
  }

}

final commentProvider =
    Provider<CommentRemoteDataSource>((ref) => CommentRemoteDataSource());
