import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class LogsInterceptors extends InterceptorsWrapper {


  @override
  Future onRequest(RequestOptions options) {
    print("请求baseUrl：${options.baseUrl}");
    print("请求url：${options.path}");
    print('请求头: ' + options.headers.toString());
    if (options.data != null) {
      print('请求参数: ' + options.data.toString());
    }
  }

  @override
  Future onResponse(Response response) {
    if (response == 403) {
      var responseStr = response.toString();
    }

  }

  @override
  Future onError(DioError err) {
    print('请求异常: ' + err.toString());
//    print('请求异常信息: ' + err.response?.toString() ?? "");
  }

}
