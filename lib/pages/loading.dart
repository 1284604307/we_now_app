import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app2/common/Api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class LoadingPage extends StatefulWidget{

  _LoadingState createState() => _LoadingState();

}

class _LoadingState extends State<LoadingPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApplicationDocumentsDirectory().then((onValue){
      print(onValue.path);
      Api.appDocPath = onValue.path;
      Api.cookieJar = PersistCookieJar(dir:Api.appDocPath+"/.cookies/");
    });

    Api.init();

    // 加载页面停顿3秒后回到App页
    Future.delayed(Duration(seconds: 3),(){
      print("应用启动");
      Api.user.initInfo();
      Navigator.of(context).pushReplacementNamed('app');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("本页面不建议返回");
        return;
      },
      child: Center(
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
      ),

    );
  }

}