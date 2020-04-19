import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/common/Global.dart';
import 'package:flutter_app2/pages/home/message/message_page.dart';
import 'package:flutter_app2/pages/my_page/my_page.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import 'about_us_page.dart';
import 'weights/circle_page.dart';
import 'home/index/home_page.dart';

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

  HomePage homePage;
  CirclePage circlePage;
  MessagePage messagePage;
  MyPage myPage;



  //根据当前索引返回不同页面
  currentPage(){
    switch(_currentIndex){
      case 0:
        if(homePage==null){
          homePage=HomePage();
        }
        return homePage;
      case 2:
        if(messagePage==null){
          messagePage=MessagePage();
        }
        return messagePage;
      case 1:
        if(circlePage==null){
          circlePage=CirclePage();
        }
        return circlePage;
      case 3:
        if(myPage==null){
          myPage=MyPage();
        }
        return myPage;
    }
  }


  @override
  Widget build(BuildContext context) {
    Global.context = context;
    DateTime  _willPopTime ;

    final pageController = PageController();
    final bodyList = [HomePage(), CirclePage(), MessagePage(),MyPage()];

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
//              style: TextStyle(
//                color: _currentIndex == 0?Colors.redAccent:Color(0xff999999)
//              ),
          ),
          icon:Icon(Icons.home)
//            icon: _currentIndex == 0? Icon(Icons.home):Icon(Icons.home)
      ),
      BottomNavigationBarItem(
          title: Text('广场'),
          icon: Icon(Icons.grain)
      ),
      BottomNavigationBarItem(
          title: Text('消息'),
          icon: Icon(_currentIndex != 2?Icons.notifications_none:Icons.notifications)
      ),
      BottomNavigationBarItem(
          title: Text('我的'),
          icon: Icon(_currentIndex != 3?Icons.person_outline:Icons.person)
      ),
    ];

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: bodyList,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
        //底部导航栏
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.transparent),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: onTap,
          //底部导航栏
          items: navigationItem,
        ) ,
      ),
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          if (_willPopTime == null || (DateTime.now().difference(_willPopTime) >
              Duration(seconds: 1))) {
            //两次点击间隔超过1秒，重新计时
            BotToast.showText(text: "再次点击将退出应用");
            _willPopTime = DateTime.now();
            print(_willPopTime);
            return false;
          }
          return true;
        }
      }
    );
  }

}