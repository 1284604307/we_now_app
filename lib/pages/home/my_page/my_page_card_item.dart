import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class CardItem extends StatelessWidget{
  double width;
  Icon icon;
  String text;
  Function taped;
  CardItem(this.width,{this.icon,this.text,this.taped});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){ if(taped!=null)taped();},
      child: Container(
        width: width,
        margin: EdgeInsets.only(top: 10,bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              width: width/3,
              height: width/3,
              child: icon,
              color: icon==null?Colors.black12:null,
            ),
            Text(text??"测试",textAlign: TextAlign.center,style: TextStyle(
              fontSize: 13
            ),)
          ],
        ),
      ),
    );
  }

}