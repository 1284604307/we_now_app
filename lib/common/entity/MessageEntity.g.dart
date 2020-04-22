// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return MessageEntity()
    ..from = json['from'] as String
    ..to = json['to'] as String
    ..time = json['time'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'time': instance.time,
      'type': instance.type,
    };
