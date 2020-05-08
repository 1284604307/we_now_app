import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/article/webview.dart';
import 'package:flutter_app2/pages/home/circle/circle_page.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/wights/ItemInfoDetail.dart';
import 'package:flutter_app2/pages/wights/article_list_Item.dart';
import 'package:flutter_app2/pages/wights/article_skeleton.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/pages/wights/skeleton.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/model/viewModel/home_model.dart';
import 'package:flutter_app2/services/model/viewModel/scroll_controller_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:flutter_app2/services/utils/status_bar_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

const double kHomeRefreshHeight = 180.0;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  State createState() => _State();
}

class _State extends State<Home> with AutomaticKeepAliveClientMixin {
  //轮播图
  Widget _swiperWidget(HomeModel model) {
    if(model.banners==null) return Container();
    return Container(
      height: 180,
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 21 / 9,
            child: Swiper(
              autoplay: false,
              autoplayDelay:6500,
              autoplayDisableOnInteraction: true,
              viewportFraction: 1,
              scale: 0.8,
              itemBuilder: (BuildContext context, int index) {
                return
                  /** desc 首页头部轮播图组件模型  #2150 此处应根据轮播图类型跳转到相关内容详情页
                           如webview页，article详情页
                  **/
                    InkWell(
                      onTap: (){
                        //showToast("lib/home/index.dart #2150");
                        //导航至疫情地图
                        Navigator.push(context, MaterialPageRoute(builder: (cx)=>ItemInfoDetail()));
                        },
                        //Navigator.push(context, SizeRoute(WebViewPage()));
//                        showToast("lib/home/index.dart #2150");
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:  Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  width: double.infinity,
                                  imageUrl: model.banners[index].url,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    color: Colors.grey,
                                    child: Text("${model.banners[index].title}"),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    color: Colors.grey,
                                    child: Text(
                                      "${model.banners[index].content}",
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    );
              },
              itemCount: model.banners.length,
              pagination: new SwiperPagination(),
            ),
          ),
        ],
      ),
    );
  }

  // desc 热门动态
  Widget GoodArticleView(List<Article> circles){
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
                color: Colors.grey
              ),)
            ],
          ),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // desc 首页热门动态组件模型
              return Container(
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, NoAnimRouteBuilder( ShowCircle(circles[index]) ));
                      },
                      child:  Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.grey, width: 0.5), // 边色与边宽度
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(5),topRight:Radius.circular(5)),
                              child: Container(
                                  width: 200,
                                  height: 100,
                                  color: Colors.grey[400],
                                  child:  CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: "${circles[index].envelopePic}",
                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Center(
                                child: Text("${circles[index].content}",maxLines: 2,textAlign: TextAlign.center,),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: circles.length,
          ),
        )
      ],
    );
  }

  Widget NiceSayTop5(List<Topic> topics){
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
              Text(" 精选  ",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),),
              Text("TOP 5",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12
              ),),
            ],
          ),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // desc 首页每日话题组件模型  #2147 此处应跳转到话题详情页 展示该话题详情及其属下的动态
              return InkWell(
                onTap: (){
                  showToast("应跳转到话题详情,请在 lib/home/index.dart 搜索 #2147 任务以修复此处");
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: new Border.all(color: Color.fromRGBO(0, 0, 0, 0.08), width: 0.5), // 边色与边宽度
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 159,
                                color: Colors.redAccent[100*index%200+100],
                                child: CachedNetworkImage(imageUrl: topics[index].url,fit: BoxFit.cover,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: topics.length,
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
//                        buttonTextData: "滑稽",
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
                          SliverToBoxAdapter(
                            child: _swiperWidget(homeModel),
                          ),
//                          if (homeModel.topics?.isNotEmpty ?? false)
                          SliverToBoxAdapter(
                            child: Column(
                              children: <Widget>[
                                if(homeModel.hotsArticles!=null)
                                GoodArticleView(homeModel.hotsArticles),
                                if(homeModel.topics!=null)
                                NiceSayTop5(homeModel.topics),
                              ],
                            ),
                          ),
                          HomeTopArticleList(),
                          if (homeModel.isEmpty)
                            SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: ViewStateEmptyWidget(
                                    message: "未获取到今日文章",
                                      onPressed: homeModel.initData),
                                )
                            ),
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
      // desc 文章加载效果
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