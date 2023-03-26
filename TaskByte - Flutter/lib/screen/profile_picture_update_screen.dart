import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_byte/app/snackbar.dart';
import 'package:task_byte/app/user_permission.dart';
import 'package:task_byte/repository/user_repo.dart';

class ProfilePictureUpdateScreen extends StatefulWidget {
  const ProfilePictureUpdateScreen({super.key});

  static const String route = "profilePictureUpdateScreen";

  @override
  State<ProfilePictureUpdateScreen> createState() =>
      _ProfilePictureUpdateScreenState();
}

class _ProfilePictureUpdateScreenState
    extends State<ProfilePictureUpdateScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  _updateProfilePicture() async {
    int status = await UserRepositoryImpl().updateUserProfilePicture(_img);
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
      showSnackbar(
          context, 'Successfully Updated Profile Picture', Colors.green);
      Navigator.pop(context);
    } else {
      showSnackbar(
          context, 'Error in updating your profile picture', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        // title: const Text("Create Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
            child: ElevatedButton(
              onPressed: () {
                _updateProfilePicture();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                "Update",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Update your profile picture",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans Italic",
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              // SizedBox(
              //   height: 300,
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
                height: 300,
                width: double.infinity - 500,
                child: CircleAvatar(
                  radius: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _img == null
                        ? Image.asset("assets/images/profile.png")
                        : Image.file(
                            _img!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ],
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
        label: const Text('Upload Image'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
