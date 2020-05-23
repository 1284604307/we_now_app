import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SelectLocationItemInfoDetail extends StatefulWidget{


  SelectLocationItemInfoDetail();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoDetail();
  }

}

class InfoDetail extends State<SelectLocationItemInfoDetail>{

  String title = '疫情地图';
  String url="http://qwdmz.myds.me:8080/yqdt/index.html";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            }),
      ),
      url: "$url",
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,
    );
  }

}