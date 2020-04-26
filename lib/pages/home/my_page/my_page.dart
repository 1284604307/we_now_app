import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/my_page/setting_page.dart';
import 'package:flutter_app2/pages/wights/bottom_clipper.dart';

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
          backgroundColor: Color.fromRGBO(00, 00, 00, 0.05),
          body: Container(
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 240,
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
}