import 'package:flutter/material.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/model/user_model.dart';

import '../controllers/socket_controller.dart';
import '../model/subscription_models.dart';
import '../screen/chat_screen.dart';

class FriendContainer extends StatefulWidget {
  final User user;
  const FriendContainer({required this.user, super.key});

  @override
  State<FriendContainer> createState() => _FriendContainerState();
}

class _FriendContainerState extends State<FriendContainer> {
  @override
  void initState() {
    // _userNameEditingController = TextEditingController();
    // _roomEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Initilizing and connecting to the socket
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
    // _userNameEditingController.dispose();
    // _roomEditingController.dispose();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => SocketController.get(context).dispose());
    super.dispose();
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
                    child: widget.user.image != null
                        ? Image.network(
                            // widget.status.userStatusImage,
                            // widget.user.image!,

                            Constant.userImageURL + widget.user.image!,
                            // "assets/images/me.jpg",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/defaultProfilePic.png",
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
                                  "${widget.user.firstName!} ${widget.user.lastName!}",
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
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   MessageScreen.route,
                                  //   arguments: widget.user,
                                  // );

                                  var subscription = Subscription(
                                    roomName: "chat",
                                    userName: widget.user.firstName!,
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
                                        "Message",
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
