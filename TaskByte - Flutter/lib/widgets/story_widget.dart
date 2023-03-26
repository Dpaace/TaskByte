import 'package:flutter/material.dart';
import 'package:task_byte/model/user_story_model.dart';

class StoryWidget extends StatefulWidget {
  final UserStory story;
  const StoryWidget({required this.story, super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.story.sImage),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 18,
                    child: Image.asset(
                      "assets/images/profile.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Text(
                    widget.story.sUserName,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
