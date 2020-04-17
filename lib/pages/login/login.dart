import 'dart:collection';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/Global.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState()=>LoginPageState();
}

class LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextFormField passwordText;
  var _showPass = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Global.context = context;


    passwordText = TextFormField(
      controller: passController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.verified_user),
        labelText: '请输入密码 )',
        helperText: '',
        suffix:  IconButton(
          icon: Icon(_showPass ? Icons.visibility : Icons.visibility_off),
          // 点击改变显示或隐藏密码
          onPressed: (){
            setState(() {
              _showPass = !_showPass;
            });
          },
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_showPass,
    );
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding:false,
  //        appBar: AppBar(
  //          backgroundColor: Colors.blueAccent,
  //          centerTitle: true,
  //          title: Text("登录",style: TextStyle(
  //              color: Colors.white
  //          ),),
  //        ),
          body: Container(
            alignment: Alignment.center,
            child: new Container(
                height: 400,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        child:Text(
                          "登录",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        )
                      ),
                      TextFormField(
                        controller: userController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.perm_contact_calendar),
                            labelText: '请输入你的用户名 )',
                            helperText: '',
                            suffix:  IconButton(
                              icon: Icon(Icons.close),
                              onPressed: (){
                                setState(() {
                                  userController.clear();
                                });
                              },
                            )
                          ),
                        autofocus: true,
                      ),
                      passwordText,
                      RaisedButton(
                        onPressed: login,
                        child: Text('登录'),
                        color: Colors.blue,
                        padding: EdgeInsets.only(left:100,right: 100,top: 10,bottom: 10),
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
            ),
          )
      ), onWillPop: () {
          print("退出登录页");
        Navigator.pop(context);
      },
    );
  }


  Future<void> login() async {
    var data = {'username': userController.text, 'password': passController.text,'rememberMe':false};
    print(data);

    FormData formData = new FormData.fromMap(data);

    Dio dio = Api.getDio();
    var response = await dio.post("http://192.168.101.7:8888/login", data:formData);
    if(response.statusCode==200){
      var res = json.decode(response.toString());
      print(res["code"]);
      if(res["code"]==0){
        BotToast.showText(text: "登陆成功");
        User.initInfo().then((){
          Navigator.pop(context,"update");
        });
      }else{
        BotToast.showText(text:res['msg']);
        print(res['msg']);
      }
    }

  }

}