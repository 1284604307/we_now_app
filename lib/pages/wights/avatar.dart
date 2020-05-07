import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * @createDate  2020/4/28
 */
class Avatar extends StatelessWidget {

  StatefulWidget header;
  double width;
  double height;
  double borderWidth;
  Color borderColor;
  List<BoxShadow> boxShadow;


  Avatar(this.header,{this.width,this.height,this.borderColor,this.boxShadow});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: (width??41),
      height: (height??41),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor??Colors.black12),
        borderRadius: BorderRadius.circular(width??40/2),
        boxShadow: this.boxShadow??null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width??40/2),
        child: header,
      ) ,
    );
  }


}

class RectAvatar extends StatelessWidget{

  Widget header;
  double width;
  double height;
  double borderWidth;
  Color borderColor;
  List<BoxShadow> boxShadow;

  RectAvatar(this.header,{this.width,this.height,this.borderColor,this.boxShadow});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: (width??41),
      height: (height??41),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor??Colors.black12),
        borderRadius: BorderRadius.circular(10),
        boxShadow: this.boxShadow??null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: header,
      ) ,
    );
  }

}