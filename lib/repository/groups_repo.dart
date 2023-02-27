import 'package:task_byte/data_source/local_data_source/group_data_source.dart';
import 'package:task_byte/data_source/remote_data_source/groups_data_source.dart';
import 'package:task_byte/model/groups_model.dart';

abstract class GroupsRepository {
  Future<List<Groups>> getAllRemoteGroups();
  Future<List<Groups>> getAllLocalGroups();
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
}
