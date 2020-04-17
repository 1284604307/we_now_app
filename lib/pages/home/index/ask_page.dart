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
                  height: 20,
                  child: new FlatButton.icon(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: new Icon(Icons.arrow_back, color: GlobalConfig.titleColor),
                    label: new Text("", style: new TextStyle(
                        fontSize: 20,
                        color: GlobalConfig.titleColor)),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    child: new Text("提问", style: new TextStyle(
                        fontSize: 20,
                        color: GlobalConfig.titleColor)),
                  )
                ),
                new FlatButton(
                  onPressed: (){},
                  child: new Text("完成", style: new TextStyle(
                      fontSize: 20,
                      color: GlobalConfig.titleColor))
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