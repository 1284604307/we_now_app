import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/5/2
 */
part 'Topic.g.dart';
@JsonSerializable()
class Topic {

  num id;
  String topic;
  String desc;
  String url;
  String type;
  String title;
  String subtitle;
  int fansCount;
  int visible;
  bool top;
  DateTime niceTime;
  DateTime createTime;

  Topic();

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}