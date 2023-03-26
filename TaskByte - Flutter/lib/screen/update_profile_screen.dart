import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_byte/app/snackbar.dart';
import 'package:task_byte/app/user_permission.dart';
import 'package:task_byte/model/user_model.dart';
import 'package:task_byte/repository/user_repo.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String route = "updateProfileScreen";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  final _updateKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _interestsController = TextEditingController();

  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  DateTime? _selectedDate;
  String? _dateOfBirth;

  _updateProfile() async {
    User userProfile = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneNumberController.text,
      interests: _interestsController.text,
      dateOfBirth: _dateOfBirth,
    );
    int status = await UserRepositoryImpl().updateUserProfile(userProfile);
    _showMessage(status);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        _dateOfBirth = dateFormat.format(_selectedDate!);
      });
    });
  }

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(context, 'Successfully Updated Profile', Colors.green);
      Navigator.pop(context);
      // Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      showSnackbar(context, 'Error in Updating Profile', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Update Profile"),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         _savePost();
        //       },
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.grey,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(5),
        //         ),
        //       ),
        //       child: const Text(
        //         "Post",
        //         style: TextStyle(
        //           fontSize: 14,
        //           color: Colors.white,
        //           fontWeight: FontWeight.w500,
        //           fontFamily: "OpenSans Italic",
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: Form(
            key: _updateKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity - 500,
                  child: CircleAvatar(
                    // backgroundColor: const Color(0xff1773EA),
                    radius: 50,
                    child: Image.asset("assets/images/profile.png"),
                  ),
                ),
                const Text(
                  "User First Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _firstNameController,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "User Last Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _lastNameController,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "User Phone Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your Interests",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                TextFormField(
                  controller: _interestsController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your interests';
                    }
                    return null;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your Date of Birth",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans Italic",
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? "No Date Chosen!"
                              // : "Picked Date:",
                              : "Picked Date: ${DateFormat.yMd().format(_selectedDate!)}",
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: const Text(
                          "Choose Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_updateKey.currentState!.validate()) {
            // _saveUser();
            _updateProfile();
          }
        },
        label: const Text('Update Profile'),
        icon: const Icon(Icons.update),
      ),
    );
  }
}
