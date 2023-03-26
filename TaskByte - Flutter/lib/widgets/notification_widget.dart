import 'package:flutter/material.dart';

import '../model/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

List<Notifications> list = [
  Notifications(
      "assets/images/banner.jpeg",
      "Bruce Banner and 112 others liked your post.",
      "Few seconds ago",
      "assets/images/liked.png"),
];

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = list[index];
                return Card(
                  margin: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                  elevation: 0,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: const Color(0xffECF2FB),
                              child: Center(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.asset(
                                        item.nImage,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset(
                                        item.nIcon,
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 2, 0, 2),
                                          child: Text(
                                            item.nBody,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 2, 0, 2),
                                        child: Text(
                                          item.nTime,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Montserrat',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.more_horiz,
                              color: Colors.black87,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
