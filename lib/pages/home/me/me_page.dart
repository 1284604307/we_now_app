import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/app.dart';
import 'package:flutter_app2/pages/home/chat/friend_application.dart';
import 'package:flutter_app2/pages/home/circle/circle_person.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'me_info_page.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MePage extends StatefulWidget{

  String username;
  MePage({this.username});

  @override
  State<StatefulWidget> createState() {
    return _State(username: username);
  }

}

class _State extends State<MePage>{
  String username;
  bool netError = false;
  _State({this.username});
  ScrollController _scrollController = ScrollController();

  JMUserInfo userInfo;

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  loadingData(){
    BotToast.showLoading();
    try {
      if (username == null) {
        Api.jMessage.getMyInfo().then((info) {
          BotToast.closeAllLoading();
          print(userInfo);
          info.avatarThumbPath = Provider.of<UserModel>(context,listen: false).user.avatar;
          setState(() {
            userInfo = info;
          });
        });
      }
      else {
        Api.jMessage.getUserInfo(username: username).then((info) {
          print(userInfo);
          BotToast.closeAllLoading();
          setState(() {
            userInfo = info;
          });
        });
      }
    }catch(e){
      netError = true;
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) {

//    var cardWidth = this.width - 50;
    var _tabs = ["动态","个人"];
    double rpx = MediaQuery.of(context).size.width/750;

    return WillPopScope(
        child: Scaffold(
//        appBar: AppBar(),
          body: DefaultTabController(
            length: _tabs.length, // This is the number of tabs.
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  if(netError)
                    ViewStateEmptyWidget(
                      onPressed: () {
                        loadingData();
                      },
                      message: "网络错误",
                      buttonText: Text("重新加载"),
                    ),
                  SliverAppBar(
                    primary: true,// 预留状态栏
                    forceElevated: false, //展开flexibleSpace之后是否显示阴影
                    titleSpacing: NavigationToolbar.kMiddleSpacing,//flexibleSpace 和 title 的距离 默认是重合的
                    snap: false,//与floating结合使用
                    floating: false, //是否随着滑动隐藏标题,滑动到最上面，再snap滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                    pinned: true,  //是否固定在顶部,往上滑，导航栏可以隐藏
                    title: Text(""),
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: userInfo==null?Container():_Header(userInfo,context),
                    ),
                    expandedHeight: 510*rpx,
                    actions: <Widget>[
                      if(userInfo!=null)
                      if(userInfo.username!=Provider.of<UserModel>(context).user.loginName)
                        IconButton(
                          icon: Icon(
                            userInfo.isFriend?Icons.person_pin:Icons.person_add,
                            color: Theme.of(context).primaryColorLight,),
                          onPressed: (){
                            if(!userInfo.isFriend)
                              Navigator.push(context, SizeRoute(FriendApplication(userInfo.username??"")));
                            else{
                              showToast("跳转到好友信息管理页 #1106");
                            }
                          },
                        )
                      else
                        IconButton(
                          onPressed: (){
//                        showToast("应进入修改个人基本信息页");
                            Navigator.push(context, MaterialPageRoute(
                                builder: (c){
                                  return MeInfoPage();
                                }
                            ));
                          },
                          icon: Icon(Icons.mode_edit,color: Theme.of(context).primaryColorLight,),
                        ),
                    ],
//                  bottom: AppBar(
//                    automaticallyImplyLeading: false,
//                    backgroundColor: Colors.transparent,
//                  title:Text("个人资料"),),

                  ),
                  SliverPersistentHeader(	// 可以吸顶的TabBar
                    pinned: true,
                    delegate: StickyTabBarDelegate(
                      color: Theme.of(context).cardColor,
                      child: TabBar(
                        labelColor: Theme.of(context).textTheme.subtitle.color,
                        unselectedLabelColor: Theme.of(context).hintColor,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                      ),
                    ),
                  )
                ];
              },
              body: Material(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  // These are the contents of the tab views, below the tabs.
                  children: _tabs.map((String name) {
                    switch(name){
                      case "动态":
                        return CirclePerson();
                      default:
                        return SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return ListView.builder(itemBuilder: (c,i){
                                return Container(color: Colors.yellow[i*50],height: 60,);
                              },itemCount: 20,);
                            },
                          ),
                        );
                    }
                  }).toList(),
                ),
              ),
            ),
          )
          ,
        ),
        onWillPop: () {
          BotToast.closeAllLoading();
          Navigator.pop(context);
        }
    );
  }



}



const double SEARCH_MARGIN_LEFT = 15.0; // 搜索栏left居左位置

typedef OnOffsetChangeListener = Function(double percent);

_Header(JMUserInfo userInfo,context){
  double rpx = MediaQuery.of(context).size.width/750;
  return  Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/loading.jpg",
          width: 750*rpx,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 240*rpx,
          left: 30*rpx,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Avatar(
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "${userInfo.avatarThumbPath}",
                      ),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${userInfo.nickname}(${userInfo.username})",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      Text("${userInfo.signature.isEmpty?"空空如也~":userInfo.signature}",style: TextStyle(color: Colors.grey[300]),)
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ]
  );
}
