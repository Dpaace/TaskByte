import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shake/shake.dart';
import 'package:task_byte/widgets/friends_widget.dart';
import 'package:task_byte/widgets/groups_widget.dart';
import 'package:task_byte/widgets/menu_widget.dart';
import 'package:task_byte/widgets/profile_widget.dart';

import '../widgets/home_widget.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  static const String route = "homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// Check whether the notification is enabled or not
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  ShakeDetector? detector;
  @override
  void initState() {
    // _checkNotificationEnabled();
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        // SharedPreferences pref = await SharedPreferences.getInstance();
        // await pref.clear();
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Log Out",
            body: "You are logged out of your account!",
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
          context,
          LoginScreen.route,
        );
      },
    );
  }

  @override
  void dispose() {
    detector!.stopListening();

    super.dispose();
  }

  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          // key: const ValueKey('txtTitle'),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status Bar Color
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: Text(
            widget.title,
            // "taskbyte",
            style: const TextStyle(
              color: Color(0xff1773EA),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 10.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black12,
                child: SvgPicture.asset(
                  'assets/svg/TaskByte_logo.svg',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            //   Padding(
            //     padding: const EdgeInsets.only(top: 12.0, right: 12.0),
            //     child: CircleAvatar(
            //       radius: 20,
            //       backgroundColor: Colors.black12,
            //       child: IconButton(
            //         icon: Image.asset(
            //           "assets/images/messenger.png",
            //           height: 20,
            //           width: 20,
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //   )
          ],
          bottom: TabBar(
            onTap: (index) {
              _selectedTab = index;
              setState(() {});
            },
            indicatorColor: const Color(0xff1773EA),
            labelColor: const Color(0xff1773EA),
            unselectedLabelColor: Colors.black87,
            tabs: [
              Tab(
                child: _selectedTab == 0
                    ? const ImageIcon(
                        AssetImage('assets/images/home.png'),
                        color: Color(0xff1773EA),
                      )
                    : const ImageIcon(
                        AssetImage('assets/images/home_unselected.png'),
                        color: Color(0xff1773EA),
                      ),
              ),
              Tab(
                  child: _selectedTab == 1
                      ? const ImageIcon(
                          AssetImage("assets/images/friends.png"),
                          color: Color(0xff1773EA),
                        )
                      : const ImageIcon(
                          AssetImage("assets/images/requests.png"),
                          color: Color(0xff1773EA),
                        )),
              Tab(
                child: _selectedTab == 2
                    ? const ImageIcon(
                        AssetImage("assets/images/user_selected.png"),
                        color: Color(0xff1773EA),
                      )
                    : const ImageIcon(
                        AssetImage("assets/images/user.png"),
                        color: Color(0xff1773EA),
                      ),
              ),
              Tab(
                child: _selectedTab == 3
                    ? const ImageIcon(
                        AssetImage("assets/images/friends.png"),
                        color: Color(0xff1773EA),
                      )
                    : const ImageIcon(
                        AssetImage("assets/images/friends.png"),
                        color: Color(0xff1773EA),
                      ),
              ),
              // Tab(
              //   child: _selectedTab == 4
              //       ? const ImageIcon(
              //           AssetImage("assets/images/bell.png"),
              //           color: Color(0xff1773EA),
              //         )
              //       : const ImageIcon(
              //           AssetImage("assets/images/notification.png"),
              //           color: Color(0xff1773EA),
              //         ),
              // ),
              Tab(
                child: _selectedTab == 4
                    ? const ImageIcon(
                        AssetImage("assets/images/menu.png"),
                        color: Color(0xff1773EA),
                      )
                    : const ImageIcon(
                        AssetImage("assets/images/menu.png"),
                        color: Color(0xff1773EA),
                        // color: Colors.black87,
                      ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeWidget(),
            // TestDashBoard(),
            FriendsWidget(),
            ProfileWidget(),
            GroupsWidget(),
            // NotificationWidget(),
            MenuWidget(),
          ],
        ),
      ),
    );
  }

  Widget makeNotification(String count) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
