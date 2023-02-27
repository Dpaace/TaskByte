import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/data_source/remote_data_source/response/login_response.dart';
import 'package:task_byte/data_source/remote_data_source/response/user_details_response.dart';
import 'package:task_byte/data_source/remote_data_source/response/user_response.dart';
import 'package:task_byte/helper/http_service.dart';
import 'package:task_byte/model/user_model.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<User?> getUserDetails() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String token = pref.getString('login')!;
      Response response = await _httpServices.get(
        Constant.getUserDetails,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      User? user;
      if (response.statusCode == 200) {
        UserDetailsResponse userResponse =
            UserDetailsResponse.fromJson(response.data);
        user = userResponse.data!;
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        // data: formData,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        // Constant.token = loginResponse.token!;
        print(loginResponse.token!);

        // Store the token value inside the shared preference
        saveToken(loginResponse.token!);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      // throw Exception(e.toString());
      return false;
    }
  }

  void saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('login', "Bearer $token");
    // await pref.setString('login', token);
  }

  Future<int> registerUser(File? file, User user) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(
            "image",
            mimeType!.split("/")[1],
          ),
        );
      }
      FormData formData = FormData.fromMap({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'dateOfBirth': user.dateOfBirth,
        'phoneNumber': user.phoneNumber,
        'image': image,
        'email': user.email,
        'password': user.password,
      });

      Response response = await _httpServices.post(
        Constant.userRegisterURL,
        data: formData,
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

  Future<List<User>> getAllUsers() async {
    try {
      Response response = await _httpServices.get(Constant.getAllUsersURL);
      List<User> lstUsers = [];
      if (response.statusCode == 201) {
        UserResponse userResponse = UserResponse.fromJson(response.data);
        lstUsers = userResponse.data!;
        return lstUsers;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<User>> getAllFriends() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('login')!;

      Response response = await _httpServices.get(
        Constant.getAllFriendsURL,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": token,
          },
        ),
      );
      List<User> lstUsers = [];
      if (response.statusCode == 201) {
        UserResponse userResponse = UserResponse.fromJson(response.data);
        lstUsers = userResponse.data!;
        return lstUsers;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<int> updateUserProfile(User user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('login')!;

      // FormData formData = FormData.fromMap({
      //   'firstName': user.firstName,
      //   'lastName': user.lastName,
      //   'dateOfBirth': user.dateOfBirth,
      //   'phoneNumber': user.phoneNumber,
      //   'interests': user.interests
      // });

      Response response = await _httpServices.put(
        Constant.updateUserProfile,
        data: {
          'firstName': user.firstName,
          'lastName': user.lastName,
          'dateOfBirth': user.dateOfBirth,
          'phoneNumber': user.phoneNumber,
          'interests': user.interests
        },
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

  Future<int> updateUserProfilePicture(File? file) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('login')!;

      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(
            "image",
            mimeType!.split("/")[1],
          ),
        );
      }

      FormData formData = FormData.fromMap({
        'image': image,
      });

      Response response = await _httpServices.put(
        Constant.updateUserProfilePicture,
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
}

final userProvider =
    Provider<UserRemoteDataSource>((ref) => UserRemoteDataSource());
