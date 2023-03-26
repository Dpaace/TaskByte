import 'package:json_annotation/json_annotation.dart';
import 'package:task_byte/model/user_model.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse {
  bool? success;
  String? message;
  User? data;

  UserDetailsResponse({this.success, this.message, this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs