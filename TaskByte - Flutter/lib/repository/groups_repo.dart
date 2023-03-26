import 'package:task_byte/data_source/local_data_source/group_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/groups_data_source.dart';
import 'package:task_byte/model/groups_model.dart';

abstract class GroupsRepository {
  Future<List<Groups>> getAllRemoteGroups();
  Future<List<Groups>> getAllLocalGroups();

  Future<int> addGroup(Groups group);
  Future<int> deleteGroup(String groupId);
}

class GroupsRepositoryImpl extends GroupsRepository {
  @override
  Future<List<Groups>> getAllRemoteGroups() {
    return GroupsRemoteDataSource().getGroups();
  }

  @override
  Future<List<Groups>> getAllLocalGroups() {
    return GroupsLocalDataSource().getAllUserGroup();
  }

  @override
  Future<int> addGroup(Groups group) {
    return GroupsRemoteDataSource().addGroup(group);
  }
  
  @override
  Future<int> deleteGroup(String groupId) {
    return GroupsRemoteDataSource().deleteGroup(groupId);
  }
}
