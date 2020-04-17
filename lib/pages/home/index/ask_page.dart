import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

class AskPage extends StatefulWidget {

  @override
  AskPageState createState() => new AskPageState();
}

class AskPageState extends State<AskPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Container(
            child: new Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: new IconButton(
                    alignment: Alignment.centerLeft,
                    iconSize: 30,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: new Icon(Icons.arrow_back),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    alignment: Alignment.center,
                    child: new Text("提问", style: new TextStyle(
                      fontSize: 22,
                    )),
                  )
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.check),
                  onPressed: () {},
                )
              ],
            ),
          )
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new TextField(
                  decoration: new InputDecoration(
                      hintText: "请输入标题",
                      hintStyle: new TextStyle(color: GlobalConfig.fontColor)
                  ),
                ),
                margin: const EdgeInsets.all(16.0),
              )

            ],
          ),
        )
      )
    );
  }

}