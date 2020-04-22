// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    id: json['id'] as int,
    username: json['username'] as String,
    password: json['password'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String,
    avatarId: json['avatarId'] as int,
    intro: json['intro'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    avatar: json['avatar'] == null
        ? null
        : FileEntity.fromJson(json['avatar'] as Map<String, dynamic>),
    stat: json['stat'] == null
        ? null
        : UserStatEntity.fromJson(json['stat'] as Map<String, dynamic>),
    following: json['following'] as bool ?? false,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'avatarId': instance.avatarId,
      'intro': instance.intro,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'avatar': instance.avatar,
      'stat': instance.stat,
      'following': instance.following,
    };
