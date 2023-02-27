import 'package:task_byte/helper/objectbox.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/state/objectbox_state.dart';

class UserStatusDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addUserStatus(UserPost userStatus) async {
    try {
      return objectBoxInstance.addUserStatus(userStatus);
    } catch (e) {
      return 0;
    }
  }

  Future<List<UserPost>> getAllUserStatus() async {
    try {
      return Future.value(objectBoxInstance.getAllUserStatus());
    } catch (e) {
      return [];
    }
  }
}
