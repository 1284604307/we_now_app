import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/home/me/me_info_page.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/model/viewModel/friend_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/5
 */
class FriendListPage extends StatefulWidget {

  @override
  _State createState() => _State();

}

class _State extends State<FriendListPage> {



  RefreshController rc = RefreshController();
  @override
  Widget build(BuildContext context) {
    FriendModel friendModel = Provider.of<FriendModel>(context);
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("友人"),),
//        body: ProviderWidget<FriendRefreshModel>(
//          builder:(c,m,child){
//            return
          body:SmartRefresher(
            onRefresh: () async { await friendModel.loadData(); rc.refreshCompleted();},
            enablePullUp: false,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        child: RowItem(left:" 新朋友 "),
                      ),
                    ),
                  ),
                  SliverList(delegate: SliverChildBuilderDelegate(
                        (c,i){
                      return FriendItem(friendModel.friends[i]);
                    },
                    childCount:  friendModel.friends.length,
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

  @override
  void initState() {
    if(Provider.of<FriendModel>(context,listen: false).friends.length==0)
      Provider.of<FriendModel>(context,listen: false).loadData();
  }
}

class FriendItem extends StatelessWidget{

  JMUserInfo user;
  FriendItem(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        Navigator.of(context).push(SizeRoute(MePage(username: user.username,)));
      },
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Avatar(AvatarImage(user.username)),
            Padding(padding: EdgeInsets.only(left: 10),child: Container(
              width: MediaQuery.of(context).size.width-80,
              child: Text("${user.nickname}(${user.username})",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),),
          ],
        ),
      ),
    );
  }

}