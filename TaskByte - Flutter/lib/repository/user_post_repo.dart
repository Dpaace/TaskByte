import 'dart:io';

import 'package:task_byte/data_source/local_data_source/user_status_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/post_data_souce.dart';
import 'package:task_byte/model/post_model.dart';

abstract class UserPostRepository {
  Future<int> addUserStatus(UserPost post);
  Future<List<UserPost>> getAllLocalUserStatus();

  //Working with Remote Connection
  Future<int> addUserPost(File? file, UserPost post);
  Future<List<UserPost>> getAllRemoteUserPosts();

  Future<int> deleteUserPost(String postId);

  // Future<List<UserPost>> getAllUserPosts();
}

class UserPostRepositoryImpl extends UserPostRepository {
  @override
  Future<int> addUserStatus(UserPost post) {
    return UserStatusDataSource().addUserStatus(post);
  }

  @override
  Future<List<UserPost>> getAllLocalUserStatus() {
    return UserStatusDataSource().getAllUserStatus();
  }

  //Adding post to remote connection
  @override
  Future<int> addUserPost(File? file, UserPost post) {
    return PostRemoteDataSource().addPost(file, post);
  }

  @override
  Future<List<UserPost>> getAllRemoteUserPosts() async {
    // return PostRemoteDataSource().getAllUserPosts();
    List<UserPost> lstPosts = [];
    lstPosts = await PostRemoteDataSource().getAllUserPosts();
    await UserStatusDataSource().addAllPosts(lstPosts);
    return lstPosts;
  }

  @override
  Future<int> deleteUserPost(String postId) {
    return PostRemoteDataSource().deletePost(postId);
  }

  // @override
  // Future<List<UserPost>> getAllUserPosts() async {
  //   bool status = await NetworkConnectivity.isOnline();
  //   List<UserPost> lstPosts = [];
  //   if (status) {
  // lstPosts = await PostRemoteDataSource().getAllUserPosts();
  // await UserStatusDataSource().addAllPosts(lstPosts);
  // return lstPosts;
  //   } else {
  //     return UserStatusDataSource().getAllUserStatus();
  //   }
  // }
}
