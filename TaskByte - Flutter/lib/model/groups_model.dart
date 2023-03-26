import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:task_byte/model/user_model.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

// New Reference
part 'groups_model.g.dart';

@Entity()
@JsonSerializable()
class Groups {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? groupId;
  String? groupName;

  // String? description;
  // String? image;

  // final user = ToMany<User>;

  // @JsonKey(name: 'user')
  // List<User>? users;

  Groups({
    this.groupId,
    this.groupName,
    this.id = 0,
  });

  // factory Groups.fromJson(Map<String, dynamic> json) =>
  //     _$GroupsFromJson(json);

  // Map<String, dynamic> toJson() => _$GroupsToJson(this);

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}

// flutter pub run build_runner build --delete-conflicting-outputs