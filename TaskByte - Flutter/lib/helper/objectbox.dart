import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/model/user_story_model.dart';
import 'package:task_byte/objectbox.g.dart';

UserStory story1 = UserStory(
  "assets/images/story_one.png",
  "assets/images/profile.png",
  "Dipesh",
);
UserStory story2 = UserStory(
  "assets/images/story_two.png",
  "assets/images/profile.png",
  "Nepali",
);
// User user1 = User(
//     firstName: "Dipesh",
//     lastName: "Nepali",
//     image: "assets/images/me.jpg",
//     email: "test1@gmail.com",
//     password: "password");

// UserPost status1 = UserPost(
//   postTime: "12:00 AM",
//   description: "My First Post",
//   image: "assets/images/story_one.png",
// );
// UserPost status1 = UserPost(
//   // "111",
//   "12:00 AM",
//   "First Post",
//   "This is my photo",
//   "assets/images/story_one.png",
// );

Groups group1 = Groups(
  groupName: "First Group",
);

UserPost status1 = UserPost(
  postId: "000",
  postTime: "3/1/2023",
  title: "ObjectBox Post",
  description: "From Object Box",
  image: "assets/images/story_one.png",
);

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<UserStory> _userStory;
  late final Box<UserPost> _userPost;
  late final Box<Groups> _groups;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _userStory = Box<UserStory>(_store);
    _userPost = Box<UserPost>(_store);
    _groups = Box<Groups>(_store);
    insertUserStories();
    insertUserStatus();
    insertUsers();
  }

  addAllPosts(List<UserPost> lstPosts) {
    for (var item in lstPosts) {
      if (_userPost
              .query(UserPost_.postId.equals(item.postId!))
              .build()
              .findFirst() ==
          null) {
        _userPost.put(item);
      }
    }
  }

  void insertUsers() {
    List<User> lstUsers = getAllUsers();
    if (lstUsers.isEmpty) {
      // addUserStory(UserStory(sImage, sUserImage, sUserName));
      addUser(User(
          firstName: "Dipesh",
          lastName: "Nepali",
          image: "assets/images/me.jpg"));
      addUser(User(
          firstName: "Raj", lastName: "Magar", image: "assets/images/me.jpg"));
      addUser(User(
          firstName: "Shyam",
          lastName: "Shrestha",
          image: "assets/images/me.jpg"));
      addUser(User(
        firstName: "Harry",
        lastName: "Potter",
        image: "assets/images/me.jpg",
      ));
      addUser(
        User(
            firstName: "Tony",
            lastName: "Stark",
            image: "assets/images/me.jpg"),
      );
    }
  }

  // Insert User Stories
  void insertUserStories() {
    List<UserStory> lstUserStories = getAllUserStories();
    if (lstUserStories.isEmpty) {
      // addUserStory(UserStory(sImage, sUserImage, sUserName));
      addUserStory(story1);
      addUserStory(story2);
    }
  }

  // Insert Userstatus/Post
  void insertUserStatus() {
    List<UserPost> lstUserStatus = getAllUserStatus();
    if (lstUserStatus.isEmpty) {
      // addUserStory(UserStory(sImage, sUserImage, sUserName));
      // addUserStatus(status1);
    }
  }

  // Insert UsersGroups
  void insertUserGroups() {
    List<Groups> lstUserGroups = getAllGroups();
    if (lstUserGroups.isEmpty) {
      // addUserStory(UserStory(sImage, sUserImage, sUserName));
      addUserGroups(group1);
    }
  }

  // Initialization of ObjectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/taskbyte',
    );
    return ObjectBoxInstance(store);
  }

  static Future<void> deleteDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    Directory('${dir.path}/taskbyte').deleteSync(
      recursive: true,
    );
  }

  // ----------User Groups Queries------------
  int addUserGroups(Groups group) {
    return _groups.put(group);
  }

  List<Groups> getAllGroups() {
    return _groups.getAll();
  }

  // ----------User Post Queries------------
  int addUserStatus(UserPost userStatus) {
    return _userPost.put(userStatus);
  }

  List<UserPost> getAllUserStatus() {
    return _userPost.getAll();
  }

  // ----------User Story Queries------------

  int addUserStory(UserStory userStory) {
    return _userStory.put(userStory);
  }

  List<UserStory> getAllUserStories() {
    return _userStory.getAll();
  }

  // ----------User Queries------------
  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUsers() {
    return _user.getAll();
  }

  // Login User
  // bool loginUser(String email, String password) {
  //   final userData = _user
  //       .query(User_.email.equals(email) & User_.password.equals(password))
  //       .build()
  //       .findFirst();
  //   print("User Data Coming:--$userData");
  //   return userData == null ? false : true;
  // }

  User? loginUser(String email, String password) {
    return _user
        .query(User_.email.equals(email) & User_.password.equals(password))
        .build()
        .findFirst();
  }

  User? checkUser(String username, String email) {
    return _user
        .query(User_.firstName.equals(username) & User_.email.equals(email))
        .build()
        .findFirst();
  }
}
