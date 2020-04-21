import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(00, 00, 00, 0.05),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("我",style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Container(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MySelfCard(width),
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
    );
  }
}