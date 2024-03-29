import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart' as routers;
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Global.dart';
import 'package:flutter_app2/pages/home/message/message_page.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/utils/platform_utils.dart';

import 'home/circle/circle_page.dart';
import 'home/home/index.dart';
import 'home/my_page/my_page.dart';
import 'package:flutter_app2/pages/maps/other.dart';

import 'maps/test.dart';

class App extends StatefulWidget{
  @override
  AppState createState()=>AppState();
}

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class AppState extends State<App>{

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Global.context = context;
    DateTime  _willPopTime ;

    final pageController = PageController();
    final pages = [Home(),SelectLocationItemInfoDetail(), CirclePage(), MessagePage(),MyPage()];
//HomePage(测试页)/SelectLocationFromMapPage(导航测试页)//SelectLocationItemInfoDetail

    void onTap(int index) {
      pageController.jumpToPage(index);
    }

    void onPageChanged(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    List<BottomNavigationBarItem> navigationItem = [
      BottomNavigationBarItem(
          title: Text(
            '首页',
          ),
          icon:Icon(Icons.home)
//            icon: _currentIndex == 0? Icon(Icons.home):Icon(Icons.home)
      ),
      BottomNavigationBarItem(
          title: Text(
            '疫情动员',
          ),
          icon:Icon(Icons.compare_arrows)
//            icon: _currentIndex == 0? Icon(Icons.home):Icon(Icons.home)
      ),
      BottomNavigationBarItem(
          title: Text('动态'),
          icon: Icon(Icons.toll)
      ),
      BottomNavigationBarItem(
          title: Text('消息'),
          icon: Icon(_currentIndex != 3?Icons.notifications_none:Icons.notifications)
      ),
      BottomNavigationBarItem(
          title: Text('我的'),
          icon: Icon(_currentIndex != 4?Icons.person_outline:Icons.person)
      ),
    ];

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          itemBuilder:(ctx, index) => pages[index],
          itemCount: pages.length,
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
        //底部导航栏
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(size: 25),
          unselectedIconTheme: IconThemeData(size: 20),
          selectedFontSize: 14,
          unselectedLabelStyle: TextStyle(color: Colors.transparent),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onTap,
          //底部导航栏
          items: navigationItem,
        ),
      ),
      onWillPop: () async {
        if (_currentIndex != 0) {
          pageController.jumpToPage(0);
          return false;
        }
        else {
          if (_willPopTime == null || (_willPopTime.difference(_willPopTime) >
              Duration(seconds: 1))) {
            //两次点击间隔超过1秒，重新计时
            BotToast.showText(text: "再次点击将退出应用 ");
            _willPopTime = DateTime.now();
            print(_willPopTime);
            return false;
          }else{
            BotToast.showText(text: "应用退出 ");
            return true;
          }
        }
      }
    );
  }

}
