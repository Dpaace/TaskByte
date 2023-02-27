// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      json['_id'] as String?,
      json['groupName'] as String?,
      json['description'] as String?,
      json['image'] as String?,
      users: (json['user'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.groupId,
      'groupName': instance.groupName,
      'description': instance.description,
      'image': instance.image,
      'user': instance.users,
    };
