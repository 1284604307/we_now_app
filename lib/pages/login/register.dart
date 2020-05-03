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
import 'package:flutter_app2/pages/wights/button_progress_indicator.dart';
import 'package:flutter_app2/pages/wights/login_widget.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class RegisterPage extends StatefulWidget{
  @override
  LoginPageState createState()=>LoginPageState();
}

class LoginPageState extends State<RegisterPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();
  TextFormField passwordText;
  String passHelper = "";
  String userHelper = "";
  String passAHelper = "";

  var _showPass = false;
  bool userT = false;
  bool passT = false;
  bool passAT = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.addListener((){
      if(userController.text.length<6){
        userHelper = "用户名位数应大于6";
        userT = false;
      }else{
        userT = true;
        userHelper = "";
      }
      setState(() {});
    });
    passController.addListener((){
      if(passController.text.isEmpty){
        passT = false;
        passHelper = "密码不能为空！";
      }else {
        passHelper = "";
        passT = true;
      }
      setState(() {});
    });
    passwordAgainController.addListener((){
      if(passwordAgainController.text!=passController.text){
        passAHelper = "两次密码不一致！";
        passAT = false;
      }else{
        passAHelper = "";
        passAT = true;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Global.context = context;

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(S.of(context).signUp),
          ),
          body: new SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: ProviderWidget<LoginModel>(
                    model: LoginModel(Provider.of(context)),
                    builder: (context, model, child) {
                      return Form(
                        onWillPop: () async {
                          return !model.isBusy;
                        },
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: userController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  icon: Icon(Icons.perm_contact_calendar,color: Colors.black54,),
                                  labelText: '用户名 - 位数>=6',
                                  helperStyle: TextStyle(color: Colors.red),
                                  helperText: userHelper,
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
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                icon: Icon(Icons.verified_user,color: Colors.black54),
                                labelText: '请输入密码 )',
                                helperStyle: TextStyle(color: Colors.red),
                                helperText: passHelper,
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
                            ),
                            TextFormField(
                              controller: passwordAgainController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                icon: Icon(Icons.verified_user,color: Colors.black54),
                                labelText: '请再次输入密码 )',
                                helperText: passAHelper,
                                helperStyle: TextStyle(color: Colors.red),
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
                            ),
                            // desc 注册逻辑
                            Container(
                              width: 300,
                              child: LoginButtonWidget(
                                child: model.isBusy
                                    ? ButtonProgressIndicator()
                                    : Text(
                                  S.of(context).signUp,
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .title
                                      .copyWith(wordSpacing: 6),
                                ),
                                onPressed: model.isBusy
                                    ? null
                                    : () {
                                  if (userT&&passT&&passAT) {
                                    model
                                      .register(userController.text, passController.text)
                                      .then((value) {
                                        if (value) {
                                          Navigator.of(context).pop();
                                        } else {
                                          model.showErrorMessage(context);
                                        }
                                      }
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
              )
          )
      ), onWillPop: () {
          Navigator.pop(context);
      },
    );
  }


}
