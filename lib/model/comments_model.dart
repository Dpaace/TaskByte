import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/model/user_model.dart';

part 'comments_model.g.dart';

@Entity()
@JsonSerializable()
class Comment {
  @Id(assignable: true)
  int cid;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? commentId;

  // @Backlink()
  final user = ToOne<User>();

  final post = ToOne<UserPost>();

  String? content;

  @JsonKey(name: 'user')
  User? users;

  Comment({
    this.commentId,
    this.content,
    this.users,
    this.cid = 0,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs
