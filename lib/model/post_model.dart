import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:task_byte/model/comments_model.dart';
import 'package:task_byte/model/user_model.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

// New Reference
part 'post_model.g.dart';

@Entity()
@JsonSerializable()
class UserPost {
  @Id(assignable: true)
  int pid;

  @Unique()
  @JsonKey(name: '_id')
  String? postId;
  String? postTime;
  String? title;
  String? description;
  String? image;

  final user = ToOne<User>;

  @Backlink()
  final comment = ToMany<Comment>;

  @JsonKey(name: 'user')
  User? userr;

  @JsonKey(name: 'comment')
  List<Comment>? comments;

  UserPost({
    this.postId,
    this.postTime,
    this.title,
    this.description,
    this.image,
    this.userr,
    this.comments,
    this.pid = 0,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) =>
      _$UserPostFromJson(json);

  Map<String, dynamic> toJson() => _$UserPostToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs

// Old Reference
// import 'package:objectbox/objectbox.dart';
// import 'package:task_byte/model/user_model.dart';

// // @JsonSerializable()
// @Entity()
// class UserStatus {
//   @Id(assignable: true)
//   int postId;

//   // int postID;

//   // @Unique()
//   // @JsonKey(name: '_id')
//   // String postId;

//   String userName = "";
//   String postTime = "";
//   String userImage = "";
//   String userStatus = "";
//   String userStatusImage = "";
//   String likeCount = "";
//   int commentCount = 0;
//   int shareCount = 0;

//   final users = ToOne<User>;

//   UserStatus(this.userName, this.postTime, this.userImage, this.userStatus,
//       this.userStatusImage, this.likeCount, this.commentCount, this.shareCount,
//       {this.postId = 0});
// }
