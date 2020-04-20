import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

/**
 * @author Ming
 * @date 2020/4/19
 * @email 1284604307@qq.com
 */



Widget talkWidget(count){

  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 10),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child:  Container(width: 40,height: 40,color: Colors.black12,),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,//垂直方向 向左靠齐
                  children: <Widget>[
                    Text(
                      "发布人",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "2小时前xxxxxxxxxxxxxxx",
                      maxLines: 5,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          children: <Widget>[
            new Container(
                child: new Text(
                    "就像蝴蝶飞呀飞呀飞\nxxxxxxxxxxxxxxxxxxxxxxxxxxx\n",
                ),
                margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                alignment: Alignment.topLeft
            ),
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: count,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //横轴三个子widget
                crossAxisSpacing: 5,mainAxisSpacing: 5
              ),
              itemBuilder: (i,c){
                return Container(
                  color: Colors.lightBlueAccent,
                );
              },
            ),
          ],
        )
      ],
    ),
  );
}

class CreateCirclePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State();
  }

}

class _State extends State<CreateCirclePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("创作"),
        actions: <Widget>[

        ],
      ),
      body: Container(

      ),
    );
  }

}