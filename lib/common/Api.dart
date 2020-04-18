import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_app2/common/pojos/User.dart';
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
  // PersistCookieJar 会将cookie保存到本地
//  static final PersistCookieJar cookieJar = new PersistCookieJar();
  static Dio getDio(){

//    if(dio==null){
      opt = BaseOptions(
        headers: {
          "Auth-Type":"APP_MATH",
          "version":"1.0.0"
        },
        baseUrl:Api_Host,
      );
      dio = new Dio(opt);
      // 获取存储cookie的本地地址
      cookieJar = PersistCookieJar(dir:appDocPath+"/.cookies/");
//      dio.interceptors.add(LogsInterceptors());
      dio.interceptors.add(CustomInterceptors());
      //置入cookieManager
      dio.interceptors.add(CookieManager(cookieJar));
      print(opt);
//    }
    return dio;
  }

  static init(){
    getAppDocDir();
    user = User.getUser();
    User.initInfo();
  }

  static Future<String> getAppDocDir() async {
    await getApplicationDocumentsDirectory().then((onValue){
      print(onValue.path);
      appDocPath = onValue.path;
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