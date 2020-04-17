import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';

class MySelfCard extends StatelessWidget{

  double width;
  User user;

  MySelfCard(this.width){
    this.user = Api.user;
  }



  @override
  Widget build(BuildContext context) {
    var cardWidth = this.width - 50;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          width: width,
          child: Center(
            // 第一行 头像 + 用户名
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // 头像
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child:InkWell(
                        splashColor: Colors.green[900], // give any splashColor you want
                        onTap: () {
                          print("跳转到"+(Api.login?'me':"login"));
                          Navigator.of(context).pushNamed(Api.login?'me':"login");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            user.avatar==null?"assets/images/loading.jpg":user.avatar,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      )

                    ),
                    // 用户名
                    Column(
                      children: <Widget>[
                        // desc 头像
                        Container(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            user.name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        // desc 等级框
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.only(left: 15,right:3,top: 2,bottom:2),
                            color: Color.fromRGBO(0, 0, 220, 0.13),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "lv "+user.lv,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child:Icon(
                                    Icons.chevron_right,
                                    size: 16,
                                    color: Colors.blueAccent,
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: cardWidth/4-1,
                        child: Column(
                          children: <Widget>[
                            Text(user.create.toString()),
                            Text("创作")
                          ],
                        ),
                      ), Text("|"),
                      Container(
                        alignment: Alignment.center,
                        width: cardWidth/4-1,

                        child: Column(
                          children: <Widget>[
                            Text(user.like.toString()),
                            Text("关注")
                          ],
                        ),
                      ),Text("|"),
                      Container(
                        alignment: Alignment.center,
                        width: cardWidth/4-1,
                        child:  Column(
                          children: <Widget>[
                            Text(user.collect.toString()),
                            Text("收藏")
                          ],
                        ),
                      ),Text("|"),
                      Container(
                        alignment: Alignment.center,
                        width: cardWidth/4-1,
                        child:  Column(
                          children: <Widget>[
                            Text(user.footer.toString()),
                            Text("最近")
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}