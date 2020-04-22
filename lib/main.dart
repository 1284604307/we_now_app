import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/chat/chat_page.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/pages/rxdartDemo/rDemo.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

import 'common/Api.dart';
import 'pages/app.dart';
void main() {


  runApp(
      BotToastInit(
          child:MaterialApp(
            title: '好奇宝宝',
            //自定义主题
            theme: ThemeData.light(),
            navigatorObservers: [BotToastNavigatorObserver()],//2.registered route observer
            routes: <String, WidgetBuilder>{
              "app": (BuildContext c) => App(),
              "login":(BuildContext c) => LoginPage(),
              "me":(BuildContext c) => MePage(),
              "chat":(BuildContext c) => ChatScreen(),
              "ming_company": (BuildContext c) =>
                  WebviewScaffold(
                    url: "http://www.baidu.com",
                    appBar: AppBar(
                      title: Text("Ming 的 App"),
                      leading: IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          Navigator.of(c).pushReplacementNamed('app');
                        },
                      ),
                    ),
                  ),
            },
            home: LoadingPage(), // LoadingPage(),
          )
      )
  );


  Api.jpush = new JPush();
  Api.jpush.setup(
    production: false,
    debug: false, // 设置是否打印 debug 日志
  );
  Api.jpush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter 接收通知回调方法: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter 点击通知回调方法: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter 接收自定义消息回调方法: $message");
    },
  );

  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}



final ThemeData mDefaultTheme  = ThemeData(
    primaryColor: Colors.lightBlueAccent
);

