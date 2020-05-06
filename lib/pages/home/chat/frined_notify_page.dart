import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/helper/jpush_helper.dart';
import 'package:flutter_app2/services/model/viewModel/friend_model.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/5
 */
class FriendNotifyPage extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<FriendNotifyPage> {

  RefreshController rc = RefreshController();
  @override
  Widget build(BuildContext context) {

    ConversationModel cM = Provider.of<ConversationModel>(context);

    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("好友通知"),centerTitle: true,),
//        body: ProviderWidget<FriendRefreshModel>(
//          builder:(c,m,child){
//            return
          body:SmartRefresher(
            enablePullUp: false,
            enablePullDown: false,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15,bottom: 15),
                      child: RowItem(other:Text("暂无被过滤的通知 ")),
                    ),
                  ),
                  SliverList(delegate: SliverChildBuilderDelegate(
                        (c,i){
                         UserNotifyMessage notify =  cM.notifies[i];

                      return RowItem(
                          onPressed:(){
                            showToast("进入到好友请求详细页");
                          } ,
                          other:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${notify.fromUserName}",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${JpushHelper.parseNotify(notify)}",style: TextStyle(color: Colors.grey),),
                              Text("${notify.reason}",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                          action: <Widget>[
                            if(notify.done)
                              Text("${notify.status}")
                            else
                              RaisedButton(onPressed: () {
                                  showToast("${notify.done}");
//                                  try{
//                                    Api.jMessage.acceptInvitation(username: notify.fromUserName);
//                                  }catch(e){
//                                    print(e);
//                                    //805002 already is friend
//                                  }
                                },
                                child: Text("同意",style: TextStyle(color: Theme.of(context).cursorColor),),
                                color: Theme.of(context).cardColor,
                              )
                          ],
                          height:86,
                      );
                    },
                    childCount:  cM.notifies.length,
                  ))
                ],
              ),
              controller: rc,//m.refreshController
            )
//        }, model: FriendRefreshModel(Provider.of<FriendModel>(context)) ,
        )
//      ),
    );
  }
}

class FriendItem extends StatelessWidget{

  JMUserInfo user;
  FriendItem(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Avatar(CachedNetworkImage(imageUrl: "${user.avatarThumbPath}",)),
          Padding(padding: EdgeInsets.only(left: 10),child: Text("${user.nickname}(${user.username})"),),
        ],
      ),
    );
  }

}