import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'circle_talk.dart';

class CircleRecommend extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<CircleRecommend> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingData(false);
  }

  loadingData(bool refresh) async {
    print("加载数据");
    if (refresh || Api.hotCircles == null || Api.hotCircles.length == 0) {
      var res = await Api.getDio().get("/public/user/circle/").then((json) {
        if (json.statusCode != 200) {
          BotToast.showText(text: "获取数据失败");
          return;
        }
        print(json.data);
        var res = AjaxResult.fromJson(json.data);
        List<CircleEntity> circles = (res.data as List)
            .map((value) => CircleEntity.fromJson(value))
            .toList();
        circles.forEach((v) {
          print(v.toJson());
        });
        Api.hotCircles = circles;
        setState(() {
          BotToast.showText(text: "当前已是最新数据");
        });
      });
      print(res);
    } else {
      print(Api.hotCircles);
    }
  }

  Future<Null> refreshData() async {
    return await loadingData(true);
  }

  Widget noDataView() {
    return new Container(
        height: 730,
        child: Center(
          child: Text("没有数据，刷新一下吧~~"),
        ));
  }

/**
 * 测试顶部栏用的
 * */
  double width;

  Widget haveLiteDataView(cardWidth) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Consumer<UserModel>(
            builder: (context, model, child) => Container(
              padding: EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
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
                            child: InkWell(
                              splashColor: Colors
                                  .green[900], // give any splashColor you want
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  //'assets/images/app/news_round.png',  //desc 加载出错，具体原因未知
                                  'assets/images/app/we_now_round.png',
                                  width: cardWidth / 5 - 10,
                                  height: 60,
                                ),
                              ),
                              onTap: () {
                                //添加刷新
                              },
                            )),
                        Container(
                            width: 10,
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              splashColor: Colors
                                  .green[900], // give any splashColor you want
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/app/we_now_round.png',
                                  width: cardWidth / 5 - 10,
                                  height: 60,
                                ),
                              ),
                              onTap: () {
                                //跳转页
                                print("跳转到" + (Api.login ? 'me' : "login"));
                                Navigator.of(context)
                                    .pushNamed(model.hasUser ? 'me' : "login");
                              },
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              splashColor: Colors
                                  .green[900], // give any splashColor you want
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/app/we_now_round.png',
                                  width: cardWidth / 5 - 10,
                                  height: 60,
                                ),
                              ),
                              onTap: () {
                                //跳转页
                                print("跳转到" + (Api.login ? 'me' : "login"));
                                Navigator.of(context)
                                    .pushNamed(model.hasUser ? 'me' : "login");
                              },
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              splashColor: Colors
                                  .green[900], // give any splashColor you want
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/app/we_now_round.png',
                                  width: cardWidth / 5 - 10,
                                  height: 60,
                                ),
                              ),
                              onTap: () {
                                //跳转页
                                print("跳转到" + (Api.login ? 'me' : "login"));
                                Navigator.of(context)
                                    .pushNamed(model.hasUser ? 'me' : "login");
                              },
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              splashColor: Colors
                                  .green[900], // give any splashColor you want
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/app/we_now_round.png',
                                  width: cardWidth / 5 - 10,
                                  height: 60,
                                ),
                              ),
                              onTap: () {
                                //跳转页
                                print("跳转到" + (Api.login ? 'me' : "login"));
                                Navigator.of(context)
                                    .pushNamed(model.hasUser ? 'me' : "login");
                              },
                            )),
                      ],
                    ),
                    Container(  //人员名称
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth / 5 - 1,
                            child: Column(
                              children: <Widget>[Text("最新更新")],
                            ),
                          ),
                          Container(
                              width: 10,
                              height: 10,
                              child: VerticalDivider(color: Colors.grey)),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth / 5 - 1,
                            child: Column(
                              children: <Widget>[Text("张三")],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth / 5 - 1,
                            child: Column(
                              children: <Widget>[Text("李四")],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth / 5 - 1,
                            child: Column(
                              children: <Widget>[Text("王五")],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: cardWidth / 5 - 1,
                            child: Column(
                              children: <Widget>[Text("套娃")],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
//          margin: const EdgeInsets.only(top: 20.0),
      color: GlobalConfig.globalBackgroundColor,
      child: RefreshIndicator(
          onRefresh: refreshData,
          child: new ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: Api.hotCircles.length == 0 ? 1 : Api.hotCircles.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 && Api.hotCircles.length == 0) {
                width = MediaQuery.of(context).size.width;
                var cardWidth = this.width - 50;
                return haveLiteDataView(cardWidth);
                //return noDataView();
              }
              return talkWidget(context, index, Api.hotCircles[index]);
            },
            physics: new AlwaysScrollableScrollPhysics(),
          )),
    );
  }
}
