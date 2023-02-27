import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:task_byte/model/comments_model.dart';
import 'package:task_byte/model/groups_model.dart';
import 'package:task_byte/model/post_model.dart';
import 'package:task_byte/model/user_story_model.dart';

part 'user_model.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? userId;

  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phoneNumber;
  String? interests;
  String? image;
  String? email;
  String? password;

  @Backlink()
  final userStory = ToMany<UserStory>;

  @Backlink()
  final posts = ToMany<UserPost>;

  // @Backlink()
  // final comment = ToMany<Comment>;

  @Backlink()
  final groups = ToMany<Groups>;

  // @JsonKey(name: 'posts')
  // List<UserPost>? postss;

  // User(this.userId, this.username, this.email, this.password, {this.id = 0});
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.phoneNumber,
    this.interests,
    this.image,
    this.email,
    this.password,
    // this.postss,
    this.id = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}




//   // Server bata aako object lai json ma convert gareko
  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     json["_id"],
  //     json['firstName'],
  //     json['lastName'],
  //     json['dateOfBirth'],
  //     json['phoneNumber'],
  //     json['image'],
  //     json['email'],
  //     json['password'],
  //   );
  // }

//   // Baneko object lai server ma pathauna ko lagi json ma converted
//   Map<String, dynamic> toJson() => {
//         '_id': userId,
//         'firstName': firstName,
//         'lastName': lastName,
//         'dateOfBirth': dateOfBirth,
//         'phoneNumber': phoneNumber,
//         'image': image,
//         'email': email,
//         'password': password,
//       };
// }

// OLD for reference if mistakes/not work
// @Entity()
// class User {
//   @Id(assignable: true)
//   int userID;

//   String username;
//   String email;
//   String password;

//   @Backlink()
//   final userStory = ToMany<UserStory>;

//   @Backlink()
//   final userPost = ToMany<UserStatus>;

//   User(this.username, this.email, this.password, {this.userID = 0});
// }

// flutter pub run build_runner build --delete-conflicting-outputs