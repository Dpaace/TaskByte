import 'package:flutter/material.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/model/groups_model.dart';

class GroupContainer extends StatefulWidget {
  final Groups group;
  const GroupContainer({required this.group, super.key});

  @override
  State<GroupContainer> createState() => _GroupContainerState();
}

class _GroupContainerState extends State<GroupContainer> {
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
                    child: widget.group.image != null
                        ? Image.network(
                            // widget.status.userStatusImage,
                            // widget.user.image!,

                            Constant.userImageURL + widget.group.image!,
                            // "assets/images/me.jpg",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
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
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
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
