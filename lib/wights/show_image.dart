import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowImagePage extends StatefulWidget{
  File image;

  ShowImagePage( this.image);

  @override
  State<StatefulWidget> createState() {
    print(image);
    return _state(image);
  }

}

class _state extends State<ShowImagePage>{
  File image;
  _state( this.image);

  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      child: Container(
        color: Colors.white,
        child: ExtendedImage.file(
          image,
          width: double.infinity,
          height: double.infinity,
          mode: ExtendedImageMode.gesture,
        ),
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );
  }

}
