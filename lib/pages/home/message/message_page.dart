import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/maps/other.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget{
  @override
  MessagePageState createState()=>MessagePageState();
}

class MessagePageState extends State<MessagePage>{

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Text("消息",style: TextStyle(
                  color: GlobalConfig.titleColor
              ),),
            ),
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: Api.globalScrollController,
            itemCount: 12,
            key: PageStorageKey(2),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: messageWidget(),
//              decoration: BoxDecoration(
//                  border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
//              ),
              );
            },
          )
      ),
      onWillPop: () {

      },// 下边框
    );
  }

  Widget messageWidget(){
    String name = "老王";
    String content = "这里是消息模板";
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SelectLocationFromMapPage();
            }
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 1.0),
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Container(
                child: new Text(
                    name,
                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.3, color: GlobalConfig.dark == true? Colors.white70 : Colors.black)
                ),
                margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                alignment: Alignment.topLeft
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(content)
                  ),
                  new Icon(Icons.linear_scale, color: GlobalConfig.fontColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



