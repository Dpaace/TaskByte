import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_byte/model/menu.dart';
import 'package:task_byte/screen/login_screen.dart';

import '../app/snackbar.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  List<Menu> list = [
    // Menu("Groups", "assets/images/group.png", null),
    Menu("Saved", "assets/images/bookmark.png", Colors.purple),
    Menu("Feeds", "assets/images/newsfeed.png", null),
    Menu("Friends", "assets/images/friends_menu.png", null),
    Menu("Groups", "assets/images/group.png", null),
    Menu("Marketplace", "assets/images/marketplace.png", null),
    Menu("Videos on Watch", "assets/images/facebook.png", null),
    Menu("Memories", "assets/images/quick.png", null),
    Menu("Pages", "assets/images/page.png", null),
    Menu("Events", "assets/images/calendar.png", null),
    Menu("Gaming", "assets/images/gamepad.png", null),
  ];

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      // autoHide: const Duration(seconds: 3),
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        showSnackbar(context, "Logout Successfully!", Colors.orange);
        pref.clear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    ).show();
  }

  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    listenSensor();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        print("IS NEAR -->$_isNear");
      });
      if (_isNear == true) {
        // show logout alert dialog
        showAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/gear.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              children: List.generate(
                list.length,
                (index) {
                  var item = list[index];
                  return Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              item.icon,
                              width: 26,
                              height: 26,
                              color: item.color,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
