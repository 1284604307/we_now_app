import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'hot.dart';
import 'search_page.dart';
class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin  {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget barSearch() {
    return new Container(
        height: 35,
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new FlatButton.icon(
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return new SearchPage();
                        }
                    ));
                  },
                  icon: new Icon(
                      Icons.search,
                      color: GlobalConfig.fontColor,
                      size: 24.0
                  ),
                  label: new Text(
                    "坚果R1摄像头损坏",
                    style: new TextStyle(color: GlobalConfig.fontColor),
                  ),
                )
            ),
            new Container(
              decoration: new BoxDecoration(
                  border: new BorderDirectional(
                      start: new BorderSide(color: GlobalConfig.fontColor, width: 1.0)
                  )
              ),
              height: 12.0,
              width: 1.0,
            ),
            new Container(
                child: new FlatButton.icon(
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return null;//new AskPage();
                        }
                    ));
                  },
                  icon: new Icon(
                      Icons.border_color,
                      color: GlobalConfig.fontColor,
                      size: 14.0
                  ),
                  label: new Text(
                    "提问",
                    style: new TextStyle(color: GlobalConfig.fontColor),
                  ),
                )
            )
          ],
        ),
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: GlobalConfig.searchBackgroundColor,
        )
    );
  }
  PageController _controller = PageController();
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  final _navigationItems = [
    new Tab(text: "关注"),
    new Tab(text: "推荐"),
    new Tab(text: "热榜"),
  ];
  /// 统一管理导航项目对应的组件列表。
  final _widgetOptions = [
    new Container(),
    new Container(),
    new Hot()
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        backgroundColor: GlobalConfig.globalBackgroundColor,
        appBar: new AppBar(
          title: barSearch(),
          bottom: new TabBar(
            labelColor: GlobalConfig.dark? Colors.white : Colors.white,
            unselectedLabelColor: GlobalConfig.themeColor ,
            indicatorColor: Colors.white,
            tabs: _navigationItems,
          ),
        ),
        body: new TabBarView(
            children: _widgetOptions
        ),
      ),
    );
  }

}