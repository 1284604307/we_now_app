import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/wights/bottom_clipper.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:provider/provider.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MySelfCard extends StatelessWidget{

  double width;

  MySelfCard(this.width);



  @override
  Widget build(BuildContext context) {
    var cardWidth = this.width - 50;
    // TODO: implement build
    return
        card(cardWidth);
  }

  card(cardWidth){
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child:Consumer<UserModel>(
            builder: (context, model, child) => Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              width: width,
              child: Center(
                // 第一行 头像 + 用户名
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // desc 头像
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child:InkWell(
                              splashColor: Colors.green[900], // give any splashColor you want
                              onTap: () {
                                print("跳转到"+(Api.login?'me':"login"));
                                Navigator.of(context).pushNamed(model.hasUser?'me':"login");
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: model.hasUser?
                                Image.network(
                                  model.user.avatar,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ):
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black12
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("登录",style: TextStyle(fontSize: 24,color: Colors.lightBlueAccent),),
                                ),
                              ),
                            )

                        ),
                        // desc 用户名
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(6),
                              child: Text(
                                "${model.hasUser?model.user.userName:"未登录"}",
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
                                        "lv ${model.hasUser?model.user.lv:0}",
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
                                Text("${model.hasUser?model.user.createCount:9999}"),
                                Text("动态")
                              ],
                            ),
                          ), Text("|"),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth/4-1,

                            child: Column(
                              children: <Widget>[
                                Text("${model.hasUser?model.user.likeCount:9999}"),
                                Text("关注")
                              ],
                            ),
                          ),Text("|"),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth/4-1,
                            child:  Column(
                              children: <Widget>[
                                Text("${model.hasUser?model.user.collectCount:9999}"),
                                Text("收藏")
                              ],
                            ),
                          ),Text("|"),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth/4-1,
                            child:  Column(
                              children: <Widget>[
                                Text("${model.hasUser?model.user.followCount:9999}"),
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
          )
      ),
    );
  }

}