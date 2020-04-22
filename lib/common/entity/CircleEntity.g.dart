// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CircleEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleEntity _$CircleEntityFromJson(Map<String, dynamic> json) {
  return CircleEntity()
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..content = json['content'] as String
    ..createDate = json['createDate'] as String
    ..url = (json['url'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String;
}

Map<String, dynamic> _$CircleEntityToJson(CircleEntity instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'content': instance.content,
      'createDate': instance.createDate,
      'url': instance.url,
      'type': instance.type,
    };
