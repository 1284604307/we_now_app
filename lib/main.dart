import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/chat/chat_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/pages/me/me_page.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'common/Api.dart';
import 'pages/app.dart';
void main() {
  Api.init();
  runApp(
    BotToastInit(
      child:MaterialApp(
        title: '好奇宝宝',
        //自定义主题
        theme: mDefaultTheme,
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
        home: LoadingPage(),
      ))
    );




  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
final ThemeData mDefaultTheme  = ThemeData(
    primaryColor: Colors.lightBlueAccent
);

