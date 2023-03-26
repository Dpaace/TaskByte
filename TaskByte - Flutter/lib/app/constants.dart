class Constant {
  // static const String baseURL = "http://10.0.2.2:3000/";

  // For Connecting to localhost through real device
  static const String baseURL = "http://192.168.1.80:3000/";

  // For unit test use localhost URL
  // static const String baseURL = "http://localhost:3000/";

  // -------------User URL------------
  static const String userLoginURL = "user/login";
  static const String userRegisterURL = "user/signup";
  static const String getAllUsersURL = "user/getAll/";
  static const String getAllFriendsURL = "user/getFriends/";
  static const String getAllGroupsURL = "group";
  static const String deleteGroupByID = "group/delGroupByID";
  static const String getUserDetails = "user/getUserData";
  static const String updateUserProfile = "user/profile";
  static const String updateUserProfilePicture = "user/profilePicture";

  static const String getAllPostsURL = "post";
  static const String deletePostByID = "post/delPostByID";

  static const String comment = "post/comment/add/";
  static const String getAllPostComment = "post/comment/get/";

  // static const String userImageURL = "http://10.0.2.2:3000/uploads/";
  static const String userImageURL = "http://192.168.1.80:3000/uploads/";

  // For storing token or you can store token in shared preferences
  static String token = "";
}
