import 'dart:ffi';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'circle_talk.dart';

class CircleSchool extends StatefulWidget {

  @override
  _State createState() => new _State();

}

class _State extends State<CircleSchool> {

  @override
  void initState() {
    super.initState();
//    loadingData(false);
  }

  Widget noDataView(){
    return new Container(
        height: 730,
        child: Center(
          child: Text("没有数据，刷新一下吧~~"),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CircleSchoolModel>(
      onModelReady: (model){
        model.initData();
      },
      model: CircleSchoolModel(),
      builder: (ctx,cRecommendModel,child){
        return new Container(
          child: SmartRefresher(
            onRefresh: ()async{
              await cRecommendModel.refresh();
              cRecommendModel.showErrorMessage(context);
            },
            child:  new ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: cRecommendModel.list.length,
              itemBuilder: (BuildContext context, int index) {
                return talkWidget(context,index,cRecommendModel.list[index]);
              },
              physics: new AlwaysScrollableScrollPhysics(),
            ),
            controller: cRecommendModel.refreshController,
          ),
        );
      },
    );
  }
}
