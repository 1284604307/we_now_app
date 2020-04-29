// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..prefix = json['prefix'] as String
    ..content = json['content'] as String
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..url = (json['url'] as List)?.map((e) => e as String)?.toList()
    ..comments = (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] as String
    ..link = json['link'] as String
    ..envelopePic = json['envelopePic'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagsBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..visible = json['visible'] as int
    ..likeCount = json['likeCount'] as num
    ..commentCount = json['commentCount'] as num
    ..collect = json['collect'] as bool
    ..like = json['like'] as bool
    ..fresh = json['fresh'] as bool
    ..top = json['top'] as bool
    ..userId = json['userId'] as num
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'prefix': instance.prefix,
      'content': instance.content,
      'createTime': instance.createTime?.toIso8601String(),
      'url': instance.url,
      'comments': instance.comments,
      'type': instance.type,
      'link': instance.link,
      'envelopePic': instance.envelopePic,
      'tags': instance.tags,
      'visible': instance.visible,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'collect': instance.collect,
      'like': instance.like,
      'fresh': instance.fresh,
      'top': instance.top,
      'userId': instance.userId,
      'user': instance.user,
    };
