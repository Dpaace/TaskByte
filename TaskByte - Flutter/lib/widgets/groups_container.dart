import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:task_byte/model/groups_model.dart';

import '../app/snackbar.dart';
import '../controllers/socket_controller.dart';
import '../model/subscription_models.dart';
import '../repository/groups_repo.dart';
import '../screen/chat_screen.dart';

class GroupContainer extends StatefulWidget {
  final Groups group;
  const GroupContainer({required this.group, super.key});

  @override
  State<GroupContainer> createState() => _GroupContainerState();
}

class _GroupContainerState extends State<GroupContainer> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SocketController.get(context)
        ..init()
        ..connect(
          onConnectionError: (data) {
            print(data);
          },
        );
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => SocketController.get(context).dispose());
    super.dispose();
  }

  _showMessage(int status) {
    if (status > 0) {
      showSnackbar(
          context, 'Group has been Successfully Deleted', Colors.green);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Group Deleted",
          body: "Your Group is deleted",
        ),
      );
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Error in Deleting Group', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 0, 8),
      child: Card(
        margin: const EdgeInsets.fromLTRB(2, 1, 2, 1),
        elevation: 0,
        color: const Color(0xffECF2FB),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      "assets/images/defaultGroupPic.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(
                                  // Group Name
                                  widget.group.groupName!,
                                  // "${widget.user.firstName!} ${widget.user.lastName!}",
                                  // widget.user.postss!.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.40,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: double.infinity - 500,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                                                  await GroupsRepositoryImpl()
                                                      .deleteGroup(widget
                                                          .group.groupId!);
                                              _showMessage(status);
                                              // Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
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
                                              'Delete Group',
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
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  var subscription = Subscription(
                                    roomName: widget.group.groupName!,
                                    userName: "User",
                                  );
                                  // Subscribe and go the Chat screen
                                  SocketController.get(context).subscribe(
                                    subscription,
                                    onSubscribe: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ChatScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff1773EA),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Enter Group",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
