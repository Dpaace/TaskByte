import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/data_source/remote_data_source/groups_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/post_data_souce.dart';
import 'package:task_byte/data_source/remote_data_source/user_data_source.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/model/user_model.dart';

final userDataProvider = FutureProvider<List<User>>((ref) async {
  return ref.watch(userProvider).getAllUsers();
});

final postDataProvider = FutureProvider<List<UserPost>>((ref) async {
  return ref.watch(postProvider).getAllUserPosts();
});

final groupDataProvider = FutureProvider<List<Groups>>((ref) async {
  return ref.watch(groupProvider).getGroups();
});

// final commentDataProvider = FutureProvider<List<Comment>>((ref) async {
//   return ref.watch(commentProvider).getAllPostComments(postId);
// });
