import 'package:flutter/material.dart';
/**
 * 个性签名
 */
class Signaturediglog extends AlertDialog {

  Function SignatureText;

 Signaturediglog({
    Key key,
    @required this.SignatureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return AlertDialog(title: Text('个性签名', style: TextStyle(color: Colors.blueAccent)),
          content: TextField(maxLength: 30, maxLengthEnforced: false),
          actions: <Widget>[
            FlatButton(child: Text("确定"), onPressed: () {
              SignatureText();  //desc 传回消息一会补上现在不会..... 顺便学习怎么建立Viewmode
              Navigator.of(context).pop();
            }),
            FlatButton(child: Text("取消"), onPressed: () => Navigator.of(context).pop())
          ]);
                
  }}