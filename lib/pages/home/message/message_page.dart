import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

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
        body: Container(
          child: RaisedButton(
            child: Text('进入'),
            onPressed: (){
              Navigator.pushNamed(context,"chat");
            },
          ),
        ),
      ),
      onWillPop: () {

      },
    );
  }
}