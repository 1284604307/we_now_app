// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CircleEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleEntity _$CircleEntityFromJson(Map<String, dynamic> json) {
  return CircleEntity()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..content = json['content'] as String
    ..createDate = json['createDate'] as String
    ..url = (json['url'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CircleEntityToJson(CircleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'content': instance.content,
      'createDate': instance.createDate,
      'url': instance.url,
      'type': instance.type,
      'user': instance.user,
    };
