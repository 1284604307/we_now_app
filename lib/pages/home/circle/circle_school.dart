import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/wights/article_skeleton.dart';
import 'package:flutter_app2/pages/wights/skeleton.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'circle_talk.dart';

class CircleSchool extends StatefulWidget {
  CircleSchool({Key key}) : super(key: key);
  @override
  _State createState() => new _State();
}

class _State extends State<CircleSchool> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasUser = Provider.of<UserModel>(context).hasUser;
    super.build(context);
    return ProviderWidget<CircleSchoolModel>(
      onModelReady: (model) {
        if(hasUser&&Provider.of<UserModel>(context).user.schoolId>=0){
          model.initData();
        }
      },
      model: CircleSchoolModel(),
      builder: (ctx, cRecommendModel, child) {
        return new Container(
          child: SmartRefresher(
            controller: cRecommendModel.refreshController,
            footer: RefresherFooter(),
            header: HomeRefreshHeader(),
            onRefresh: () async {
              await cRecommendModel.refresh();
              cRecommendModel.showErrorMessage(context);
            },
            enablePullDown: cRecommendModel.list.isNotEmpty,
            enablePullUp: cRecommendModel.list.isNotEmpty,
            onLoading: cRecommendModel.loadMore,
            child: CustomScrollView(
              slivers: <Widget>[
//                SliverToBoxAdapter(
//                    child: Card(
//                        color: Theme.of(context).cardColor,
//                        child: Stack(
//                          children: <Widget>[
//                            Row(
//                              children: <Widget>[
//                                Column(
//                                  children: <Widget>[
//                                    Container(
//                                        child: InkWell(
//                                          splashColor: Colors.green[
//                                          900], // give any splashColor you want
//                                          child: ClipRRect(
//                                            child: Image.asset(
//                                              'assets/images/app/news_round.png',
//                                              width: 60,
//                                              height: 60,
//                                            ),
//                                          ),
//                                          onTap: () {
//                                            //添加刷新
//                                          },
//                                        )),
//                                    Container(
//                                        alignment: Alignment.center,
//                                        width: 60,
//                                        child: Column(
//                                          children: <Widget>[Text("最新更新")],
//                                        )),
//                                  ],
//                                ),
//                                Container(
//                                  //绘制一条分割线
//                                    width: 10,
//                                    height: 60,
//                                    child: VerticalDivider(color: Colors.grey)),
//                              ],
//                            ),
//                            /***
//                             * desc 多个 动态
//                             * */
//                            Container(
//                              height: 82,
//                              margin: EdgeInsets.only(left: 70),
//                              child: new ListView.builder(
//                                scrollDirection: Axis.horizontal,
//                                itemBuilder: (BuildContext context, int index) {
//                                  if(index == (7))
//                                    return Column(
//                                      children: <Widget>[
//                                        Container(
//                                            margin: EdgeInsets.only(right: 10),
//                                            child: InkWell(
//                                              splashColor: Colors.green[
//                                              900], // give any splashColor you want
//                                              child: ClipRRect(
//                                                borderRadius:
//                                                BorderRadius.circular(30),
//                                              ),
//                                              onTap: () {
//                                                print("我被点击了！啊~~~~好疼");
//                                              },
//                                            )),
//                                        Container(
//                                            margin: EdgeInsets.only(right: 10),
//                                            alignment: Alignment.center,
//                                            width: 60,
//                                            child: Column(
//                                              children: <Widget>[Text("查看更多")],
//                                            )),
//                                      ],
//                                    );
//                                  return Column(
//                                    children: <Widget>[
//                                      Container(
//                                          margin: EdgeInsets.only(right: 10),
//                                          child: InkWell(
//                                            splashColor: Colors.green[
//                                            900], // give any splashColor you want
//                                            child: ClipRRect(
//                                              borderRadius:
//                                              BorderRadius.circular(30),
//                                              child: Image.asset(
//                                                'assets/images/app/news_round.png',
//                                                width: 60,
//                                                height: 60,
//                                              ),
//                                            ),
//                                            onTap: () {
//                                              print("我被点击了！啊~~~~好疼");
//                                            },
//                                          )),
//                                      Container(
//                                          margin: EdgeInsets.only(right: 10),
//                                          alignment: Alignment.center,
//                                          width: 60,
//                                          child: Column(
//                                            children: <Widget>[Text("最新更新")],
//                                          )),
//                                    ],
//                                  );
//                                },
//                                itemCount: 7+1,
//                              ),
//                            ),
//                          ],
//                        )
//                    )
//                ),
                /// desc 未登录或用户没有绑定学校时展示
                if(!hasUser||(hasUser&&Provider.of<UserModel>(context).user.schoolId<=0))
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ViewStateEmptyWidget(
                            buttonText: Text("去绑定"),
                            message: "未绑定学校",
                            onPressed: (){showToast("应跳转到用户信息页");}),
                      )
                  ),
                /// desc 已绑定学校且无数据时展示
                if (hasUser&&cRecommendModel.list.isEmpty)
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ViewStateEmptyWidget(
                            onPressed: cRecommendModel.initData),
                      )
                  ),
                // desc 动态列表
                if (cRecommendModel.list.isNotEmpty)
                  _CicleList(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CicleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CircleRecommendModel recommendModel = Provider.of(context);
    if (recommendModel.isBusy) {
      print("------------busy");
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = recommendModel.list[index];
          // desc 生成<动态>模型
          return talkWidget(context, index, item);
        },
        childCount: recommendModel.list?.length ?? 0,
      ),
    );
  }
}
