// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups(
      groupId: json['_id'] as String?,
      groupName: json['groupName'] as String?,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.groupId,
      'groupName': instance.groupName,
    };
