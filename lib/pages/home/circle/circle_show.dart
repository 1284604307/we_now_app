import 'package:bot_toast/bot_toast.dart';
import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShowCircle extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _state();
  }

}

class _state extends State<ShowCircle>
    with SingleTickerProviderStateMixin {

  TabController tabController;
  PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    var _tabs = ["评论","点赞"];

    var content = "滑稽\n滑天下之大稽\n滑稽之天下滑稽，滑稽也\n有云，滑稽之大着，滑天下也！\n\n\n\n\n\n\n 是言滑稽者，大暨！";
    var time = "2020/4/24 17:00";
    var watch = 9999;
    return SlidingUpPanel(
      minHeight: 45,
      maxHeight: 600,
      backdropEnabled: true,
      controller: panelController,
      header: Container(
        width: 400,
        height: 45,
        color: Colors.black12,
        child:Material(
          child:  bottomWidget(),
        ),
      ),
      panel: Material(
        // desc 底部三大件， 上拉
        child: Container(
          padding: EdgeInsets.only(top: 50,left: 5,right: 5),
          alignment: Alignment.topCenter,
//          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    maxLength: 255,
                    minLines: 1,
                    maxLines: 10,
                    decoration: new InputDecoration(
                      hintText: "写点评论吧~",
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){print("阿布");},
                child: Text("发布",style: TextStyle(color: Colors.blue),),
              )
            ],
          ),
        ),
      ),
      body: Scaffold(
          appBar: AppBar(
            title: Text("详情"),
          ),
          body: DefaultTabController(
              length: _tabs.length, // This is the number of tabs.
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      child:
                      SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            circleShow(),
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
                    // These are the contents of the tab views, below the tabs.
                    children: _tabs.map((String name) {
                      return SafeArea(
                        top: false,
                        bottom: false,
                        child: Builder(
                          builder: (BuildContext context) {
                            return SmartRefresher(
                                controller: RefreshController(),
                              enablePullUp: true,
                              enablePullDown: false,
                              header: ClassicHeader(),
                              footer: ClassicFooter(),
                              onRefresh: (){BotToast.showText(text: "太难了");},
                              onLoading: (){BotToast.showText(text: "头疼");},
                              child:
                              CustomScrollView(
                              key: PageStorageKey<String>(name),
                              slivers: <Widget>[
                                SliverOverlapInjector(
                                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext c, int i) {
                                      return Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(right: 10,top: 5,),
                                              child: Avatar(null,width: 30,height: 30,),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "回复人昵称",
                                                    style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    "4-24",
                                                    style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                                  child: Text("放肆!",style: TextStyle(fontSize: 14),),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 10),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: <Widget>[
                                                          Icon(IconFonts.thumbUp,size: 16,),
                                                          t11("11",),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 10),
                                                      child:InkWell(
                                                        child: Icon(IconFonts.share,size: 16,),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Icon(IconFonts.message,size: 16,),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 340,
                                                  color: Colors.black12,
                                                  margin:EdgeInsets.only(top: 10),
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      // desc 子评论
                                                      RichText(
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            text: "喵喵的鱼: ",
                                                            style: TextStyle(color: Colors.blue,fontSize: 14.0),
                                                            children: [
                                                              TextSpan(
                                                                text: "喵喵喜欢吃鱼鱼\n兄嘻嘻嘻嘻sadxxxxxxxxxxxxxxxxxxxasdxxxxxxxxxxxxxxxxxxxxxxxx ",
                                                                style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                                                              )
                                                            ]
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
                                        ),
                                      );
                                    },
                                    childCount: 10,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(height: 50,),
                                )
                              ],
                            )
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

      ),
    );
  }


  ok()=>CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: circleShow(),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
                (c,i){
              return Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10,top: 5,),
                      child: Avatar(null,width: 30,height: 30,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "回复人昵称",
                            style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            "4-24",
                            style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5,bottom: 5),
                          child: Text("放肆!",style: TextStyle(fontSize: 14),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(IconFonts.thumbUp,size: 16,),
                                  t11("11",),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child:InkWell(
                                child: Icon(IconFonts.share,size: 16,),
                              ),
                            ),
                            InkWell(
                              child: Icon(IconFonts.message,size: 16,),
                            ),
                          ],
                        ),
                        Container(
                          width: 340,
                          color: Colors.black12,
                          margin:EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // desc 子评论
                              RichText(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: "喵喵的鱼: ",
                                    style: TextStyle(color: Colors.blue,fontSize: 14.0),
                                    children: [
                                      TextSpan(
                                        text: "喵喵喜欢吃鱼鱼\n兄嘻嘻嘻嘻sadxxxxxxxxxxxxxxxxxxxasdxxxxxxxxxxxxxxxxxxxxxxxx ",
                                        style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
                ),
              );
            },
            childCount: 5
        ),

      ),
      SliverToBoxAdapter(
        child: Container(height: 50,),
      ),

    ],
  );

  old2(){
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(//SliverAppBar 作为头图控件
          automaticallyImplyLeading: false,
          floating: false,// 设置悬浮样式
          snap: false,
          pinned: false,
          flexibleSpace: ListView(
            children: <Widget>[circleShow()],
          ),
          forceElevated: false,
          expandedHeight: 400,// 头图控件高度
        ),
        SliverPersistentHeader(	// 可以吸顶的TabBar
          pinned: true,
          delegate: StickyTabBarDelegate(
            child: TabBar(
              labelColor: Colors.black,
              controller: this.tabController,
              tabs: <Widget>[
                Tab(text: 'Home'),
                Tab(text: 'Profile'),
              ],
            ),
          ),
        ),
        SliverFillRemaining(		// 剩余补充内容TabBarView
          child: TabBarView(
            controller: this.tabController,
            children: <Widget>[
              Center(child: commentListBuilder()),
              Center(child: Text('Content of Profile')),
            ],
          ),
        ),
      ],
    );
  }

  bottomWidget(){
    return
      Container(
        height: 40,
//        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
//                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child:Icon(Icons.star_border,color: Colors.pinkAccent,),
                    ),
                    Text("收藏")
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  print("滑稽");
                },
                child: Container(
                  alignment: Alignment.center,
//                  color: Colors.white,
                  child: InkWell(
                    onTap: (){
                      print("test");
                      if(panelController.isPanelOpen)
                        panelController.close();
                      else
                        panelController.open();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child:Icon(Icons.insert_comment,color: Colors.lightBlueAccent,),
                        ),
                        Text("评论")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.thumb_up,color: Colors.black12,),
                    ),
                    Text("点赞")
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  // desc 评论列表构造器
  commentListBuilder(){

    return ListView.builder(

      itemCount: 30,
      itemBuilder: ((c,i){
          return Container(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10,top: 5,),
                  child: Avatar(null,width: 30,height: 30,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "回复人昵称",
                        style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        "4-24",
                        style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom: 5),
                      child: Text("放肆!",style: TextStyle(fontSize: 14),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(IconFonts.thumbUp,size: 16,),
                              t11("11",),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:InkWell(
                            child: Icon(IconFonts.share,size: 16,),
                          ),
                        ),
                        InkWell(
                          child: Icon(IconFonts.message,size: 16,),
                        ),
                      ],
                    ),
                    Container(
                      width: 340,
                      color: Colors.black12,
                      margin:EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // desc 子评论
                          RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: "喵喵的鱼: ",
                              style: TextStyle(color: Colors.blue,fontSize: 14.0),
                                children: [
                                TextSpan(
                                  text: "喵喵喜欢吃鱼鱼\n兄嘻嘻嘻嘻sadxxxxxxxxxxxxxxxxxxxasdxxxxxxxxxxxxxxxxxxxxxxxx ",
                                  style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                                )
                              ]
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
            ),
          );
        }
      )
    );
  }

  t11(str) => Text(str,style: TextStyle(fontSize: 12,),);

  circleShow(){
    var content = "滑稽\n滑天下之大稽\n滑稽之天下滑稽，滑稽也\n有云，滑稽之大着，滑天下也！\n\n\n\n\n\n\n 是言滑稽者，大暨！";
    var time = "2020/4/24 17:00";
    var watch = 9999;
    // desc 动态内容
    return Container(
        decoration: BoxDecoration(
          // desc 中隔线
          border: Border(bottom: BorderSide(width: 10, color: Colors.black12)),
        ),
        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // desc 用户名 头像 行
            Container(
                child: Row(
                  children: <Widget>[
                    Avatar(null),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child:Text("用户名",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            child: Text("$time  ${watch}次浏览",style: TextStyle(
                                color: Theme.of(context).hintColor
                            ),),
                          ),
                        ],
                      ),
                    )

                  ],
                )
            ),
            // desc 内容
            Container(
              margin: EdgeInsets.only(top: 5,bottom: 5),
              child: Text("$content",textAlign: TextAlign.left),
            ),
            // desc 九图展示
          ],
        ),
      );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final Color color;

  StickyTabBarDelegate({@required this.child,this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color??null,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}