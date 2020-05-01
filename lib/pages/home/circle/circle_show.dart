import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/wights/CommentListWight.dart';
import 'package:flutter_app2/pages/wights/GridViewNithWight.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShowCircle extends StatefulWidget{

  Article _article;

  ShowCircle(this._article);

  @override
  State<StatefulWidget> createState() {
    return _state(this._article);
  }

}

class _state extends State<ShowCircle>
    with SingleTickerProviderStateMixin {

  Article _article;
  TabController tabController;
  PanelController panelController = PanelController();

  _state(this._article);


  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    var _tabs = ["评论","点赞"];
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
                            circleShow(_article),
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
                            switch(name){
                              case "评论":
                                return ProviderWidget<CommentListModel>(
                                  model: CommentListModel(_article.id),
                                  builder: (BuildContext context, CommentListModel model, Widget child) {
                                    return CommentListWight(name,model);
                                  },
                                  onModelReady: (model){model.loadMore();},
                              );
                              case "点赞": return Container(child:Text("点赞啦"));
                              default: return Container(child: Text("页面不存在！"),);
                            }
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



  bottomWidget(){
    UniqueKey uniqueKey = UniqueKey();
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
                child:  ArticleLikeWidget(
                          _article,
                          uniqueKey
                        ),
              ),
            ),
          ],
        ),
      );
  }



  circleShow(Article circle){
    var content = circle.content;//"滑稽\n滑天下之大稽\n滑稽之天下滑稽，滑稽也\n有云，滑稽之大着，滑天下也！\n\n\n\n\n\n\n 是言滑稽者，大暨！";
    var time = circle.createTime;
    var watch = circle.visible;
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
                    Avatar(CachedNetworkImage(imageUrl: circle.user.avatar,)),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child:Text("${circle.user.userName}",style: TextStyle(fontWeight: FontWeight.bold),),
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
            GridViewNithWight(circle.url),
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