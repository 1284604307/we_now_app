import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
//    var cardWidth = this.width - 50;
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text("信息",style: TextStyle(
              color: Colors.white
          ),),
        ),
        body: Container(

          child: Text("哈哈"),
        ),
      ),
      onWillPop: () {

      }
    );
  }

}