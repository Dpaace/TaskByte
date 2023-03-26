import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/app/snackbar.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/repository/user_post_repo.dart';

import '../screen/comment_screen.dart';

class StatusWidget extends StatefulWidget {
  final UserPost post;
  const StatusWidget({required this.post, super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool visibility = false;

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Successfully Deleted Post', Colors.green);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Post Deleted",
          body: "Your Post is deleted",
        ),
      );
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Error in Deleting Post', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post.image == "") {
      visibility = false;
    } else {
      visibility = true;
    }
    return Card(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      shadowColor: Colors.white,
      elevation: 4.0,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        child: Stack(
          children: [
            Column(
              children: [
                // const RowShimmerWidget(),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: widget.post.userr!.image != null
                            ? Image.network(
                                // widget.status.userStatusImage,
                                // widget.user.image!,

                                Constant.userImageURL +
                                    widget.post.userr!.image!,
                                // "assets/images/me.jpg",
                                height: 34,
                                width: 34,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/defaultProfilePic.png",
                                height: 34,
                                width: 34,
                                fit: BoxFit.cover,
                              ),
                        // child: Image.asset(
                        //   // User Image
                        //   "assets/images/me.jpg",
                        //   // widget.post.image!,
                        //   height: 34,
                        //   width: 34,
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // UserName here
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    // First Name and Last Name
                                    // "Dipesh Nepali",
                                    // widget.post.userr!.firstName.toString(),
                                    "${widget.post.userr!.firstName.toString()} ${widget.post.userr!.lastName.toString()}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Posttime here
                            Row(
                              children: [
                                Text(
                                  // "Time",
                                  widget.post.postTime!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset(
                                  "assets/images/friends.png",
                                  height: 12,
                                  width: 12,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.40,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: double.infinity - 500,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        "assets/images/delete.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        int status =
                                            await UserPostRepositoryImpl()
                                                .deleteUserPost(
                                                    widget.post.postId!);
                                        _showMessage(status);
                                        // Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        'Delete Post',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          // Post title here
                          widget.post.title!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          // Post caption/description here
                          widget.post.description!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: visibility,
                  child: widget.post.image != null
                      ? Image.network(
                          // Post Image here
                          Constant.userImageURL + widget.post.image!,
                          // widget.post.image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/defaultProfilePic.png",
                          // widget.post.image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         "assets/images/liked.png",
                //         height: 18,
                //         width: 18,
                //         fit: BoxFit.fill,
                //       ),
                //       Transform.translate(
                //         offset: const Offset(-5, 0),
                //         child: Image.asset(
                //           "assets/images/love.png",
                //           height: 18,
                //           width: 18,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //       Transform.translate(
                //         offset: const Offset(-5, 0),
                //         child: Image.asset(
                //           "assets/images/haha.png",
                //           height: 18,
                //           width: 18,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //       // Transform.translate(
                //       //   offset: const Offset(-5, 0),
                //       //   child: Text(
                //       //     widget.post.likeCount!,
                //       //     style: const TextStyle(
                //       //       color: Colors.black,
                //       //       fontSize: 13,
                //       //     ),
                //       //   ),
                //       // ),
                //       // Expanded(
                //       //   child: Text(
                //       //     "${widget.post.comment} comments",
                //       //     style: const TextStyle(
                //       //       color: Colors.black,
                //       //       fontSize: 13,
                //       //     ),
                //       //     textAlign: TextAlign.end,
                //       //   ),
                //       // )
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black26,
                  height: 1,
                ),
                Row(
                  children: [
                    // Reaction Buttons
                    // Expanded(
                    //   child: IconButtonWidget(
                    //     button: Button("assets/images/like.png", "Like"),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                      height: 50,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CommentScreen.route,
                            arguments: widget.post,
                          );
                        },
                        child: Expanded(
                          child: Row(
                            children: const [
                              Image(
                                image: AssetImage("assets/images/comment.png"),
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Comment"),
                            ],
                          ),

                          // child: IconButtonWidget(
                          //   button:
                          //       Button("assets/images/comment.png", "Comment"),
                          // ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: IconButtonWidget(
                    //     button: Button("assets/images/share.png", "Share"),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
