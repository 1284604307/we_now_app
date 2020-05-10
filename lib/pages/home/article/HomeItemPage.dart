import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/home/circle/comment_page.dart';
import 'package:flutter_app2/pages/wights/CommentListWight.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeItemPage extends StatefulWidget {
  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

Widget _timeTabBarItem(String title, String subTitle) {
  return Tab(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            subTitle,
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ));
}

class _HomeItemPageState extends State<HomeItemPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomeItemPage> {
  TabController _timeTabController;
  List<String> topList = List();
  List<Tab> timeTabs = <Tab>[
    _timeTabBarItem("10:00", "抢购中"),
    _timeTabBarItem("13:00", "即将开始"),
  ];


  ///时间选择
  Widget _timeSelection() {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        /// 固定整个布局的高，否则选中时间背景显示不全
        Container(
          height: 55,
        ),

        /// 未选中时间背景色
        Container(
          height: 55 - 5.0,
          color: Colors.black,
        ),

        /// 选中时间背景图片
        Positioned(
          width: width / 2,
          height: 55,

          ///一行有6个Tab，每次移动的距离=当前移动到的位置*单个tab的宽
          left: _timeTabController.animation.value * width / 2,
          child: Container(
            color: Colors.red,
          ),
        ),
        TabBar(
          labelPadding: EdgeInsets.all(0),
          tabs: timeTabs,
          controller: _timeTabController,
          isScrollable: false,
          unselectedLabelColor: Colors.black,
          labelStyle:
          TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
          indicatorColor: Colors.transparent,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _timeTabController =
        TabController(vsync: this, initialIndex: 0, length: 2);
    _timeTabController.animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timeTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var _tabs = ["评论","点赞"];
    return ProviderWidget<CommentListModel>(
      model: CommentListModel(1),
      builder: (BuildContext context, CommentListModel commentListModel, Widget child){
        return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: html(),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(_timeSelection()),
                  pinned: true,
                ),
              ];
            },
            body: SmartRefresher(
            controller: commentListModel.refreshController,
            enablePullUp: commentListModel.list.isNotEmpty,
            enablePullDown: false,
            footer: RefresherFooter(),
            header: HomeRefreshHeader(),
            onRefresh: (){BotToast.showText(text: "太难了");},
            onLoading: (){
            commentListModel.loadMore();
            showToast(commentListModel.list.length.toString());
            },
            child:
            TabBarView(
              controller: _timeTabController,
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      switch(name){
                        case "评论":
                          return CommentListWight("",commentListModel);
                        case "点赞": return Container(child:Text("点赞啦"));
                        default: return Container(child: Text("页面不存在！"),);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  chidrenComment(Comment comment) {
    return InkWell(
      onTap: (){
        showToast("应跳转到二级评论详情页");
      },
      child: Container(
        width: 340,
        color: Colors.black12,
        margin:EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...comment.children.map((comment){
              return childComment(comment);
            }),
            if(comment.children.length>3)
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: InkWell(
                  onTap: (){ showToast(comment.cid.toString()); },
                  child: Text("更多回复",
                    style: TextStyle(color: Colors.blue,fontSize: 14.0),),
                ),
              )
          ],
        ),
      ),
    );
  }
  childComment(Comment comment){
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: comment.user!=null?"${comment.user.userName}":"匿名",
          style: TextStyle(color: Colors.blue,fontSize: 14.0),
          children: [
            if(comment.toId > 0)
              TextSpan(text: " 回复 ",
                  style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                  children: [
                    TextSpan(text: "${comment.toId}",style: TextStyle(color: Colors.blue,fontSize: 14.0),)
                  ]
              ),
            TextSpan(
              text: "：${comment.content}",
              style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
            )
          ]
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;


  Widget html(){
    return Html(
      data: """
          <!--For a much more extensive example, look at example/main.dart-->
          <div>
            <h1>Demo Page</h1>
            <p>This is a fantastic nonexistent product that you should buy!</p>
            <h2>Pricing</h2>
            <p>Lorem ipsum <b>dolor</b> sit amet.</p>
            <h2>The Team</h2>
            <p>There isn't <i>really</i> a team...</p>
            <h2>Installation</h2>
            <p>You <u>cannot</u> install a nonexistent product!</p>
            <a href='http://www.baidu.com'>也是个老滑稽了</a>
            <!--You can pretty much put any html in here!-->
          </div>
        """,
      //Optional parameters:
      padding: EdgeInsets.all(8.0),
      backgroundColor: Colors.white70,
      defaultTextStyle: TextStyle(fontFamily: 'serif'),
      linkStyle: const TextStyle(
        color: Colors.redAccent,
      ),
      onLinkTap: (url) {
        // open url in a webview
      },
      customRender: (node, children) {
//          if(node is dom.Element) {
//            switch(node.localName) {
//              case "video": return Chewie(...);
//              case "custom_tag": return CustomWidget(...);
//            }
//          }
      },
    );
  }
}

///TabBar的代理
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Stack _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
