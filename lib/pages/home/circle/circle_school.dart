import 'dart:ffi';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

import 'circle_talk.dart';

class CircleSchool extends StatefulWidget {

  @override
  _State createState() => new _State();

}

class _State extends State<CircleSchool> {

  List<CircleEntity> hotCircles = [
    CircleEntity.fromJson({
      "name":"滑稽",
      "name":"123",
      "content":"123",
      "createDate":"123",
      "url": null,
      "type":"123",
      "user":"{}"
    })
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  loadingData(bool refresh)async{
    print("加载数据");
    if(refresh||Api.hotCircles==null||Api.hotCircles.length==0){
      var res = await Api.getDio().get("/public/user/circle/").then(
              (json){
            if(json.statusCode != 200){
              BotToast.showText(text: "获取数据失败");
              return;
            }
            print(json.data);
            var res = AjaxResult.fromJson(json.data);
            List<CircleEntity> circles =
              (res.data as List).map((value) => CircleEntity.fromJson(value)).toList();
            circles.forEach((v){print(v.toJson());});
            Api.hotCircles = circles;
            setState(() {
              BotToast.showText(text: "当前已是最新数据");
            });
          }
      );
      print(res);
    }else{
      print(Api.hotCircles);
    }
  }

  Future<Null> refreshData() async{
    return await loadingData(true);
  }

  Widget noDataView(){
    return new Container(
      height: 730,
      child: Center(
          child: Text("没有数据，刷新一下吧~~"),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
//          margin: const EdgeInsets.only(top: 20.0),
      color: GlobalConfig.globalBackgroundColor,
      child: RefreshIndicator(
        onRefresh: refreshData,
        child:  new ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: hotCircles.length==0?1:hotCircles.length,
              itemBuilder: (BuildContext context, int index) {
                if(index==0&&hotCircles.length==0){
                  return noDataView();
                }
                return talkWidget(context,index,hotCircles[index]);
              },
              physics: new AlwaysScrollableScrollPhysics(),
            )
        ),
    );
  }
}

