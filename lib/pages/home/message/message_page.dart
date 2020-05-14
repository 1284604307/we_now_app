import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/chat/single_chat_scene.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/maps/other.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/dialog_helper.dart';
import 'package:flutter_app2/services/helper/jpush_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: InkWell(
                child: Text("消息"),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(IconFonts.buddy,size: 30,),
                onPressed: ()  async {
                  if (Provider.of<UserModel>(context,listen: false).hasUser) {
                    Navigator.pushNamed(context, RouteName.friend);
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
              model.refresh();
            },
            builder: (BuildContext context, messageModel, Widget child) {
              if(!Provider.of<UserModel>(context).hasUser)
                return ViewStateEmptyWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  message: "用户未登录",
                  buttonText: Text("去登陆"),
                );
              ConversationModel mModel = Provider.of<ConversationModel>(context,listen: true);

              ConversationModel cM =  Provider.of<ConversationModel>(context,listen: true);
              return SmartRefresher(
                controller: messageModel.refreshController,
                header: HomeRefreshHeader(),
                onRefresh: ()async{
                  await messageModel.refresh();
                  messageModel.showErrorMessage(context);
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    if(cM.notifies.length>0)
                    SliverToBoxAdapter(
                      child: Container(
                        color: Theme.of(context).cardColor,
                        padding: EdgeInsets.all(10),
                        child:InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(RouteName.friendNotify);
                          },
                          child:  Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: RectAvatar(null,width: 50,height: 50,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("好友通知",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("${cM.notifies[cM.notifies.length-1].fromUserName}"+JpushHelper.parseNotify(cM.notifies[cM.notifies.length-1]))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (c,i){
                            JMConversationInfo conversation = mModel.cs[i];
                            return ConversationItem(conversation);
                          },
                        childCount: mModel.cs.length
                      ),
                    ),
                  ],
                ),
              );
            }, model: MessageViewModel(Provider.of(context,listen: true)),

          )
      ),
      onWillPop: () {

      },// 下边框
    );
  }

  @override
  bool get wantKeepAlive => true;



}

class ConversationItem extends StatelessWidget{

  Function onPressed;
//  JMTextMessage message;
  JMConversationInfo conversation;

  ConversationItem(this.conversation,{this.onPressed});

  @override
  Widget build(BuildContext context) {

    JMNormalMessage message = conversation.latestMessage;
    String msgTime;
    String messageText;
    if (conversation.latestMessage is JMTextMessage) {
      var textMsg = JMTextMessage.fromJson(conversation.latestMessage.toJson());
      messageText = textMsg.text;
    } else if (conversation.latestMessage is JMImageMessage) {
      messageText = '[图片]';
    } else {
      messageText = '欢迎加入群聊！';
    }
    return InkWell(
      onTap: onPressed??(){Navigator.push(context, SlideBaseRouteBuilder.left( SingleChatScene(userInfo: conversation.target,) ,speed: 5.0));},
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Avatar(CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "${conversation.target}",
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
                          // desc 会话名
                          child: new Text(
                            "${conversation.title}",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.topLeft
                      ),
                      Container(
                          width: 240,
                          child: new Text(
                            "${messageText}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                      "${msgTime??""}",
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



