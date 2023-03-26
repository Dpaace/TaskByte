import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:task_byte/dataprovider/data_provider.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/repository/groups_repo.dart';
import 'package:task_byte/widgets/groups_container.dart';

class GroupsWidget extends ConsumerWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final groupController = TextEditingController();

    createGroup() async {
      String groupsName = groupController.text;
      Groups group = Groups(
        groupName: groupsName,
      );

      final isCreated = await GroupsRepositoryImpl().addGroup(group);
      // _showMessage(isCreated);

      if (isCreated > 0) {
        // ignore: use_build_context_synchronously
        MotionToast.success(
          description: const Text(
            "Group Created Successfully",
          ),
        ).show(context);
      } else {
        // ignore: use_build_context_synchronously
        MotionToast.error(
          description: const Text(
            "Error in Creating Group",
          ),
        ).show(context);
      }
    }

    final data = ref.watch(groupDataProvider);
    return Scaffold(
      body: data.when(
        data: (data) {
          List<Groups> userGroup = data.map((e) => e).toList();
          print(userGroup);
          print("Did you see?");
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Groups",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black12,
                      child: IconButton(
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
                              height: MediaQuery.of(context).size.height * 0.60,
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Groups",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      key: const ValueKey('txtGroup'),
                                      controller: groupController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        labelText: 'Enter Group Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: ((value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Group Name';
                                        }
                                        return null;
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      key: const ValueKey('btnContinue'),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          createGroup();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: const Text(
                                          "Create Group",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Image.asset(
                          "assets/images/plus.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Groups>>(
                  future: GroupsRepositoryImpl().getAllRemoteGroups(),
                  builder: (context, snapshot) {
                    print("Is data Coming");
                    print(snapshot);
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GroupContainer(
                              group: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                            // child: CircularProgressIndicator(
                            //   color: Colors.green,
                            // ),
                            child: Text("No Groups"));
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


// import 'package:flutter/material.dart';

// class GroupsWidget extends StatefulWidget {
//   const GroupsWidget({super.key});

//   @override
//   State<GroupsWidget> createState() => _GroupsWidgetState();
// }

// class _GroupsWidgetState extends State<GroupsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
