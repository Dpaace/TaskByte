import 'package:json_annotation/json_annotation.dart';
import 'package:task_byte/model/post_model.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  bool? success;
  String? message;
  List<UserPost>? data;

  PostResponse({this.success, this.message, this.data});

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs