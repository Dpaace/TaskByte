import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_byte/app/constants.dart';
import 'package:task_byte/data_source/remote_data_source/response/groups_response.dart';
import 'package:task_byte/helper/http_service.dart';
import 'package:task_byte/model/groups_model.dart';

class GroupsRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Groups>> getGroups() async {
    try {
      Response response = await _httpServices.get(Constant.getAllGroupsURL);
      List<Groups> lstUserGroups = [];
      if (response.statusCode == 200) {
        GroupResponse groupResponse = GroupResponse.fromJson(response.data);
        print(groupResponse.data);
        lstUserGroups = groupResponse.data!;
        return lstUserGroups;
        // return groupResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      // throw Exception(e.toString());
    }
  }
}

final groupProvider =
    Provider<GroupsRemoteDataSource>((ref) => GroupsRemoteDataSource());
