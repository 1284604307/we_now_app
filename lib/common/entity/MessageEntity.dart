import 'package:json_annotation/json_annotation.dart';
part 'MessageEntity.g.dart';


@JsonSerializable()
class MessageEntity{
    String from;
    String to;
    String time;
    String type;


    MessageEntity();
    //反序列化
    factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
    //序列化
    Map<String, dynamic> toJson() => _$MessageEntityToJson(this);

}