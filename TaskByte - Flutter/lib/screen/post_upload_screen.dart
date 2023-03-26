import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_byte/app/snackbar.dart';
import 'package:task_byte/app/user_permission.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/repository/user_post_repo.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  static const String route = "postUploadScreen";

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
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
    _checkUserPermission();
    _checkNotificationEnabled();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  final _postKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  _savePost() async {
    UserPost userPost = UserPost(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    int status = await UserPostRepositoryImpl().addUserPost(_img, userPost);
    _showMessage(status);
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Successfully added Post', Colors.green);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "New Post Uploaded",
          body: "Check it out! Might be important.",
        ),
      );
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Error in adding Post', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Create Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
            child: ElevatedButton(
              onPressed: () {
                _savePost();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Post",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "OpenSans Italic",
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: Form(
            key: _postKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff1773EA),
                      radius: 20,
                      child: Image.asset(
                        "assets/images/profile.png",
                        height: 38,
                        width: 38,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Dipesh Nepali",
                                  style: TextStyle(
                                    color: Colors.black,
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
                  ],
                ),
                const Text(
                  "Post Title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _titleController,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Post Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  }),
                ),
                // SizedBox(
                //   height: 200,
                //   width: double.infinity - 500,
                //   child: CircleAvatar(
                //     // backgroundColor: const Color(0xff1773EA),
                //     radius: 50,
                //     child: _img == null
                //         ? Image.asset("assets/images/profile.png")
                //         : Image.file(
                //             _img!,
                //             height: 150,
                //             width: 150,
                //             fit: BoxFit.contain,
                //           ),
                //   ),
                // ),
                SizedBox(
                  height: 200,
                  width: double.infinity - 500,
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _img == null
                          ? Image.asset("assets/images/profile.png")
                          : Image.file(
                              _img!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          // InkWell(
          //   key: _postKey,
          //   onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.grey[300],
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _browseImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _browseImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    label: const Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        },
        // child: SizedBox(
        //   height: 200,
        //   width: double.infinity - 500,
        //   child: _img == null
        //       ? Image.asset(
        //           'assets/images/profile.png',
        //         )
        //       : Image.file(_img!),
        // ),
        //   );
        // },
        label: const Text('Add Image'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
