import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShowCircle extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state();
  }

}

class _state extends State<ShowCircle>
    with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {



    var content = "滑稽\n滑天下之大稽\n滑稽之天下滑稽，滑稽也\n有云，滑稽之大着，滑天下也！\n\n\n\n\n\n\n 是言滑稽者，大暨！";
    var time = "2020/4/24 17:00";
    var watch = 9999;
    return SlidingUpPanel(
      minHeight: 45,
      maxHeight: 600,
      header: Container(
        width: 400,
        height: 45,
        color: Colors.black12,
        child:Material(
          child:  bottomWidget(),
        ),
      ),
      panel: Material(
        child: Container(
          padding: EdgeInsets.only(top: 50,left: 5,right: 5),
          alignment: Alignment.topCenter,
          color: Colors.white,
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
          body: Column(
            children: <Widget>[
              Expanded(
                child: NestedScrollView(
                  // desc 评论列表
                  body: commentListBuilder(),
                  // desc 动态内容
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return  circleShow();
                              },childCount: 1
                          )
                      )
                    ];;
                  },

                ),
              ),
              Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
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
                          color: Colors.white,
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
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
              )
            ],
          )
      ),
    );
  }


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
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
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
                  color: Colors.white,
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
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
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

  old(){
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: GlobalConfig.globalBackgroundColor,
            child: ListView(
              physics: new AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 745,
                  margin: EdgeInsets.only(top: 20),
                  // desc 评论列表构造器
                  child: ListView.builder(
                      shrinkWrap: false,	//禁用滑动事件
                      itemCount: 100,
                      itemBuilder: (c,i){
                        return  commentListBuilder();
                      }),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          color: Colors.white,
        )
      ],
    );
  }

  // desc 评论列表构造器
  commentListBuilder(){

    return ListView.builder(

      itemCount: 30,
        itemBuilder: ((c,i){
      return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.black26,
              width: 30,height: 30,
              margin: EdgeInsets.only(left: 5,right: 15,top: 5),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("回复人昵称"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text("4-24"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("放肆!"),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5)))
        ),
      );
    }));
  }

  circleShow(){
    var content = "滑稽\n滑天下之大稽\n滑稽之天下滑稽，滑稽也\n有云，滑稽之大着，滑天下也！\n\n\n\n\n\n\n 是言滑稽者，大暨！";
    var time = "2020/4/24 17:00";
    var watch = 9999;
    // desc 动态内容
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 10, color: Colors.black12)),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // desc 用户名 头像 行
            Container(
                child: Row(
                  children: <Widget>[
                    Container(color: Colors.black12, width: 35,height: 39,),
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
                                color: Colors.black26
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

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
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