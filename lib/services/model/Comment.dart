import 'package:flutter_app2/common/pojos/User.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/4/29
 */
part 'Comment.g.dart';

@JsonSerializable()
class Comment{
  int cid;
  int pid;
  int circleId;
  String content;
  DateTime createTime;
  int fromId;
  int toId;
  int likeCount;
  List<Comment> children;
  User user;

  Comment();

  //反序列化
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}