import 'package:flutter_app2/common/pojos/User.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CircleEntity.g.dart';


@JsonSerializable()
class CircleEntity{
    String id ;
    String username ;
    String content;
    String createDate;
    List<String> url;
    String type;
    User user;


    CircleEntity();
    //反序列化
    factory CircleEntity.fromJson(Map<String, dynamic> json) => _$CircleEntityFromJson(json);
    //序列化
    Map<String, dynamic> toJson() => _$CircleEntityToJson(this);

}