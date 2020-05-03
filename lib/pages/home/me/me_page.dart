import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:oktoast/oktoast.dart';

import 'me_info_page.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class MePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
//    var cardWidth = this.width - 50;
    var _tabs = ["动态","个人"];
    return WillPopScope(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,// 预留状态栏
                  forceElevated: true, //展开flexibleSpace之后是否显示阴影
                  titleSpacing: NavigationToolbar.kMiddleSpacing,//flexibleSpace 和 title 的距离 默认是重合的
                  expandedHeight: 380.0,
                  snap: false,//与floating结合使用
                  floating: false, //是否随着滑动隐藏标题,滑动到最上面，再snap滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                  pinned: true,  //是否固定在顶部,往上滑，导航栏可以隐藏
                  title: Text("{用户名}的个人详情"),
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
                    )
                  ],
                  flexibleSpace: Container(
                    child: Stack(
                      children: <Widget>[
                        Text("滑稽"),
                        Container(
                          width: double.infinity,
                          child: Image.asset(ImageHelper.wrapAssets('home_second_floor_builder.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
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