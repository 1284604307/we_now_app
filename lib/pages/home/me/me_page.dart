import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/app.dart';
import 'package:flutter_app2/pages/home/chat/friend_application.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:oktoast/oktoast.dart';

import 'me_info_page.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MePage extends StatelessWidget{

  ScrollController _scrollController = ScrollController();
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
                    background: Header(),
                  ),
                  expandedHeight: 510*rpx,
                  actions: <Widget>[
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
                    IconButton(
                      icon: Icon(Icons.person_add,color: Theme.of(context).primaryColorLight,),
                      onPressed: (){
                        Navigator.push(context, SizeRoute(FriendApplication("1234567")));
                      },
                    )
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
                  return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (BuildContext context) {
                        return Container();
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        )
        ,
      ),
      onWillPop: () {
        Navigator.pop(context);
      }
    );
  }

}



const double SEARCH_MARGIN_LEFT = 15.0; // 搜索栏left居左位置

typedef OnOffsetChangeListener = Function(double percent);

class Header extends StatelessWidget {

  Header({
    Key key,
    this.offset: 0.0,// 外部驱动的偏移属性
    this.cityName,
    this.onOffsetChangeListener,
  }) : super(key: key);

  final double offset;
  final String cityName;
  final OnOffsetChangeListener onOffsetChangeListener;

  double searchLeft    = SEARCH_MARGIN_LEFT;
  double searchLeftEnd = SEARCH_MARGIN_LEFT;

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width/750;
    return Stack(
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
                          imageUrl: "http://i2.hdslb.com/bfs/face/06a07dad46ecb426e26e3340b3ae4e6f308066ea.jpg@70w_70h_1c_100q.webp",
                        ),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("用户名",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        Text("个性签名",style: TextStyle(color: Colors.white),)
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

}

//class HeaderState extends State<Header> with TickerProviderStateMixin {
//
//  @override
//  Widget build(BuildContext context) {
//    double rpx = MediaQuery.of(context).size.width/750;
//    return Stack(
//      overflow: Overflow.clip,
//      children: <Widget>[
//        Column(
//          children: <Widget>[
//            Image.asset("/assets/images/loading.jpg",height: 300*rpx,width: 750*rpx,),
//            Container(height: 100*rpx,),
//            Container(height: 100*rpx,)
//          ],
//        )
//      ]
//    );
//  }
//
//}
