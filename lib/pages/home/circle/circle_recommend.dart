import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';

import 'circle_talk.dart';

class CircleRecommend extends StatefulWidget {

  @override
  _State createState() => new _State();

}

class _State extends State<CircleRecommend> {

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Container(
//          margin: const EdgeInsets.only(top: 20.0),
          color: GlobalConfig.globalBackgroundColor,
          child: new ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return talkWidget(index);
            },
          ),
        )
    );
  }
}