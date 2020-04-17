import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app2/common/Api.dart';

class LoadingPage extends StatefulWidget{

  _LoadingState createState() => _LoadingState();

}

class _LoadingState extends State<LoadingPage>{
    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //全局初始化
    Api.init();

    // 加载页面停顿3秒后回到App页
    Future.delayed(Duration(seconds: 3),(){
      print("应用启动");
      Navigator.of(context).pushReplacementNamed('app');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child:Center(
        child: Stack(
          children: <Widget>[
            //加载页面背景图
            Image.asset(
                'assets/images/loading.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
            ),

            Center(
              child: Text(
                'Let\'s Show',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    decoration: TextDecoration.none
                ),
              ),
            ),
          ],
        )
      )
    );
  }

}