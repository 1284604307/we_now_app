import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/maps/other.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget{
  @override
  MessagePageState createState()=>MessagePageState();
}

class MessagePageState extends State<MessagePage>{

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Text("消息"),
            ),
          ),
          body: ProviderWidget<MessageViewModel>(
            model: MessageViewModel(Provider.of<UserModel>(context)),
            onModelReady: (model){
              model.initData();
            },
            builder: (BuildContext context, messageModel, Widget child) {
              if(!messageModel.userModel.hasUser)
                return ViewStateEmptyWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  message: "用户未登录",
                  buttonText: Text("去登陆"),
                );
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
                    return MessageItem(messageModel.list[i]);
                  },
                  itemCount: messageModel.list.length,
                ),
              );
            },

          )
      ),
      onWillPop: () {

      },// 下边框
    );
  }


}

class MessageItem extends StatelessWidget{

  Function onPressed;
  Message message;

  MessageItem(this.message,{this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed??(){Navigator.pushNamed(context, RouteName.rightTo);},
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
                            "${message.senderId}",
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



