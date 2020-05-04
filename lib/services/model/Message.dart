import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/4/26
 */
part "Message.g.dart";

@JsonSerializable()
class Message{
  num id;
  String serverMessageId;
  String type;
  String targetUsername;
  String targetType;
  String fromUsername;
  String senderType;
  bool isSend;
  String senderAvatar;
  int createTime;
  String action;
  String extras;
  String content;

  Message();

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}