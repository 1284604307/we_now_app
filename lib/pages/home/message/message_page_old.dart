//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_app2/common/Api.dart';
//import 'package:flutter_app2/pages/global/global_config.dart';
//import 'package:flutter_app2/pages/home/chat/chat_page.dart';
//import 'package:flutter_app2/pages/home/circle/test.dart';
//import 'package:flutter_app2/pages/maps/other.dart';
//import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
//import 'package:flutter_app2/pages/wights/avatar.dart';
//import 'package:flutter_app2/pages/wights/page_route_anim.dart';
//import 'package:flutter_app2/services/config/resource_mananger.dart';
//import 'package:flutter_app2/services/config/router_manger.dart';
//import 'package:flutter_app2/services/helper/dialog_helper.dart';
//import 'package:flutter_app2/services/helper/refresh_helper.dart';
//import 'package:flutter_app2/services/model/Message.dart';
//import 'package:flutter_app2/services/model/viewModel/message_model.dart';
//import 'package:flutter_app2/services/model/viewModel/user_model.dart';
//import 'package:flutter_app2/services/provider/provider_widget.dart';
//import 'package:flutter_app2/services/provider/view_state_widget.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:jmessage_flutter/jmessage_flutter.dart';
//import 'package:oktoast/oktoast.dart';
//import 'package:provider/provider.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:sqflite/sqflite.dart';
//
//class MessagePage extends StatefulWidget{
//  @override
//  MessagePageState createState()=>MessagePageState();
//}
//
//class MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin{
//
//  MessageModel mM ;
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    return WillPopScope(
//      child: Scaffold(
//          appBar: AppBar(
//            title: Container(
//              child: InkWell(
//                onTap: ()async{
//                  List<JMConversationInfo> cs =await Api.jMessage.getConversations();
//                  var i =0;
//                  cs.forEach((c)async{
//                    print(i++);
//                    print((c.latestMessage as JMTextMessage).toJson());
////                    print(c.toJson());
////                    JMTextMessage jm = await c.sendTextMessage(text: "厉害了");
////                    print(jm.toJson());
//                  });
////                  l.forEach((m){
////                    print( m.type.toString());
////                    switch(m.type){
////                      case JMMessageType.text:
////                        print((m as JMTextMessage).from.username);
////                        break;
////                      case JMMessageType.image:
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.voice:
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.file:
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.custom:
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.location:
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.event:
////                        print((m as JMEventMessage).toString());
////                        // TODO: Handle this case.
////                        break;
////                      case JMMessageType.prompt:
////                        // TODO: Handle this case.
////                        break;
////                    }
////                  });
//                },
//                child: Text("消息"),
//              ),
//            ),
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(IconFonts.buddy,size: 30,),
//                onPressed: ()  async {
//                  if (Provider.of<UserModel>(context,listen: false).hasUser) {
//                    Navigator.pushNamed(context, RouteName.friend);
//                  }else{
//                    if(await DialogHelper.showLoginDialog("login")){
//                      Navigator.pushNamed(context, RouteName.login);
//                    };
//                  }
//                },
//              )
//            ],
//          ),
//          body: ProviderWidget<MessageViewModel>(
//            onModelReady: (model){
//              model.loadData();
//            },
//            builder: (BuildContext context, messageModel, Widget child) {
//              if(!messageModel.ok)
//                return ViewStateEmptyWidget(
//                  onPressed: () {
//                    Navigator.pushNamed(context, "login");
//                  },
//                  message: "用户未登录",
//                  buttonText: Text("去登陆"),
//                );
//              mM = messageModel.messageModel;
//              List<Message> messages = [];
//              List<String> usernames = [];
//
//              // desc 数据过滤
//              Map<String,MessageGroupModel> map = Provider.of<MessageModel>(context,listen: true).messagesGroup;
//              map.forEach((username,mG){
//                messages.add(mG.getLastMessage());
//                usernames.add(username);
//                print(username);
//              });
//              return SmartRefresher(
//                controller: messageModel.refreshController,
//                header: HomeRefreshHeader(),
//                onRefresh: ()async{
//                  await messageModel.refresh();
//                  messageModel.showErrorMessage(context);
//                },
////                enablePullUp: messageModel.list.isNotEmpty,
//                onLoading: messageModel.loadMore,
//                child: CustomScrollView(
//                  slivers: <Widget>[
//                    if(mM.userNotify.length>0)
//                    SliverToBoxAdapter(
//                      child: RowItem(leftWidget:
//                        RectAvatar(
//                          CachedNetworkImage(
//                            imageUrl: "",
//                          ),width: 50,height: 50,
//                        ),
//                        height: 70,
//                        other: Container(
//                          margin: EdgeInsets.only(left: 10),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text("好友通知",style: TextStyle(fontWeight: FontWeight.bold),),
//                              if(mM.userNotify[0].type == JMContactNotifyType.invite_received)
//                              Text("${mM.userNotify[0].fromUserName} 请求添加您为好友")
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
////                    SliverList(
////                      delegate: SliverChildBuilderDelegate(
////                              (c,i){
////                            return Container(
////                              child: Text("${mM.userNotify[i].fromUserName}"),
////                            );
////                          },
////                          childCount: mM.userNotify.length
////                      ),
////                    ),
//                    SliverList(
//                      delegate: SliverChildBuilderDelegate(
//                          (c,i){
//                            return MessageItem(messages[i],usernames[i]);
//                          },
//                        childCount: messages.length
//                      ),
//                    ),
//                  ],
//                ),
//              );
//            }, model: MessageViewModel(Provider.of<MessageModel>(context,listen: true)),
//
//          )
//      ),
//      onWillPop: () {
//
//      },// 下边框
//    );
//  }
//
//  @override
//  bool get wantKeepAlive => true;
//
//
//}
//
//class MessageItem extends StatelessWidget{
//
//  Function onPressed;
//  Message message;
//  String username;
//
//  MessageItem(this.message,this.username,{this.onPressed});
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: onPressed??(){Navigator.push(context, SlideBaseRouteBuilder.left( ChatScreen( username) ,speed: 5.0));},
//      child: Container(
//        color: Theme.of(context).cardColor,
//        padding: EdgeInsets.all(10),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Avatar(CachedNetworkImage(
//                  fit: BoxFit.cover,
//                  imageUrl: "${message.senderAvatar}",
//                ),
//                  width: 50,
//                  height: 50,),
//                Container(
//                  padding: EdgeInsets.only(left: 10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                          padding: EdgeInsets.only(bottom: 5),
//                          child: new Text(
//                            "${username}",
//                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
//                          ),
//                          alignment: Alignment.topLeft
//                      ),
//                      Container(
//                          child: new Text(
//                            "${message.content}",
//                            overflow: TextOverflow.ellipsis,
//                            style: TextStyle(fontSize: 14,color: Colors.grey),
//                          ),
//                          alignment: Alignment.topLeft
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//            Column(
//              children: <Widget>[
//                Container(
//                    padding: EdgeInsets.only(bottom: 5),
//                    child: new Text(
//                      "${DateTime.fromMillisecondsSinceEpoch(message.createTime??0)}",
//                      style: TextStyle(fontSize: 12,color: Colors.grey),
//                    ),
//                    alignment: Alignment.topRight
//                ),
//                Container(
//                  padding: EdgeInsets.only(bottom: 5),
//
//                  child: new Text(
//                    "",
//                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//}
//
//
//
