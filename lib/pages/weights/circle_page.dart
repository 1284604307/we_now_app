import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

class CirclePage extends StatefulWidget{
  @override
  CirclePageState createState()=>CirclePageState();
}

class CirclePageState extends State<CirclePage>{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Text("滑稽",style: TextStyle(
              color: GlobalConfig.titleColor
            ),),
          ),
        ),
      ),
      onWillPop: () {
        print("触发了返回键");
      },
      
    );
  }
}