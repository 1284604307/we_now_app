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
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:provider/provider.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState()=>LoginPageState();
}

class LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextFormField passwordText;
  var _showPass = false;
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  var _isLoading = false;


  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Global.context = context;

    passwordText = TextFormField(
      controller: passController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.verified_user,color: Colors.black54),
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
          appBar: AppBar(
            centerTitle: true,
            title: Text("登录"),
          ),
          body: Container(
            alignment: Alignment.center,
            child: new Container(
                height: 400,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: ProviderWidget<LoginModel>(
                    model: LoginModel(Provider.of(context)),
                    child:Column(
                      children: <Widget>[
                        TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.perm_contact_calendar,color: Colors.black54,),
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
                        LoginButton(userController,passController),
                      ],
                    ),
                    builder: (context, model, child) {
                      return Form(
                        onWillPop: () async {
                          return !model.isBusy;
                        },
                        child: child,
                      );
                    },
                  )
                )
            ),
          )
      ), onWillPop: () {
          print("退出登录页");
          Navigator.pop(context);
      },
    );
  }


}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return Container(
      width: 300,
      child: LoginButtonWidget(
        child: model.isBusy
            ? ButtonProgressIndicator()
            : Text(
              "登录",//S.of(context).signIn
              style: Theme.of(context)
                .accentTextTheme
                .title
                .copyWith(wordSpacing: 6),
        ),
        onPressed: model.isBusy
            ? null
            : () {
          var formState = Form.of(context);
          if (formState.validate()) {
            model
                .login(nameController.text, passwordController.text)
                .then((value) {
              if (value) {
                Navigator.of(context).pop(true);
              } else {
                model.showErrorMessage(context);
              }
            });
          }
        },
      ),
    );
  }
}