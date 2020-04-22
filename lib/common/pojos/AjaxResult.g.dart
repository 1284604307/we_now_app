// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AjaxResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AjaxResult _$AjaxResultFromJson(Map<String, dynamic> json) {
  return AjaxResult()
    ..code = json['code'] as int
    ..msg = json['msg'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$AjaxResultToJson(AjaxResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
