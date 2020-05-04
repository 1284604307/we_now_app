import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/common/Api.dart';

/**
 * @createDate  2020/5/4
 */
class FriendApplication extends StatefulWidget {

  String username;

  FriendApplication(this.username);

  @override
  _State createState() => _State(this.username);

}

class _State extends State<FriendApplication> {

  String username;

  _State(this.username);
  TextEditingController reasonT =  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("添加好友"),centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: InkWell(
              child: Text("发送"),
              onTap: (){
                BotToast.showLoading();
                Api.jMessage.sendInvitationRequest(username: this.username, reason: reasonT.text);
                BotToast.closeAllLoading();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                helperText: "填写申请理由"
              ),
              controller: reasonT,
            )
          ],
        ),
      ),
    );
  }

}