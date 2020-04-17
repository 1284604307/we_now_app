import 'package:flutter/material.dart';

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
          title:Text("消息"),
        ),
        body: Container(
          child: RaisedButton(
            child: Text('进入'),
            onPressed: (){
              Navigator.pushNamed(context,"chat");
            },
          ),
        ),
      ), onWillPop: () {
        Navigator.pop(context);
    },
    );
  }
}