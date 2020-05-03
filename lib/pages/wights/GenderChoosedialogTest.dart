import 'package:flutter/material.dart';

class GenderChooseDialog extends Dialog {
  GenderChooseDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Material(
            type: MaterialType.transparency,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      decoration: ShapeDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ))),
                      margin: const EdgeInsets.all(12.0),
                      child: new Column(children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 40.0, 10.0, 28.0),
                            child: Center(
                                child: new Text('请选择性别',
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                    )))),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _genderChooseItemWid(1),
                              _genderChooseItemWid(2)
                            ])
                      ]))
                ])));
                
  }

  Widget _genderChooseItemWid(var gender) {
    return GestureDetector(
        child: Column(children: <Widget>[
      Image.asset(
          gender == 1
              ? '../assets/images/gender/icon_type_boy.png'//'images/icon_type_boy.png'
              : '../assets/images/gender/icon_type_girl.png',//'images/icon_type_girl.png',
          width: 135.0,
          height: 135.0),
      Padding(
          padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 40.0),
          child: Text(gender == 1 ? '我是男生' : '我是女生',
              style: TextStyle(
                  color: Color(gender == 1 ? 0xff4285f4 : 0xffff4444),
                  fontSize: 15.0)))
    ]));
  }
}

