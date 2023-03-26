import 'package:task_byte/helper/objectbox.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/state/objectbox_state.dart';

class GroupsLocalDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addGroup(Groups groups) async {
    try {
      return objectBoxInstance.addUserGroups(groups);
    } catch (e) {
      return 0;
    }
  }

  Future<List<Groups>> getAllUserGroup() async {
    try {
      return Future.value(objectBoxInstance.getAllGroups());
    } catch (e) {
      return [];
    }
  }
}
