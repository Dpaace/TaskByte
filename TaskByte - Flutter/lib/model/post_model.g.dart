// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPost _$UserPostFromJson(Map<String, dynamic> json) => UserPost(
      postId: json['_id'] as String?,
      postTime: json['postTime'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      userr: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      comments: (json['comment'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      pid: json['pid'] as int? ?? 0,
    );

Map<String, dynamic> _$UserPostToJson(UserPost instance) => <String, dynamic>{
      'pid': instance.pid,
      '_id': instance.postId,
      'postTime': instance.postTime,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'user': instance.userr,
      'comment': instance.comments,
    };
