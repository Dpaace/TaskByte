import 'dart:io';

import 'package:task_byte/data_source/local_data_source/user_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/user_data_source.dart';
import 'package:task_byte/model/user_model.dart';

abstract class UserRepository {
  // User
  Future<List<User>> getLocalUsers();
  Future<List<User>> getRemoteUsers();
  Future<int> addUser(User user);
  // Future<bool> loginUser(String email, String password);
  Future<bool> loginUser(String email, String password);
  Future<int> registerUser(File? file, User user);
  Future<bool> checkUser(String username, String email);

  Future<int> updateUserProfile(User user);
  Future<int> updateUserProfilePicture(File? file);

  Future<User?> getUserDetails();
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(User user) {
    return UserDataSource().addUser(user);
  }

  @override
  Future<List<User>> getLocalUsers() {
    return UserDataSource().getUsers();
  }

  @override
  Future<List<User>> getRemoteUsers() {
    return UserRemoteDataSource().getAllFriends();
  }

  // @override
  // Future<bool> loginUser(String email, String password) {
  //   return UserDataSource().loginUser(email, password);
  // }

  @override
  Future<bool> loginUser(String email, String password) {
    return UserRemoteDataSource().loginUser(email, password);
  }

  // @override
  // Future<bool> registerUser(String username, String email, String password) {
  //   return UserRemoteDataSource().registerUser(username, email, password);
  // }

  @override
  Future<int> registerUser(File? file, User user) {
    return UserRemoteDataSource().registerUser(file, user);
  }

  @override
  Future<bool> checkUser(String username, String email) {
    return UserDataSource().checkUser(username, email);
  }

  @override
  Future<int> updateUserProfile(User user) {
    return UserRemoteDataSource().updateUserProfile(user);
  }

  @override
  Future<int> updateUserProfilePicture(File? file) {
    return UserRemoteDataSource().updateUserProfilePicture(file);
  }

  @override
  Future<User?> getUserDetails() {
    return UserRemoteDataSource().getUserDetails();
  }
}
