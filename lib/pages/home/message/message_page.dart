import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/chat/chat_page.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/maps/other.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/dialog_helper.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sqflite/sqflite.dart';

class MessagePage extends StatefulWidget{
  @override
  MessagePageState createState()=>MessagePageState();
}

class MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin{

  MessageModel mM ;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: InkWell(
                onTap: ()async{
                  Message nM = Message();
                  showToast("是我JMTextMessage");
                  nM.serverMessageId = "12";
                  nM.fromUsername = "测试";
                  nM.targetUsername = "admin";
                  nM.createTime = 1234567891111;
                  nM.content = "你看到我变化了，神奇的故事发送了";
                  nM.type = "测试";
                  nM.extras = "{}";
                  nM.senderAvatar = "";
//                  var s = await Api.db.insert("wenow_message", nM.toJson());
//                  print("插入 serverMessageId $s 数据成功--------------------------------");
//                  Provider.of<MessageModel>(context,listen: false).receiverMessage(nM);
                  Provider.of<MessageModel>(context,listen: false).receiverMessage(nM);
                },
                child: Text("消息"),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(IconFonts.buddy,size: 30,),
                onPressed: ()  async {
                  if (Provider.of<UserModel>(context,listen: true).hasUser) {
                    Navigator.pushNamed(context, "test");
                  }else{
                    if(await DialogHelper.showLoginDialog("login")){
                      Navigator.pushNamed(context, RouteName.login);
                    };
                  }
                },
              )
            ],
          ),
          body: ProviderWidget<MessageViewModel>(
            onModelReady: (model){
              model.loadData();
            },
            builder: (BuildContext context, messageModel, Widget child) {
              if(!messageModel.ok)
                return ViewStateEmptyWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  message: "用户未登录",
                  buttonText: Text("去登陆"),
                );
              mM = messageModel.messageModel;
              List<Message> messages = Provider.of<MessageModel>(context,listen: true).getMessageList();
              messages.forEach((m){
                print(m.toJson());
              });
              return SmartRefresher(
                controller: messageModel.refreshController,
                header: HomeRefreshHeader(),
                onRefresh: ()async{
                  await messageModel.refresh();
                  messageModel.showErrorMessage(context);
                },
//                enablePullUp: messageModel.list.isNotEmpty,
                onLoading: messageModel.loadMore,
                child: ListView.builder(itemBuilder: (c,i){
                    return MessageItem(messages[i]);
                  },
                  itemCount: messages.length,
                ),
              );
            }, model: MessageViewModel(Provider.of<MessageModel>(context,listen: true)),

          )
      ),
      onWillPop: () {

      },// 下边框
    );
  }

  @override
  bool get wantKeepAlive => true;


}

class MessageItem extends StatelessWidget{

  Function onPressed;
  Message message;

  MessageItem(this.message,{this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed??(){Navigator.push(context, SlideBaseRouteBuilder.left( ChatScreen( message.fromUsername) ,speed: 5.0));},
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Avatar(CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "${message.senderAvatar}",
                ),
                  width: 50,
                  height: 50,),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: new Text(
                            "${message.fromUsername}",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.topLeft
                      ),
                      Container(
                          child: new Text(
                            "${message.content}",
                            style: TextStyle(fontSize: 14,color: Colors.grey),
                          ),
                          alignment: Alignment.topLeft
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: new Text(
                      "${message.createTime}",
                      style: TextStyle(fontSize: 12,color: Colors.grey),
                    ),
                    alignment: Alignment.topRight
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: new Text(
                    "",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}



