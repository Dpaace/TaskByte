import 'package:objectbox/objectbox.dart';
import 'package:task_byte/model/user_model.dart';

@Entity()
class UserStory {
  @Id(assignable: true)
  int storyId;

  String sImage = "";
  String sUserImage = "";
  String sUserName = "";

  final user = ToOne<User>;

  UserStory(this.sImage, this.sUserImage, this.sUserName,{this.storyId = 0});
}
