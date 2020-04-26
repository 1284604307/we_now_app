// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article()
    ..id = json['id'] as int
    ..link = json['link'] as String
    ..type = json['type'] as int
    ..author = json['author'] as String
    ..publishTime = json['publishTime'] as int
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..envelopePic = json['envelopePic'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagsBean.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..userId = json['userId'] as int
    ..visible = json['visible'] as int
    ..likeCount = json['likeCount'] as int
    ..collect = json['collect'] as bool
    ..fresh = json['fresh'] as bool
    ..prefix = json['prefix'] as String
    ..content = json['content'] as String
    ..shareUser = json['shareUser'] as String
    ..origin = json['origin'] as String
    ..originId = json['originId'] as int
    ..courseId = json['courseId'] as int
    ..chapterId = json['chapterId'] as int
    ..chapterName = json['chapterName'] as String
    ..superChapterId = json['superChapterId'] as int
    ..superChapterName = json['superChapterName'] as String;
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'type': instance.type,
      'author': instance.author,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'description': instance.description,
      'envelopePic': instance.envelopePic,
      'tags': instance.tags,
      'userId': instance.userId,
      'visible': instance.visible,
      'likeCount': instance.likeCount,
      'collect': instance.collect,
      'fresh': instance.fresh,
      'prefix': instance.prefix,
      'content': instance.content,
      'shareUser': instance.shareUser,
      'origin': instance.origin,
      'originId': instance.originId,
      'courseId': instance.courseId,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
    };
