import 'package:json_annotation/json_annotation.dart';
import 'package:task_byte/model/comments_model.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  bool? success;
  String? message;
  List<Comment>? data;

  CommentResponse({this.success, this.message, this.data});

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs