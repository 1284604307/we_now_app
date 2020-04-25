import 'package:json_annotation/json_annotation.dart';
part 'CircleEntity.g.dart';


@JsonSerializable()
class CircleEntity{
    String username ;
    String name;
    String content;
    String createDate;
    List<String> url;
    String type;


    CircleEntity();
    //反序列化
    factory CircleEntity.fromJson(Map<String, dynamic> json) => _$CircleEntityFromJson(json);
    //序列化
    Map<String, dynamic> toJson() => _$CircleEntityToJson(this);

}