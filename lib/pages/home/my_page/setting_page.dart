import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[
          ProviderWidget<LoginModel>(
            model: LoginModel(Provider.of(context)),
            builder: (BuildContext context, LoginModel model, Widget child) {
//              if (model.isBusy) {
//                return Padding(
//                  padding: const EdgeInsets.only(right: 15.0),
//                );
//              }
              if (model.userModel.hasUser) {
                return Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("退出登录"),
                      ),
                      IconButton(
                        tooltip: "logout",
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          model.logout().then((bool){
                            if(bool){
                              Navigator.pushReplacementNamed(context, "login");
                            }else{
                              BotToast.showText(text: "退出失败");
                            }
                          });
                        },
                      )
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}