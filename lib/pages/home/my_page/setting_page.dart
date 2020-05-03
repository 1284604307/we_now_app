import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:provider/provider.dart';

/**
 * @createDate  2020/4/26
 */
class SettingPage extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置"),
      ),
      body:
      ProviderWidget<LoginModel>(
        model: LoginModel(Provider.of(context)),
        builder: (BuildContext context, LoginModel model, Widget child) {
          return Column(
              children: <Widget>[
                if (model.isBusy)
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                  ),
                if(model.userModel.hasUser)
                  ...[
                    RowItem(left:"个人资料"),
                    RowItem(left:"消息通知"),
                    RowItem(left:"账号绑定"),
                  ],
                Container(height: 10,color: Colors.transparent,),
                ...[
                  RowItem(left:"检测新版本"),
                  RowItem(left:"关于我们"),
                ],
                Container(height: 10,color: Colors.transparent,),
                if(model.userModel.hasUser)
                  RowItem(
                  left: "退出登录",
                  action: <Widget>[
                    IconButton(
                      tooltip: "logout",
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        model.logout().then((bool) {
                          if (bool) {
                            Navigator.pushReplacementNamed(context, "login");
                          } else {BotToast.showText(text: "退出失败");}
                        });
                      },
                    )
                  ],
                ),
              ]
          );
        }
      ),
    );
  }
}