import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/dataprovider/data_provider.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/repository/user_post_repo.dart';
import 'package:task_byte/screen/post_upload_screen.dart';
import 'package:task_byte/widgets/shimmer_widget.dart';
import 'package:task_byte/widgets/status_widget.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  FutureBuilder<Widget> loadWidget(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getWidget(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data as Widget;
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff1773EA),
            ),
          );
        }
      },
    );
  }

  Future<Widget> getWidget(BuildContext context) async {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PostUploadScreen.route);
                    // final NavigationService ss = NavigationService();
                    // ss.pushNamed("/postUploadScreen");
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black45, width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "What's on your mind?",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // From User Status Data
          FutureBuilder<List<UserPost>>(
            future: UserPostRepositoryImpl().getAllRemoteUserPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // List<UserStatus>? data = snapshot.data;
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // final item = snapshot.data![index];
                      return StatusWidget(
                        post: snapshot.data![index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No Posts Found"),
                  );
                  // return const Center(
                  //   child: CircularProgressIndicator(
                  //     color: Colors.red,
                  //   ),
                  // );
                }
              } else {
                return Center(
                  // child: Column(
                  //   children: [
                  //     ListView.separated(
                  //       itemBuilder: (context, index) =>
                  //           const RowShimmerWidget(),
                  //       separatorBuilder: (context, index) => const SizedBox(
                  //         height: 16,
                  //       ),
                  //       itemCount: 5,
                  //     ),
                  //   ],
                  // ),
                  // child: CircularProgressIndicator(),
                  child: Column(
                    children: const [
                      RowShimmerWidget(),
                      SizedBox(height: 16),
                      RowShimmerWidget(),
                      SizedBox(height: 16),
                      RowShimmerWidget(),
                      SizedBox(height: 16),
                      RowShimmerWidget(),
                      SizedBox(height: 16),
                      RowShimmerWidget(),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   getCredentials();
  //   super.initState();
  // }

  // String token = "";
  // void getCredentials() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pref.getString('login')!;
  //   });
  // }

  @override
  Widget build(BuildContext context, ref) {
    // return loadWidget();
    final data = ref.watch(postDataProvider);
    return Scaffold(
      body: data.when(
        data: (data) {
          return loadWidget(context);
        },
        error: (err, s) => Text(
          err.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

//====================================================================
//====================================================================
//====================================================================
//OLD Reference
//====================================================================
//====================================================================
//====================================================================

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task_byte/model/post_model.dart';
// import 'package:task_byte/repository/user_status_repo.dart';
// import 'package:task_byte/widgets/status_widget.dart';

// class HomeWidget extends StatefulWidget {
//   const HomeWidget({super.key});

//   @override
//   State<HomeWidget> createState() => _HomeWidgetState();
// }

// class _HomeWidgetState extends State<HomeWidget> {
//   FutureBuilder<Widget> loadWidget() {
//     return FutureBuilder<Widget>(
//       future: getWidget(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return snapshot.data as Widget;
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Color(0xff1773EA),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Future<Widget> getWidget() async {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/profileWidget');
//                 },
//                 icon: CircleAvatar(
//                   backgroundColor: const Color(0xff1773EA),
//                   radius: 20,
//                   child: Image.asset(
//                     "assets/images/profile.png",
//                     height: 38,
//                     width: 38,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                   width: double.infinity,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(color: Colors.black45, width: 1),
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child: Center(
//                     child: Row(
//                       children: const [
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Expanded(
//                           child: Text(
//                             "What's on your mind?",
//                             style: TextStyle(
//                               color: Colors.black45,
//                               fontSize: 18,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Container(
//           //   color: const Color.fromARGB(255, 0, 109, 4),
//           //   height: 200,
//           //   width: double.infinity,
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: [
//           //       const Center(
//           //         child: Text(
//           //           "Welcome",
//           //           style: TextStyle(
//           //             fontSize: 25,
//           //             fontWeight: FontWeight.bold,
//           //             color: Colors.white,
//           //           ),
//           //         ),
//           //       ),
//           //       ElevatedButton(
//           //         onPressed: () async {
//           //           SharedPreferences pref =
//           //               await SharedPreferences.getInstance();
//           //           await pref.clear();
//           //           // ignore: use_build_context_synchronously
//           //           Navigator.pushReplacementNamed(context, '/loginScreen');
//           //         },
//           //         style: ElevatedButton.styleFrom(
//           //           backgroundColor: Colors.blue,
//           //           shape: RoundedRectangleBorder(
//           //             borderRadius: BorderRadius.circular(5),
//           //           ),
//           //         ),
//           //         child: const Text("Log Out"),
//           //       )
//           //     ],
//           //   ),
//           // ),
//           // Text(
//           //   "Token: $token",
//           //   style: const TextStyle(
//           //     fontSize: 15,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.black,
//           //   ),
//           // ),
//           // Here comes the stories of other users
//           // const StoryContainer(),

//           // From User Status Data
//           FutureBuilder<List<UserPost>>(
//             future: UserStatusRepositoryImpl().getAllUserPosts(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 // List<UserStatus>? data = snapshot.data;
//                 if (snapshot.data!.isNotEmpty) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       // final item = snapshot.data![index];
//                       return StatusWidget(
//                         post: snapshot.data![index],
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: Text("No Posts Found"),
//                   );
//                   // return const Center(
//                   //   child: CircularProgressIndicator(
//                   //     color: Colors.red,
//                   //   ),
//                   // );
//                 }
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

  // @override
  // void initState() {
  //   getCredentials();
  //   super.initState();
  // }

  // String token = "";
  // void getCredentials() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = pref.getString('login')!;
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return loadWidget();
//   }
// }



// Here comes the posts from other users
          // ListView.builder(
          //   itemCount: list.length,
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     final item = list[index];
          //     if (item.runtimeType == UserStatus) {
          //       return StatusWidget(
          //         status: item as UserStatus,
          //       );
          //     } else {
          //       return const Text("N/A");
          //     }
          //   },
          // ),