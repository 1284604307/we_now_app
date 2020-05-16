import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/Global.dart';
import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
@JsonSerializable()
class User with ChangeNotifier{
  var loginName;
  var userName;
  var createTime ;
  var createCount;
  var avatar;
  var likeCount = 9992;
  var collectCount = 9993;
  var followCount = 9994;
  var fansCount = 9994;
  var lv = 0;
  // 最近一次登录时间
  var userId;
  var loginDate;
  var email;
  var phonenumber;
  // 性别
  var sex;
  var schoolId;
  var ticket;
  var signature;

  var birthday;
  User();

  static getUser(){
    return new User();
  }


  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}