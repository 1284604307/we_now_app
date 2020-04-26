// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner()
    ..id = json['id']
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..description = json['description'] as String
    ..type = json['type'] as int
    ..url = json['url'] as String
    ..path = json['path'] as String
    ..articleId = json['articleId']
    ..author = json['author'] as String;
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'description': instance.description,
      'type': instance.type,
      'url': instance.url,
      'path': instance.path,
      'articleId': instance.articleId,
      'author': instance.author,
    };
