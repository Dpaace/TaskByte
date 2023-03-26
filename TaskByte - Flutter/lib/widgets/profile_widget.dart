import 'package:flutter/material.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/repository/user_repo.dart';
import 'package:task_byte/screen/profile_picture_update_screen.dart';
import 'package:task_byte/screen/update_profile_screen.dart';

import '../screen/google_maps/google_map_screen.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static const String route = "profileWidget";

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        // future: UserRemoteDataSource().getUserDetails(),
        future: UserRepositoryImpl().getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? data = snapshot.data!;
            return loadProfile(
              user: data,
              context: context,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}

Widget loadProfile({
  User? user,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        // const SizedBox(
        //   height: 25,
        // ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Cover image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            "assets/images/defaultCoverPicture.png",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Positioned(
                        //   right: 0,
                        //   bottom: 0,
                        //   child: Transform.translate(
                        //     offset: const Offset(-10, -15),
                        //     child: makeCamera(),
                        //   ),
                        // )
                      ],
                    ),
                    // Profile image
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: user!.image != null
                                  ? Image.network(
                                      Constant.userImageURL + user.image!,
                                      // "assets/images/me.jpg",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/defaultProfilePic.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ProfilePictureUpdateScreen.route);
                              },
                              child: Transform.translate(
                                offset: const Offset(0, -15),
                                child: makeCamera(),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "  ${user.firstName ?? "None"}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: " ${user.lastName ?? "None"}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              // Text(
              //   // "${user.firstName!} ${user.lastName!}",
              //   user.firstName != null ? "Value" : "None",
              //   // user.interests ?? "None",
              //   // "Dipesh Nepali",
              //   style: const TextStyle(
              //       color: Colors.black,
              //       fontFamily: 'Montserrat',
              //       fontStyle: FontStyle.normal,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 22.0),
              // ),
              const SizedBox(
                height: 10,
              ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: user.phoneNumber ?? "None",
              //         // text: "  dipeshnepali767@gmail.com",
              //         style: const TextStyle(
              //           fontWeight: FontWeight.normal,
              //           color: Colors.black,
              //           fontSize: 20,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Text(
                user.interests ?? "None",
                // "Java, Flutter, NodeJs, Oracle",
                style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // Expanded(
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(
                  //         const Color(0xff1773EA),
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: const [
                  //           Icon(
                  //             Icons.add_circle,
                  //             size: 18,
                  //             color: Colors.white,
                  //           ),
                  //           SizedBox(
                  //             width: 8,
                  //           ),
                  //           Text(
                  //             "Add to Story",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 14,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, UpdateProfileScreen.route);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff1773EA),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/work.png",
                    color: Colors.grey,
                    height: 20,
                    width: 20,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            // text: "  ${user.email!}",
                            text: "  ${user.email ?? "None"}",
                            // text: "  dipeshnepali767@gmail.com",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Image.asset(
                    "assets/images/work.png",
                    color: Colors.grey,
                    height: 20,
                    width: 20,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            // text: "  ${user.phoneNumber!}",
                            text: "  ${user.phoneNumber ?? "None"}",
                            // text: "  dipeshnepali767@gmail.com",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/work.png",
                    color: Colors.grey,
                    height: 20,
                    width: 20,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            // text: "  ${user.phoneNumber!}",
                            text: "  ${user.dateOfBirth ?? "None"}",
                            // text: "  dipeshnepali767@gmail.com",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "My Location",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, GoogleMapScreen.route);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Tap to Find",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              // Container(
              //   height: 200,
              //   color: Colors.green,
              // ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget makeCamera() {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: const Color(0xffdadada),
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color(0xffdadada),
      ),
    ),
    child: Center(
      child: Image.asset(
        "assets/images/camera.png",
        width: 18,
        height: 18,
      ),
    ),
  );
}


// ======================================================
// ======================================================
// ======================================================
// OLD Reference
// ======================================================
// ======================================================
// ======================================================



// import 'package:flutter/material.dart';
// import 'package:task_byte/data_source/remote_data_source/user_data_source.dart';
// import 'package:task_byte/model/user_model.dart';

// class ProfileWidget extends StatefulWidget {
//   const ProfileWidget({super.key});

//   @override
//   State<ProfileWidget> createState() => _ProfileWidgetState();
// }

// class _ProfileWidgetState extends State<ProfileWidget> {
//   bool circular = true;
//   User user = User();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     UserRemoteDataSource getProfileData = UserRemoteDataSource();
//     var response = await getProfileData.getUserDetails();
//     setState(() {
//       user = response as User;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 300,
//                     color: Colors.white,
//                     width: double.infinity,
//                     child: Stack(
//                       alignment: Alignment.topCenter,
//                       children: [
//                         // Cover image
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(30),
//                                 topRight: Radius.circular(30),
//                               ),
//                               child: Image.asset(
//                                 "assets/images/image.png",
//                                 height: 220,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: Transform.translate(
//                                 offset: const Offset(-10, -15),
//                                 child: makeCamera(),
//                               ),
//                             )
//                           ],
//                         ),
//                         // Profile image
//                         Positioned(
//                           bottom: 0,
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 80,
//                                 backgroundColor: Colors.white,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: Image.asset(
//                                     "assets/images/me.jpg",
//                                     height: 150,
//                                     width: 150,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Transform.translate(
//                                   offset: const Offset(0, -15),
//                                   child: makeCamera(),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     "Dipesh Nepali",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Montserrat',
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22.0),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     "Java, Flutter, NodeJs, Oracle",
//                     style: TextStyle(
//                         color: Colors.black54,
//                         fontFamily: 'Montserrat',
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16.0),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                               const Color(0xff1773EA),
//                             ),
//                           ),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: const [
//                                 Icon(
//                                   Icons.add_circle,
//                                   size: 18,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   "Add to Story",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                               const Color(0xff1773EA),
//                             ),
//                           ),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: const [
//                                 Icon(
//                                   Icons.edit,
//                                   size: 18,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   "Edit Profile",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       Image.asset(
//                         "assets/images/work.png",
//                         color: Colors.grey,
//                         height: 20,
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                   text: "  dipeshnepali767@gmail.com",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                   ))
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 3,
//                     width: double.infinity,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: const Text(
//                       "Groups",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Montserrat',
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22.0,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: const Text(
//                       "1 Group",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Montserrat',
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.normal,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget makeCamera() {
//   return Container(
//     width: 32,
//     height: 32,
//     decoration: BoxDecoration(
//       color: const Color(0xffdadada),
//       shape: BoxShape.circle,
//       border: Border.all(
//         color: const Color(0xffdadada),
//       ),
//     ),
//     child: Center(
//       child: Image.asset(
//         "assets/images/camera.png",
//         width: 18,
//         height: 18,
//       ),
//     ),
//   );
// }
