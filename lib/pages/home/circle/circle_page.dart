import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/index/follow.dart';
import 'package:flutter_app2/pages/home/index/hot.dart';
import 'package:flutter_app2/pages/home/index/recommend.dart';
import 'package:provider/provider.dart';

import 'circle_recommend.dart';
import 'circle_talk.dart';

class CirclePage extends StatefulWidget{
  @override
  CirclePageState createState()=>CirclePageState();
}

class CirclePageState extends State<CirclePage>{

  final _navigationItems = [
    new Tab(text: "推荐"),
    new Tab(text: "校园"),
  ];
  /// 统一管理导航项目对应的组件列表。
  final _widgetOptions = [
    new CircleRecommend(),
    new Recommend(),
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: GlobalConfig.globalBackgroundColor,
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 210,
                  child: new TabBar(
                    labelColor: GlobalConfig.dark? Colors.white : Colors.black,
                    unselectedLabelColor: GlobalConfig.themeColor ,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.normal),
                    indicatorColor: Colors.blue,
                    tabs: _navigationItems,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            new TabBarView(
                children: _widgetOptions
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.lightBlueAccent,
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.add,size: 30,color: Colors.white,),
                          onPressed: () {
                            Navigator.push(context,new MaterialPageRoute(
                                builder: (context) {
                                  return new CreateCirclePage();
                                }
                            ));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}