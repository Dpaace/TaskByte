import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/dataprovider/data_provider.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/repository/user_repo.dart';
import 'package:task_byte/widgets/friends_container.dart';

class FriendsWidget extends ConsumerWidget {
  const FriendsWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      body: data.when(
        data: (data) {
          // List<User> userList = data.map((e) => e).toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Friends",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<User>>(
                  future: UserRepositoryImpl().getRemoteUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FriendContainer(
                              user: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                            // child: CircularProgressIndicator(
                            //   color: Colors.green,
                            // ),
                            child: Text("No Friends"));
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(
          err.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// Expanded(
//   child: ListView.builder(
//     itemCount: list.length,
//     physics: const BouncingScrollPhysics(),
//     itemBuilder: (context, index) {
//       final item = list[index];

//       if (item.runtimeType == User) {
//         return FriendContainer(
//           user: item,
//         );
//       } else {
//         return const Text("N/A");
//       }
//     },
//   ),
// ),
// From Future Builder

List<User> list = [
  User(firstName: "Dipesh", lastName: "Nepali", image: "assets/images/me.jpg")
];


// import 'package:flutter/material.dart';
// import 'package:task_byte/model/user_model.dart';
// import 'package:task_byte/repository/user_repo.dart';
// import 'package:task_byte/widgets/friends_container.dart';

// class FriendsWidget extends StatefulWidget {
//   const FriendsWidget({super.key});

//   @override
//   State<FriendsWidget> createState() => _FriendsWidgetState();
// }

// List<User> list = [
//   User(firstName: "Dipesh", lastName: "Nepali", image: "assets/images/me.jpg")
// ];

// class _FriendsWidgetState extends State<FriendsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: const [
//                 Expanded(
//                   child: Text(
//                     "Friends",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: list.length,
//           //     physics: const BouncingScrollPhysics(),
//           //     itemBuilder: (context, index) {
//           //       final item = list[index];

//           //       if (item.runtimeType == User) {
//           //         return FriendContainer(
//           //           user: item,
//           //         );
//           //       } else {
//           //         return const Text("N/A");
//           //       }
//           //     },
//           //   ),
//           // ),
//           // From Future Builder
//           Expanded(
//             child: FutureBuilder<List<User>>(
//               future: UserRepositoryImpl().getRemoteUsers(),
//               builder: (context, snapshot) {
//                 print("data is comming");
//                 print(snapshot.data);
//                 print("data is comming no");
//                 if (snapshot.hasData) {
//                   if (snapshot.data!.isNotEmpty) {
//                     print("data is comming yes");
//                     return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       physics: const BouncingScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return FriendContainer(
//                           user: snapshot.data![index],
//                         );
//                       },
//                     );
//                   } else {
//                     return const Center(
//                         // child: CircularProgressIndicator(
//                         //   color: Colors.green,
//                         // ),
//                         child: Text("No Friends"));
//                   }
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.red,
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
