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
class User{
  var username = "999";
  var create = "9991";
  var like = "9992";
  var collect = "9993";
  var footer = "9994";
  var lv = "0";
  var name = "未登录";
  var avatar = "assets/images/loading.jpg";
  // 最近一次登录时间
  var userId;
  var loginDate;
  var email;
  var phone;
  // 性别
  var sex;
  User();

  static getUser(){
    return new User();
  }


  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static initInfo() async{
    Dio dio = Api.getDio();
    var res = await dio.get("/user");
    print(res);
    if(res.statusCode==200){
      var data = res.data;
      print(data['code']);
      if(data['code']==0){
        Api.user =  User.fromJson(data['data']);
        print(Api.user.toJson());
        Api.login = true;
      }
    }else{
      BotToast.showText(text:"服务错误");
    }
  }
}