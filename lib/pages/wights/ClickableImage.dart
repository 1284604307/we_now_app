import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/show_image.dart';

class ClickableImage extends StatelessWidget{

  File image;
  Uint8List image_list;
  bool loadFromFile = true;
  ClickableImage({File file,Uint8List list}){
    this.image = file;this.image_list = list;
    if(image==null) loadFromFile = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: image_list!=null?
        ExtendedImage.memory(
          image_list,width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )
          :
        ExtendedImage.file(
          image,width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )
      ,
      onTap: (){
        print("双击");
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          print(image);
          return ShowImagePage(list: image_list,image: image);
        })
        );
      },
    );
  }



}