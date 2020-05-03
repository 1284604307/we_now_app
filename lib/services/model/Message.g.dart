// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as num
    ..type = json['type'] as String
    ..targetId = json['targetId'] as int
    ..targetType = json['targetType'] as String
    ..senderId = json['senderId'] as int
    ..senderType = json['senderType'] as String
    ..isRead = json['isRead'] as bool
    ..senderAvatar = json['senderAvatar'] as String
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..action = json['action'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'targetId': instance.targetId,
      'targetType': instance.targetType,
      'senderId': instance.senderId,
      'senderType': instance.senderType,
      'isRead': instance.isRead,
      'senderAvatar': instance.senderAvatar,
      'createTime': instance.createTime?.toIso8601String(),
      'action': instance.action,
      'content': instance.content,
    };
