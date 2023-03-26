import 'package:json_annotation/json_annotation.dart';
import 'package:task_byte/model/user_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  bool? success;
  String? message;
  List<User>? data;

  UserResponse({this.success, this.message, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs
