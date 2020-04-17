import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget{
  double width;
  CardItem(this.width);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            width: width/3,
            height: width/3,
            color: Colors.black12,
          ),
          Text("学习记录",textAlign: TextAlign.center,)
        ],
      ),
    );
  }

}