import 'package:task_byte/helper/objectbox.dart';
import 'package:task_byte/model/user_story_model.dart';
import 'package:task_byte/state/objectbox_state.dart';

class UserStoryDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addUserStory(UserStory userStory) async {
    try {
      return objectBoxInstance.addUserStory(userStory);
    } catch (e) {
      return 0;
    }
  }

  Future<List<UserStory>> getAllUserStories() async {
    try {
      return Future.value(objectBoxInstance.getAllUserStories());
    } catch (e) {
      return [];
    }
  }
}
