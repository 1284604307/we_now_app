import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/app.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/wights/article_list_Item.dart';
import 'package:flutter_app2/pages/wights/article_skeleton.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/pages/wights/skeleton.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/home_model.dart';
import 'package:flutter_app2/services/model/viewModel/scroll_controller_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:flutter_app2/services/utils/status_bar_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const double kHomeRefreshHeight = 180.0;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  State createState() => _State();
}

class _State extends State<Home> with AutomaticKeepAliveClientMixin {
  //轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/1.png"},
      {"url": "https://www.itying.com/images/flutter/2.png"},
      {"url": "https://www.itying.com/images/flutter/3.png"},
      {"url": "https://www.itying.com/images/flutter/4.png"}
    ];
    return Container(
      height: 180,
      child: AspectRatio(
        aspectRatio: 21 / 9,
        child: Swiper(
          autoplay: false,
          autoplayDelay:6500,
          autoplayDisableOnInteraction: true,
          viewportFraction: 1,
          scale: 0.8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  CachedNetworkImage(
                    imageUrl: imgList[index]["url"],
                    fit: BoxFit.fill,
                  )
              ),
            );
          },
          itemCount: imgList.length,
          pagination: new SwiperPagination(),
        ),
      ),
    );
  }

  List<String> imgList = [
    "https://www.itying.com/images/flutter/1.png",
    "https://www.itying.com/images/flutter/2.png",
    "https://www.itying.com/images/flutter/3.png",
    "https://www.itying.com/images/flutter/4.png"
  ];

  Widget GoodArticleView(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 10),
          child: Row(
            children: <Widget>[
              Text("热门动态",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              Text("   优秀原创",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black12
              ),)
            ],
          ),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.08), width: 0.5), // 边色与边宽度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 200,
                              height: 100,
                              color: Colors.redAccent[100*index%200+100],
                              child:  CachedNetworkImage(
                                imageUrl: imgList[index%4],fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Center(
                                child: Text("穷尽一生，寻找一个梦的终点. 来吧，一起去寻找！",maxLines: 2,textAlign: TextAlign.center,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: imgList.length,
          ),
        )
      ],
    );
  }

  Widget NiceSayTop5(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 10),
          child: Row(
            children: <Widget>[
              Text("每日话题 ",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
              Text(" 原创  ",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black12
              ),),
              Text("TOP 5",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
              ),),
            ],
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.08), width: 0.5), // 边色与边宽度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              color: Colors.redAccent[100*index%200+100],
                              child: CachedNetworkImage(imageUrl: imgList[index%4],fit: BoxFit.fill,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: imgList.length,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;
    return ProviderWidget2<HomeModel, TapToTopModel>(
      model1: HomeModel(),
      // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
      model2: TapToTopModel(
          PrimaryScrollController.of(context),
          height: bannerHeight - kToolbarHeight
      ),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("校园时光"),
          ),
          body: MediaQuery.removePadding(
              context: context,
              removeTop: false,
              child: Builder(builder: (_) {
                if (homeModel.isError && homeModel.list.isEmpty) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: StatusBarUtils.systemUiOverlayStyle(context),
                      child: ViewStateErrorWidget(
                        buttonTextData: "滑稽",
                        error: homeModel.viewStateError,
                        onPressed: homeModel.initData)
                  );
                }
                return RefreshConfiguration.copyAncestor(
                  context: context,
                  // desc 下拉触发二楼距离
                  twiceTriggerDistance: kHomeRefreshHeight - 15,
                  // desc 最大下拉距离,android默认为0,这里为了触发二楼
                  maxOverScrollExtent: kHomeRefreshHeight,
                  headerTriggerDistance: 80 + MediaQuery.of(context).padding.top / 3,
                  child: SmartRefresher(
                      controller: homeModel.refreshController,
                      header: HomeRefreshHeader(),
                      enableTwoLevel: homeModel.list.isNotEmpty,
                      onTwoLevel: () async {
                        await Navigator.of(context)
                            .push(SlideTopRouteBuilder(Test()));
                        homeModel.refreshController.twoLevelComplete();
                        await Future.delayed(Duration(milliseconds: 100));
                      },
                      footer: RefresherFooter(),
                      enablePullDown: homeModel.list.isNotEmpty,
                      onRefresh: () async {
                        await homeModel.refresh();
                        homeModel.showErrorMessage(context);
                      },
                      onLoading: homeModel.loadMore,
                      enablePullUp: homeModel.list.isNotEmpty,
                      // desc 一定注意 CustomScrollView 只支持 SliverXXX组件，普通组件使用SliverToBoxAdapter包裹
                      child: CustomScrollView(
                        controller: tapToTopModel.scrollController,
                        slivers: <Widget>[
                          if (homeModel.isEmpty)
                            SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: ViewStateEmptyWidget(
                                      onPressed: homeModel.initData),
                                )
                            ),
                          if (homeModel.topArticles?.isNotEmpty ?? false)
                            SliverToBoxAdapter(
                            child: Column(
                              children: <Widget>[
                                _swiperWidget(),
                                GoodArticleView(),
                                NiceSayTop5(),
                              ],
                            ),
                          ),
                          HomeTopArticleList(),
                          HomeArticleList(),
                        ],
                      )),
                );
              })),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}



class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = homeModel.topArticles[index];
          return ArticleItemWidget(
            item,
            index: index,
            top: true,
          );
        },
        childCount: homeModel.topArticles?.length ?? 0,
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.isBusy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = homeModel.list[index];
          return ArticleItemWidget(
            item,
            index: index,
          );
        },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }
}