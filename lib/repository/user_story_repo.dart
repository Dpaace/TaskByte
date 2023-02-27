import 'package:task_byte/data_source/local_data_source/user_story_data_source.dart';
import 'package:task_byte/model/user_story_model.dart';

abstract class UserStoryRepository {
  Future<int> addUserStory(UserStory userStory);
  Future<List<UserStory>> getAllUserStory();
}

class UserStoryRepositoryImpl extends UserStoryRepository {
  @override
  Future<int> addUserStory(UserStory userStory) {
    return UserStoryDataSource().addUserStory(userStory);
  }

  @override
  Future<List<UserStory>> getAllUserStory() {
    return UserStoryDataSource().getAllUserStories();
  }
}
