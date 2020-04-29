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
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String)
    ..fromId = json['fromId'] as int
    ..toId = json['toId'] as int
    ..likeCount = json['likeCount'] as int
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'cid': instance.cid,
      'pid': instance.pid,
      'circleId': instance.circleId,
      'content': instance.content,
      'createDate': instance.createDate?.toIso8601String(),
      'fromId': instance.fromId,
      'toId': instance.toId,
      'likeCount': instance.likeCount,
      'user': instance.user,
    };
