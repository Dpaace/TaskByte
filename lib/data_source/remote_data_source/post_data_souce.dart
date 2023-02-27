import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/data_source/remote_data_source/response/post_response.dart';
import 'package:task_byte/helper/http_service.dart';
import 'package:task_byte/model/post_model.dart';

class PostRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> deletePost(String postId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('login')!;

      Response response = await _httpServices.delete(
        Constant.deletePostByID,
        queryParameters: {
          'id': postId,
        },
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> addPost(File? file, UserPost post) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String token = pref.getString('login')!;

      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }

      FormData formData = FormData.fromMap({
        'title': post.title,
        'description': post.description,
        'image': image,
      });

      Response response = await _httpServices.post(
        Constant.getAllPostsURL,
        data: formData,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
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

  Future<List<UserPost>> getAllUserPosts() async {
    try {
      Response response = await _httpServices.get(Constant.getAllPostsURL);
      List<UserPost> lstUserPosts = [];
      if (response.statusCode == 200) {
        PostResponse postResponse = PostResponse.fromJson(response.data);
        lstUserPosts = postResponse.data!;
        return lstUserPosts;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

final postProvider =
    Provider<PostRemoteDataSource>((ref) => PostRemoteDataSource());
