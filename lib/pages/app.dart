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
    //    SystemChrome.setEnabledSystemUIOverlays([]);
    //虚拟按键背景
    return Scaffold(
      backgroundColor: Colors.white,
      body: currentPage(),
      //底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedLabelStyle: TextStyle(
          color: Colors.transparent
        ),
        //通过fixedColor设置选中的颜色
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        //底部导航栏
        items: [
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
        ],
      ) ,
    );
  }
}