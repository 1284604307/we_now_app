import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/my_page/setting_page.dart';
import 'package:flutter_app2/pages/home/my_page/user_profile.dart';
import 'package:flutter_app2/pages/login/demo.dart';
import 'package:flutter_app2/pages/wights/bottom_clipper.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'my_page_card_item.dart';
import 'my_page_self_card.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MyPage extends StatefulWidget{
  @override
  MyPageState createState()=>MyPageState();
}

class MyPageState extends State<MyPage>{


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (){

      },
      child: Scaffold(
          body: Container(
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // desc 头部栈结构
                  Container(
                    height: 240,
                    child: Stack(
                      children: <Widget>[
                        // desc 头部背景色
                        ClipPath(
                          clipper: BottomClipper(),
                          child: Container(
                            height: 210,
//                            color: Theme.of(context).primaryColor,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        // desc 头部按钮排列
                        Container(
                            width: width,
                            margin: EdgeInsets.only(top: 30,left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SettingPage();
                                        }
                                    ));
                                  },
                                )
                              ],
                            )
                        ),
                        // desc 个人信息卡片
                        Positioned(
                          width: width,
                          top: 80,
                          child: InkWell(
                            highlightColor : Colors.transparent,//点击时，水波纹的底色颜色
                            splashColor:Colors.transparent,// 点击时，水波纹扩展的颜色
                            onTap: (){
                              if(!Provider.of<UserModel>(context,listen: false).hasUser)
                                Navigator.pushNamed(context, RouteName.login);
                              else
                                Navigator.pushNamed(context, RouteName.me);
                            },
                            child: MySelfCard(width),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: <Widget>[
                        CardItem(
                          width/4,
                          icon: Theme.of(context).brightness == Brightness.light?
                          Icon(IconFonts.moon,color: Colors.blue,):Icon(Icons.wb_sunny,color: Colors.amber,),
                          text: Theme.of(context).brightness == Brightness.light?"夜间模式":"日间模式",
                          taped: (){
                            switchDarkMode(context);
                            print("事件发生");
                          },
                        ),
                        CardItem(
                          width/4,
                          icon: Icon(Icons.radio_button_unchecked),
                          text: "腾讯SDK DEMO",
                          taped: (){
                            Navigator.push(context, NoAnimRouteBuilder(MyApp()));
                          },
                        ),
                        CardItem(
                          width/4,
                          icon: Icon(Icons.map),
                          text: "上下联动案例",
                          taped: (){
                            Navigator.push(context, NoAnimRouteBuilder(UserProfileScreen()));
                          },
                        ),
                        CardItem(width/4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }


  void switchDarkMode(BuildContext context) {
    print(Theme.of(context).brightness);
    if (MediaQuery.of(context).platformBrightness ==
        Brightness.dark) {
      BotToast.showText(text: "检测到系统为夜间模式,已为你自动切换");
    } else {
      Provider.of<ThemeModel>(context,listen: false).switchTheme(
          userDarkMode:
          Theme.of(context).brightness == Brightness.light);
    }
  }
}