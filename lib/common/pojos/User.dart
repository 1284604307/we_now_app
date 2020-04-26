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
  var loginName = "未登录";
  var userName = "未登录";
  var createTime = "";
  var createCount = 0;
  var avatar = "assets/images/loading.jpg";
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
  User();

  static getUser(){
    return new User();
  }


  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  initInfo() async{
//    Dio dio = Api.getDio();
//    var res = await dio.get("/user");
//    print(res);
//    if(res.statusCode==200){
//      var data = res.data;
//      print(data['code']);
//      if(data['code']==0){
//        Api.user =  User.fromJson(data['data']);
//        print(Api.user.toJson());
//        Api.login = true;
//        notifyListeners();
//      }
//    }else{
//      BotToast.showText(text:"服务错误");
//    }
  }
}