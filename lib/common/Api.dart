import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tencent_kit/tencent_kit.dart';


/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class Api{
  static ScrollController globalScrollController = ScrollController(initialScrollOffset: 0,keepScrollOffset: true);
  static Article newCircleEntity = Article();
  static JPush jpush ;
  static JmessageFlutter jMessage;
  static Database db;


  static const String _TENCENT_APPID = '1110421384';
  static Tencent tencent = Tencent()..registerApp(appId: _TENCENT_APPID);
//  StreamSubscription<TencentLoginResp> _login;
//  StreamSubscription<TencentShareResp> _share;


  TencentLoginResp _loginResp;

  void _listenLogin(TencentLoginResp resp) {
    _loginResp = resp;
    String content = 'login: ${resp.openid} - ${resp.accessToken}';
    print(resp.openid);
    print(resp.accessToken);
//    _showTips('登录', content);
  }

  void _listenShare(TencentShareResp resp) {
    String content = 'share: ${resp.ret} - ${resp.msg}';
//    _showTips('分享', content);
  }
}