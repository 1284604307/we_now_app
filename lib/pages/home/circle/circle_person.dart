import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/article_skeleton.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/pages/wights/skeleton.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'circle_talk.dart';

class CirclePerson extends StatefulWidget {
  CirclePerson({Key key}) : super(key: key);
  @override
  _State createState() => new _State();
}

class _State extends State<CirclePerson> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CirclePersonModel>(
      onModelReady: (model) {
        model.initData();
        print("object");
      },
      model: CirclePersonModel(),
      builder: (ctx, cPModel, child) {
        return new Container(
          child: SmartRefresher(
            controller: cPModel.refreshController,
            footer: RefresherFooter(),
            header: HomeRefreshHeader(),
            onRefresh: () async {
              await cPModel.refresh();
              cPModel.showErrorMessage(context);
            },
            enablePullDown: cPModel.list.isNotEmpty,
            enablePullUp: cPModel.list.isNotEmpty,
            onLoading: cPModel.loadMore,
            child: CustomScrollView(
              slivers: <Widget>[
                // desc 无数据时展示
                if (cPModel.list.isEmpty)
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ViewStateEmptyWidget(
                          message: "您还没发过动态呢！快去分享一个吧~~",
                            buttonText: Text("这就去分享"),
                            onPressed: (){}),
                      )
                  ),
                // desc 动态列表
                if (cPModel.list.isNotEmpty)
                  _CicleList(cPModel),
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
  ViewStateRefreshListModel<Article> model;
  _CicleList(this.model);

  @override
  Widget build(BuildContext context) {
    if (model.isBusy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          Article item = model.list[index];
          // desc 生成<动态>模型
          return talkWidget(context, item);
        },
        childCount: model.list?.length ?? 0,
      ),
    );
  }
}
