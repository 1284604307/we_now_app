import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowImagePage extends StatefulWidget{
  File image;
  Uint8List image_list;
  ExtendedImage eI;
  String netUrl;

  ShowImagePage({File image,Uint8List list,ExtendedImage extendedImage,String netUrl}) :
        this.image = image,this.image_list = list,this.eI = extendedImage,this.netUrl =netUrl;

  @override
  State<StatefulWidget> createState() {
    return _state(image:image,list:image_list,extendedImage: eI);
  }

}

class _state extends State<ShowImagePage>{
  File image;
  Uint8List image_list;
  ExtendedImage eI;
  String netUrl;

  _state({File image,Uint8List list,ExtendedImage extendedImage,String netUrl}) :
        this.image = image,this.image_list = list,this.eI = extendedImage,this.netUrl =netUrl;

  getExtendedImage(){
    if(image!=null){
      print("---------image不为空");
      return ExtendedImage.file(
        image,width: double.infinity,
        height: double.infinity,
        mode: ExtendedImageMode.gesture ,
      );
    }
    if(image_list!=null){
      print("---------image_list");
      return ExtendedImage.memory(
        image_list,width: double.infinity,
        height: double.infinity,
        mode: ExtendedImageMode.gesture ,
      );
    }
    if(netUrl != null){
      print("喜喜喜喜喜喜");
      return ExtendedImage.network(
        netUrl,width: double.infinity,
        height: double.infinity,
        mode: ExtendedImageMode.gesture ,
      );
    }
    if(eI!=null){
      return eI;
    }
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      child: Container(
        color: Colors.white,
        child:getExtendedImage()
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );
  }

}
