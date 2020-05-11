import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/pages/home/circle/comment_page.dart';
import 'package:flutter_app2/pages/wights/CommentListWight.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const Color _kTikTokBackgroundColor = Color.fromARGB(255, 22, 24, 35);

class UserProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserProfileScreenState();
  }
}

class CompleteFoldingNotification extends Notification {
  final bool completeFolding;

  const CompleteFoldingNotification(this.completeFolding);
}

class TikTokHeader extends StatefulWidget {
  final TabController tabController;

  final List<Tab> tabs;

  const TikTokHeader({Key key, this.tabController, this.tabs})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TikTokHeaderState();
  }
}

class TikTokHeaderState extends State<TikTokHeader> {

  Color backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is CompleteFoldingNotification) {
          SchedulerBinding.instance.addPostFrameCallback((timestamp) {
            setState(() {
              backgroundColor = notification.completeFolding
                  ? Theme.of(context).primaryColor
                  : Colors.transparent;
            });
          });
        }else{
          print(notification.runtimeType);
        }
        return false;
      },
      child: _TikTokHeader(
        delegate: SliverChildListDelegate([
          Stack(
            children: <Widget>[
              Image.network(
                "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3129531823,304476160&fm=26&gp=0.jpg",
                fit: BoxFit.cover,
              ),
//              TopInfoSection(),
//              BottomInfoSection()
            ],
          ),
          AppBar(
            title: Text("标题"),
            backgroundColor: backgroundColor,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              indicatorColor: Color.fromARGB(255, 243, 206, 74),
              controller: widget.tabController,
              tabs: widget.tabs,
            ),
          )
        ]),
      ),
    );
  }
}

class _TikTokHeader extends SliverMultiBoxAdaptorWidget {
  const _TikTokHeader({
    Key key,
    @required SliverChildDelegate delegate,
  }) : super(key: key, delegate: delegate);

  @override
  RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context) {
    final SliverMultiBoxAdaptorElement element =
        context as SliverMultiBoxAdaptorElement;
    return TikTokHeaderRenderSliver(childManager: element);
  }
}

class TikTokHeaderRenderSliver extends RenderSliverMultiBoxAdaptor {
  TikTokHeaderRenderSliver({
    @required RenderSliverBoxChildManager childManager,
  }) : super(childManager: childManager);

  bool _completeFolding = false;

  @override
  void performLayout() {
    childManager.didStartLayout();
    childManager.setDidUnderflow(false);

    if (firstChild == null) {
      addInitialChild();
      firstChild.layout(constraints.asBoxConstraints().tighten(),
          parentUsesSize: true);

      var secondChild = insertAndLayoutChild(
          constraints.asBoxConstraints().tighten(),
          after: firstChild,
          parentUsesSize: true);

      final SliverMultiBoxAdaptorParentData secondChildParentData =
          secondChild.parentData as SliverMultiBoxAdaptorParentData;
      secondChildParentData.layoutOffset = 0.0;

      var thirdChild = insertAndLayoutChild(
          constraints.asBoxConstraints().tighten(),
          after: secondChild,
          parentUsesSize: true);
      final SliverMultiBoxAdaptorParentData thirdChildParentData =
          thirdChild.parentData as SliverMultiBoxAdaptorParentData;
      thirdChildParentData.layoutOffset = firstChild.size.height;
    } else {
      firstChild.layout(constraints.asBoxConstraints().tighten(),
          parentUsesSize: true);

      final SliverMultiBoxAdaptorParentData firstChildParentData =
          firstChild.parentData as SliverMultiBoxAdaptorParentData;
      firstChildParentData.layoutOffset = 0.0;

      var secondChild = childAfter(firstChild);
      var thirdChild = childAfter(secondChild);

      final SliverMultiBoxAdaptorParentData secondChildParentData =
          secondChild.parentData as SliverMultiBoxAdaptorParentData;
      secondChildParentData.layoutOffset = constraints.scrollOffset;

      final SliverMultiBoxAdaptorParentData thirdChildParentData =
          thirdChild.parentData as SliverMultiBoxAdaptorParentData;

      thirdChildParentData.layoutOffset =
          max(secondChild.size.height, firstChild.size.height);
    }
    var secondChild = childAfter(firstChild);
    var thirdChild = childAfter(secondChild);

    var paintExtent = max(
        firstChild.size.height +
            thirdChild.size.height -
            constraints.scrollOffset,
        secondChild.size.height + thirdChild.size.height);

    var element = childManager as SliverMultiBoxAdaptorElement;
    if(secondChild.size.height + thirdChild.size.height ==
        paintExtent.round()){
      if( _completeFolding == false){
        _completeFolding = true;
        CompleteFoldingNotification(true).dispatch(element);
      }
    }else{
      if(_completeFolding == true){
        _completeFolding = false;
        CompleteFoldingNotification(false).dispatch(element);
      }
    }

    geometry = SliverGeometry(
        scrollExtent: firstChild.size.height - secondChild.size.height,
        maxPaintExtent: firstChild.size.height + thirdChild.size.height,
        paintExtent: paintExtent);
    childManager.didFinishLayout();
  }
}

class UserProfileScreenState extends State with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin{
  final List<Tab> _tabs = <Tab>[
    Tab(
      child: Padding(
        child: Text(
          "评论",
          style: TextStyle(fontSize: 16),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 4),
      ),
    ),
    Tab(
      child: Padding(
        child: Text(
          "点赞",
          style: TextStyle(fontSize: 16),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 4),
      ),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  TikTokHeader(
                    tabController: _tabController,
                    tabs: _tabs,
                  )
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: _tabs.map((Tab tab) {
                  return Builder(
                    builder: (context) {
                      return CommentPage('',1);
                    },
                  );
                }).toList(),
              ),
            ),
          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

