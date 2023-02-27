import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_byte/widgets/friends_widget.dart';
import 'package:task_byte/widgets/home_widget.dart';
import 'package:task_byte/widgets/groups_widget.dart';
import 'package:task_byte/widgets/menu_widget.dart';
import 'package:task_byte/widgets/profile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  static const String route = "homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
                radius: 20,
                backgroundColor: Colors.black12,
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/search.png",
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 12.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black12,
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/messenger.png",
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            )
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
