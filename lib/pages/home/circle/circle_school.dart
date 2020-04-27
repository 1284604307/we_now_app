import 'dart:ffi';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'circle_talk.dart';

class CircleSchool extends StatefulWidget {

  @override
  _State createState() => new _State();

}

class _State extends State<CircleSchool>  with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CircleSchoolModel>(
      onModelReady: (model){
        model.initData();
      },
      model: CircleSchoolModel(),
      builder: (ctx,cSchoolModel,child){
        return new Container(
          child: SmartRefresher(
            onRefresh: ()async{
              await cSchoolModel.refresh();
              cSchoolModel.showErrorMessage(context);
            },
            footer: RefresherFooter(),
            header: HomeRefreshHeader(),
            enablePullDown: cSchoolModel.list.isNotEmpty,
            enablePullUp: cSchoolModel.list.isNotEmpty,
            onLoading: cSchoolModel.loadMore,
            child:  new ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: cSchoolModel.list.length,
              itemBuilder: (BuildContext context, int index) {
                return talkWidget(context,index,cSchoolModel.list[index]);
              },
              physics: new AlwaysScrollableScrollPhysics(),
            ),
            controller: cSchoolModel.refreshController,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
