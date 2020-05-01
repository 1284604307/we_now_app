// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..cid = json['cid'] as int
    ..pid = json['pid'] as int
    ..circleId = json['circleId'] as int
    ..content = json['content'] as String
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..fromId = json['fromId'] as int
    ..toId = json['toId'] as int
    ..likeCount = json['likeCount'] as int
    ..children = (json['children'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'cid': instance.cid,
      'pid': instance.pid,
      'circleId': instance.circleId,
      'content': instance.content,
      'createTime': instance.createTime?.toIso8601String(),
      'fromId': instance.fromId,
      'toId': instance.toId,
      'likeCount': instance.likeCount,
      'children': instance.children,
      'user': instance.user,
    };
