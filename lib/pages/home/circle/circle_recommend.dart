import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/wights/article_skeleton.dart';
import 'package:flutter_app2/pages/wights/skeleton.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'circle_talk.dart';

class CircleRecommend extends StatefulWidget {

  CircleRecommend({Key key}) : super(key: key);
  @override
  _State createState() => new _State();

}

class _State extends State<CircleRecommend> with AutomaticKeepAliveClientMixin  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CircleRecommendModel>(
      onModelReady: (model){
        print("model 准备好了");
        model.initData();
      },
      model: CircleRecommendModel(),
      builder: (ctx,cRecommendModel,child){
        return new Container(
          child: SmartRefresher(
            controller: cRecommendModel.refreshController,
            footer: RefresherFooter(),
            header: HomeRefreshHeader(),
            onRefresh: ()async{
                await cRecommendModel.refresh();
                cRecommendModel.showErrorMessage(context);
            },
            enablePullDown: cRecommendModel.list.isNotEmpty,
            enablePullUp: cRecommendModel.list.isNotEmpty,
            onLoading: cRecommendModel.loadMore,
            child: CustomScrollView(
              slivers: <Widget>[
                if (cRecommendModel.list.isEmpty)
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ViewStateEmptyWidget(
                            onPressed: cRecommendModel.initData),
                      )),
                // desc 动态列表
                if (cRecommendModel.list.isNotEmpty)
                  _CicleList(),
              ],
            ) ,
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
          CircleEntity item = recommendModel.list[index];
          // desc 动态生成模型
          return talkWidget(context, index, item);
        },
        childCount: recommendModel.list?.length ?? 0,
      ),
    );
  }
}
