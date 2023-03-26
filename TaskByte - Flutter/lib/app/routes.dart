import 'package:flutter/material.dart';
import 'package:task_byte/screen/login_screen.dart';

import '../screen/comment_screen.dart';
import '../screen/google_maps/google_map_screen.dart';
import '../screen/home_page.dart';
import '../screen/login_register_main.dart';
import '../screen/message_screen.dart';
import '../screen/post_upload_screen.dart';
import '../screen/profile_picture_update_screen.dart';
import '../screen/register_screen.dart';
import '../screen/shuffle.dart';
import '../screen/splash_screen.dart';
import '../screen/update_profile_screen.dart';
import '../screen/wearos/wear_dashboard.dart';
import '../screen/wearos/wear_login.dart';
import '../widgets/profile_widget.dart';

var getAppRoutes = <String, WidgetBuilder>{
  SplashScreen.route: (context) => const SplashScreen(),
  LoginRegisterLandingScreen.route: (context) =>
      const LoginRegisterLandingScreen(),
  LoginScreen.route: (context) => const LoginScreen(),
  RegisterScreen.route: (context) => const RegisterScreen(),
  HomePage.route: (context) => const HomePage(
        title: "taskbyte",
      ),
  ProfileWidget.route: (context) => const ProfileWidget(),
  WearOSLoginScreen.route: (context) => const WearOSLoginScreen(),
  WearOsDashboard.route: (context) => const WearOsDashboard(),
  GoogleMapScreen.route: (context) => const GoogleMapScreen(),
  PostUploadScreen.route: (context) => const PostUploadScreen(),
  UpdateProfileScreen.route: (context) => const UpdateProfileScreen(),
  ProfilePictureUpdateScreen.route: (context) =>
      const ProfilePictureUpdateScreen(),
  CommentScreen.route: (context) => const CommentScreen(),
  MessageScreen.route: (context) => const MessageScreen(),
  Shuffle.route: (context) => const Shuffle(),
};
