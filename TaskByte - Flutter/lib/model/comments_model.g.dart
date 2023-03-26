// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentId: json['_id'] as String?,
      content: json['content'] as String?,
      users: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      cid: json['cid'] as int? ?? 0,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'cid': instance.cid,
      '_id': instance.commentId,
      'content': instance.content,
      'user': instance.users,
    };
