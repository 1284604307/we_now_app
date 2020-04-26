import 'package:json_annotation/json_annotation.dart';

/**
 * @createDate  2020/4/26
 */
part 'TagsBean.g.dart';

@JsonSerializable()
class TagsBean {
  String name;
  String url;

  TagsBean();

  factory TagsBean.fromJson(Map<String, dynamic> json) => _$TagsBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TagsBeanToJson(this);

}