import 'package:json_annotation/json_annotation.dart';
import 'package:task_byte/model/groups_model.dart';

part 'groups_response.g.dart';

@JsonSerializable()
class GroupResponse {
  bool? success;
  String? message;
  List<Groups>? data;

  GroupResponse({this.success, this.message, this.data});

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs