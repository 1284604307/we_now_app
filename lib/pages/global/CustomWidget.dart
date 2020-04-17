import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Global.dart';

class CustomWidget extends StatefulWidget {
  final title;
  CustomWidget(this.title);
  @override
  Widget build(BuildContext context) {
    Global.context = context;

    return WillPopScope(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(44),
        ),
        body: Center(
          child: Center(
            child: Text('过来了'),
          ),
        ),
      ),
      onWillPop: () {
        print("返回上一页");
        Navigator.pop(context);
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
