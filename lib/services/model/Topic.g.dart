// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic()
    ..id = json['id'] as num
    ..topic = json['topic'] as String
    ..desc = json['desc'] as String
    ..url = json['url'] as String
    ..type = json['type'] as String
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..fansCount = json['fansCount'] as int
    ..visible = json['visible'] as int
    ..top = json['top'] as bool
    ..niceTime = json['niceTime'] == null
        ? null
        : DateTime.parse(json['niceTime'] as String)
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String);
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'desc': instance.desc,
      'url': instance.url,
      'type': instance.type,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'fansCount': instance.fansCount,
      'visible': instance.visible,
      'top': instance.top,
      'niceTime': instance.niceTime?.toIso8601String(),
      'createTime': instance.createTime?.toIso8601String(),
    };
