import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/4/26
 */
part "Message.g.dart";

@JsonSerializable()
class Message{
  num id;
  String type;
  int targetId;
  String targetType;
  int senderId;
  String senderType;
  bool isRead;
  String senderAvatar;
  DateTime createTime;
  String action;
  String content;

  Message();

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}