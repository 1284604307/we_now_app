import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/pages/app.dart';
import 'package:flutter_app2/pages/home/chat/chat_page.dart';
import 'package:flutter_app2/pages/home/chat/frined_list_page.dart';
import 'package:flutter_app2/pages/home/chat/frined_notify_page.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/home/my_page/setting_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/pages/login/register.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/model/Article.dart';

class RouteName {
  static const String root = '/';
  static const String app = 'app';
  static const String me = 'me';
  static const String chat = 'chat';
  static const String friend = 'friend';
  static const String loading = 'loading';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String likeList = 'likeList';
  static const String setting = 'setting';
  static const String articleDetail = 'articleDetail';
  static const String coinRankingList = 'coinRankingList';

  static const String rightTo = 'rightTo';

  static const String friendNotify = "fN";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loading:
        return NoAnimRouteBuilder(LoadingPage());
      case RouteName.app:
        return NoAnimRouteBuilder(App());
      case RouteName.me:
        return NoAnimRouteBuilder(MePage());
      case RouteName.chat:
        return NoAnimRouteBuilder(FriendlychatApp());
      case RouteName.friend:
        return SizeRoute(FriendListPage());
      case RouteName.friendNotify:
        return SlideBaseRouteBuilder.right(FriendNotifyPage());
      case RouteName.loading:
        return NoAnimRouteBuilder(LoadingPage());
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
        //desc 主页二楼神秘屋
      case RouteName.homeSecondFloor:
        return SlideTopRouteBuilder(Test());
    //desc 主页二楼神秘屋
      case RouteName.rightTo:
        return SlideBaseRouteBuilder.left(Test());
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.articleDetail:
        var article = settings.arguments as Article;
        return CupertinoPageRoute(builder: (_) {
          // desc 根据配置调用页面,UI构建中...
          return Test();
//          return StorageManager.sharedPreferences.getBool(UseWebViewPlugin) ??
//                  false
//              ? ArticleDetailPluginPage(
//                  article: article,
//                )
//              : ArticleDetailPage(
//                  article: article,
//                );
        });
      //desc 展示收藏的文章，动态的列表页
      case RouteName.likeList:
        return CupertinoPageRoute(builder: (_) => Test());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}