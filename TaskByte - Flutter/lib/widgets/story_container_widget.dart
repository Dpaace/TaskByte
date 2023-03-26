import 'package:flutter/material.dart';
import 'package:task_byte/model/user_story_model.dart';
import 'package:task_byte/repository/user_story_repo.dart';
import 'package:task_byte/widgets/story_widget.dart';

UserStory story1 = UserStory(
  "assets/images/story_one.png",
  "assets/images/profile.png",
  "Dipesh Nepali",
);
UserStory story2 = UserStory(
  "assets/images/story_two.png",
  "assets/images/profile.png",
  "Dipesh Nepali",
);

class StoryContainer extends StatefulWidget {
  const StoryContainer({super.key});

  @override
  State<StoryContainer> createState() => _StoryContainerState();
}

class _StoryContainerState extends State<StoryContainer> {
  @override
  // List<UserStory> _lstUserStories = [];

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder<List<UserStory>>(
                    future: UserStoryRepositoryImpl().getAllUserStory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<UserStory>? data = snapshot.data;

                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.all(4),
                          color: Colors.white,
                          child: StoryWidget(
                            // story: story1,
                            // story: snapshot.data as UserStory,
                            story: snapshot.data![1],
                            // story: data![0],
                          ),
                        );

                        // for (var element in data!) {
                        //   if (element.runtimeType == UserStory) {
                        // return Card(
                        //   elevation: 0,
                        //   margin: const EdgeInsets.all(4),
                        //   color: Colors.white,
                        //   child: StoryWidget(
                        //     story: element,
                        //   ),
                        // );
                        //   }
                        // }

                        // return const Center(
                        //   child: CircularProgressIndicator(),
                        // );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  // Card(
                  //   elevation: 0,
                  //   margin: const EdgeInsets.all(4),
                  //   color: Colors.white,
                  //   child: StoryWidget(
                  //     story: story1,
                  //   ),
                  // ),
                  // Card(
                  //   elevation: 0,
                  //   margin: const EdgeInsets.all(4),
                  //   color: Colors.white,
                  //   child: StoryWidget(
                  //     story: story2,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// return ListView.builder(
                        //   itemCount: data!.length,
                        //   itemBuilder: (context, index) {
                        //     return Card(
                        //       elevation: 0,
                        //       margin: const EdgeInsets.all(4),
                        //       color: Colors.white,
                        //       child: StoryWidget(
                        //         story: data[index],
                        //       ),
                        //     );
                        //   },
                        // );