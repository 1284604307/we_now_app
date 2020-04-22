// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatEntity _$UserStatEntityFromJson(Map<String, dynamic> json) {
  return UserStatEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    postCount: json['postCount'] as int,
    likeCount: json['likeCount'] as int,
    followingCount: json['followingCount'] as int,
    followerCount: json['followerCount'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$UserStatEntityToJson(UserStatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'postCount': instance.postCount,
      'likeCount': instance.likeCount,
      'followingCount': instance.followingCount,
      'followerCount': instance.followerCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

PostStatEntity _$PostStatEntityFromJson(Map<String, dynamic> json) {
  return PostStatEntity(
    id: json['id'] as int,
    postId: json['postId'] as int,
    likeCount: json['likeCount'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$PostStatEntityToJson(PostStatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
