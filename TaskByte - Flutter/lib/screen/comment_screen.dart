import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:task_byte/data_source/remote_data_source/comment_data_source.dart';
import 'package:task_byte/model/comments_model.dart';

import '../app/constants.dart';
import '../model/post_model.dart';
import '../widgets/shimmer_widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  static const String route = "commentScreen";

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late UserPost post;

  @override
  void didChangeDependencies() {
    post = ModalRoute.of(context)!.settings.arguments as UserPost;
    super.didChangeDependencies();
  }

  final _commentController = TextEditingController(text: "");

  _addComment(String postId) async {
    Comment comment = Comment(
      content: _commentController.text,
    );
    int status = await CommentRemoteDataSource().addComment(postId, comment);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("Comment Added successfully"),
      ).show(context);
      // Navigator.pushNamed(context, AdminOrdersScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Comment Addition Failed"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comment Screen",
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Post ID: ${post.postId!}"),
          // Text("User Name: ${post.userr!.firstName!}"),
          Expanded(
            child: FutureBuilder(
              future:
                  CommentRemoteDataSource().getAllPostComments(post.postId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].content!),
                          // title: Text(post.postTime!),
                          leading: CircleAvatar(
                            child: snapshot.data![index].users!.image != null
                                ? Image.network(
                                    Constant.userImageURL +
                                        snapshot.data![index].users!.image!,
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
                          // leading: const CircleAvatar(
                          //   backgroundImage: AssetImage("assets/images/me.jpg"),
                          // ),
                          subtitle:
                              Text(snapshot.data![index].users!.firstName!),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No Comments Found"),
                    );
                  }
                } else {
                  return Center(
                    // child: CircularProgressIndicator(
                    //   color: Colors.green,
                    // ),
                    child: Column(
                      children: const [
                        RowShimmerWidget(),
                        SizedBox(height: 20),
                        RowShimmerWidget(),
                        SizedBox(height: 20),
                        RowShimmerWidget(),
                        SizedBox(height: 20),
                        RowShimmerWidget(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // Column(
          //     children: const [
          //       ListTile(
          //         title: Text("Comment"),
          //         leading: CircleAvatar(
          //           backgroundImage: AssetImage("assets/images/me.jpg"),
          //         ),
          //         subtitle: Text("time"),
          //       )
          //     ],
          //   ),
          const Divider(),
          ListTile(
            title: TextFormField(
              controller: _commentController,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              // maxLines: 5,
              decoration:
                  const InputDecoration(labelText: "Write a comment..."),
            ),
            trailing: OutlinedButton(
              child: const Text("Post"),
              onPressed: () {
                print("add comment");
                _addComment(post.postId!);
              },
            ),
          )
        ],
      ),
    );
  }
}
