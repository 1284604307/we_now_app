import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'CustomInterceptors.dart';
import 'LogsInterceptors.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class Api{
  static BaseOptions opt;
  static const Api_Host = "http://192.168.101.7:8888";
  static Dio dio;
  static PersistCookieJar cookieJar ;
  static String appDocPath;
  static User user;
  static bool login = false;

  static List<CircleEntity> hotCircles = [];


  static JPush jpush = new JPush();

  // PersistCookieJar 会将cookie保存到本地
//  static final PersistCookieJar cookieJar = new PersistCookieJar();
  static Dio getDio(){
    if(dio==null){
      opt = BaseOptions(
        headers: {
          "Auth-Type":"APP_MATH",
          "version":"1.0.0"
        },
        connectTimeout: 1500,
        sendTimeout: 1500,
        baseUrl:Api_Host,
      );
      dio = new Dio(opt);
      // 获取存储cookie的本地地址
      dio.interceptors.add(CustomInterceptors());
      //置入cookieManager
      dio.interceptors.add(CookieManager(cookieJar));
    }
    return dio;
  }

  static init() async{
    await getCookieJar().then(
        (path){
          print(path);
          user = User.getUser();
          if(cookieJar.domains!=null&&cookieJar.domains.length>1){
            user.initInfo();
          }
        }
    );
//    Api.cookieJar = new PersistCookieJar(dir:"./cookies");
//    getApplicationDocumentsDirectory().then((onValue){
//      print(onValue.path);
//      Api.appDocPath = onValue.path;
//          //PersistCookieJar(dir:Api.appDocPath+"/.cookies/");
//    });
  }

  static Future<String> getCookieJar() async {
    await getApplicationDocumentsDirectory().then((onValue){
      appDocPath = onValue.path;
      cookieJar = PersistCookieJar(dir:appDocPath+"/.cookies/");
    });
  }

  static void get(
      String url,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function success,
        Function error
      }
      ) async {
    // 对接收到的请求参数进行从处理
  }


}