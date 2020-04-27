import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/my_page/setting_page.dart';
import 'package:flutter_app2/pages/wights/bottom_clipper.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
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

    bool dark = Theme.of(context).brightness == Brightness.light;

    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (){

      },
      child: Scaffold(
          body: Container(
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 240,
                    color: Theme.of(context).cardColor,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: BottomClipper(),
                          child: Container(
                            height: 210,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        Container(
                          width: width,
                          color: Colors.black12,
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
                        Positioned(
                          width: width,
                          top: 80,
                          child: MySelfCard(width),
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
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.only(top: 10),
                    child: Wrap(
                      children: <Widget>[
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.only(top: 10),
                    child: Wrap(
                      children: <Widget>[
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.only(top: 10),
                    child: Wrap(
                      children: <Widget>[
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
                        CardItem(width/4),
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
      BotToast.showText(text: "检测到系统为暗黑模式,已为你自动切换");
    } else {
      Provider.of<ThemeModel>(context,listen: false).switchTheme(
          userDarkMode:
          Theme.of(context).brightness == Brightness.light);
    }
  }
}