import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'api.dart';

final Http http = Http();

final host = "139.9.201.138";
final localhost = "192.168.101.7";
final port = "8888";

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = "http://$host:$port";
    interceptors
      ..add(ApiInterceptor())
      // cookie持久化 异步
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.applicationDocumentsDirectory.path+"/.cookies/")));

    try{
      var ticket = StorageManager.sharedPreferences.get(WeNow_LoginTicket);
      var username = StorageManager.sharedPreferences.get(WeNow_LoginName);
      if(ticket!=null && username!=null){
        options.headers['ticket'] = ticket;
        options.headers['username'] = username;
      }
    }catch(e){
      print(e);
    }
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
//    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
//        ' queryParameters: ${options.queryParameters}');
  debugPrint("${options.headers}");
//    debugPrint('---api-request--->data--->${options.data}');
    return options;
  }

  @override
  onResponse(Response response) {
//    debugPrint('---api-response--->resp----->${response.data}');
    ResponseData respData = ResponseData.fromJson(response.data);
    print(respData);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      if (respData.code == 401) {
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      }else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;


  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['msg'];
    if(json['data']!=null)
      data = json['data'];
  }
}
