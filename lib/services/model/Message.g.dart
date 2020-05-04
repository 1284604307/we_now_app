// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as num
    ..type = json['type'] as String
    ..targetUsername = json['targetUsername'] as String
    ..targetType = json['targetType'] as String
    ..fromUsername = json['fromUsername'].toString()
    ..senderType = json['senderType'] as String
    ..isSend = json['isSend'] as bool
    ..senderAvatar = json['senderAvatar'] as String
    ..createTime = json['createTime'] as num
    ..serverMessageId = json['serverMessageId'].toString()
    ..action = json['action'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'serverMessageId': instance.serverMessageId,
      'type': instance.type,
      'targetUsername': instance.targetUsername,
      'targetType': instance.targetType,
      'fromUsername': instance.fromUsername,
      'senderType': instance.senderType,
      'isSend': instance.isSend,
      'senderAvatar': instance.senderAvatar,
      'createTime': instance.createTime,
      'action': instance.action,
      'content': instance.content,
    };
