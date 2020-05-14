import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/pages/app.dart';
import 'package:flutter_app2/pages/home/chat/chat_page.dart';
import 'package:flutter_app2/pages/home/chat/friend_application.dart';
import 'package:flutter_app2/pages/home/chat/frined_list_page.dart';
import 'package:flutter_app2/pages/home/chat/frined_notify_page.dart';
import 'package:flutter_app2/pages/home/circle/publish/weibo_publish_stopic_page.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/home/my_page/setting_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/pages/login/register.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/Article.dart';

import 'package:fluro/fluro.dart' as routers;

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

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

var weiboPublishTopicHandler = new routers.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WeiBoPublishTopicPage();
    });


class Routes {
  static routers.Router router;

  static String weiboPublishTopicPage= '/weiboPublishTopicPage';

  static void configureRoutes(routers.Router router) {
    // List widgetDemosList = new WidgetDemoList().getDemos();
    router.notFoundHandler = new routers.Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('route not found!');
        });

    router.define(weiboPublishTopicPage,handler:weiboPublishTopicHandler);
  }

    // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配(https://www.jianshu.com/p/e575787d173c)
  static Future navigateTo(BuildContext context, String path, {Map<String, dynamic> params, bool clearStack=false, routers.TransitionType transition = routers.TransitionType.fadeIn}) {
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    path = path + query;
    return router.navigateTo(context, path, clearStack:clearStack , transition:transition);
  }


  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配(https://www.jianshu.com/p/e575787d173c)
  static Future navigatepushAndRemoveUntil(BuildContext context, String path, {Map<String, dynamic> params, bool clearStack=false, routers.TransitionType transition = routers.TransitionType.fadeIn}) {
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    path = path + query;
    return router.navigateTo(context, path, clearStack:clearStack , transition:transition );
  }


}