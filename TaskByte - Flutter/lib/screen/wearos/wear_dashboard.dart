import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:task_byte/screen/wearos/wear_login.dart';
import 'package:wear/wear.dart';

import '../google_maps/google_map_screen.dart';

class WearOsDashboard extends StatefulWidget {
  const WearOsDashboard({super.key});

  static const String route = "wearOsDashboard";

  @override
  State<WearOsDashboard> createState() => _WearOsDashboardState();
}

class _WearOsDashboardState extends State<WearOsDashboard> {
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

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text("Dashboard"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, GoogleMapScreen.route);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Google Map"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AwesomeNotifications().createNotification(
                          content: NotificationContent(
                            id: 1,
                            channelKey: 'basic_channel',
                            title: "Log Out",
                            body: "You are logged out of your account!",
                          ),
                        );
                        Navigator.pushReplacementNamed(
                            context, WearOSLoginScreen.route);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Log Out"),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
