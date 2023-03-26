// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:task_byte/app/app.dart';
// import 'package:task_byte/helper/objectbox.dart';
// import 'package:task_byte/state/objectbox_state.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   ObjectBoxInstance.deleteDatabase();
//   ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
//   // runApp(
//   //   const MyApp(),
//   // );
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]).then(
//     (value) => runApp(
//       const MyApp(),
//     ),
//   );
// }

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/app/app.dart';
import 'package:task_byte/helper/objectbox.dart';
import 'package:task_byte/state/objectbox_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ObjectBoxInstance.deleteDatabase();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  AwesomeNotifications().initialize(
    'resource://drawable/launcher',
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: 'basic_channel',
        channelName: "Basic notifications",
        channelDescription: "Notification channel for basic test",
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true,
      )
    ],
  );
  // runApp(
  //   const MyApp(),
  // );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}
