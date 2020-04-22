
import 'package:json_annotation/json_annotation.dart';
part 'AjaxResult.g.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */

@JsonSerializable()
class AjaxResult{
  int code;
  String msg;
  Object data;

  AjaxResult();
  //反序列化
  factory AjaxResult.fromJson(Map<String, dynamic> json) => _$AjaxResultFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$AjaxResultToJson(this);

}