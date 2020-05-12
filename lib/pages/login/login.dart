import 'dart:async';
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
import 'package:tencent_kit/tencent_kit.dart';

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
  LoginModel model;
  
  static const String _TENCENT_APPID = '1110421384';
  Tencent _tencent = Api.tencent;
  StreamSubscription<TencentLoginResp> _login;
  TencentLoginResp _loginResp;

  @override
  void initState() {
    super.initState();
    _login = _tencent.loginResp().listen(_listenLogin);
  }

  void _listenLogin(TencentLoginResp resp) async {
    _loginResp = resp;
//    String content = 'login: ${resp.openid} - ${resp.accessToken}';
    print(resp.openid);
    print(resp.accessToken);
    try{
      BotToast.showLoading();
      await model.loginByQQ(resp.openid, resp.accessToken);
      Navigator.of(context).pop();
      BotToast.closeAllLoading();
    }catch(e){
      print(e);
      BotToast.closeAllLoading();
    }
  }

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
    return ProviderWidget<LoginModel>(
      model: LoginModel(Provider.of(context)),
      onModelReady: (loginModel){model = loginModel;},
      builder: (c,model,child){
        return WillPopScope(
          child: Scaffold(
//              resizeToAvoidBottomPadding:false,
              appBar: AppBar(
                centerTitle: true,
                title: Text("登录"),
              ),
              body: ListView(
                children: <Widget>[
                  new Container(
                      height: 400,
                      child: Container(
                          margin: EdgeInsets.all(20),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    onTap: (){
                                      Navigator.pushNamed(context, RouteName.register);
                                    },
                                    child: Text("没有账户? 点我注册",style: TextStyle(color: Theme.of(context).primaryColor),),
                                  )
                                ],
                              ),
                              LoginButton(userController,passController),
                            ],
                          )
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Divider(height: 1,),
                  ),
                  new Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            _tencent.login(
                              scope: [TencentScope.GET_SIMPLE_USERINFO],);
                          },
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Image.asset("assets/icons/qq_icon.png",width: 60,height: 60,),
                                Text("QQ 登录",style: TextStyle(),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
          onWillPop: () {
            if(!model.isBusy){
              BotToast.closeAllLoading();
              Navigator.pop(context);
            }
            return;
          },
        );
      },
    );
  }


}

class LoginButton extends StatelessWidget {
  TextEditingController nameController;
  TextEditingController passwordController;

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
              S.of(context).signIn,
              style: Theme.of(context)
                .accentTextTheme
                .title
                .copyWith(wordSpacing: 6),
        ),
        onPressed: model.isBusy
          ? null
          : () {
            if(nameController.text.isEmpty || passwordController.text.isEmpty) return;
            model
                .login(nameController.text, passwordController.text)
                .then((value) {
              if (value) {
                Navigator.of(context).pop(true);
              } else {
                model.showErrorMessage(context);
              }
            });
        },
      ),
    );
  }
}