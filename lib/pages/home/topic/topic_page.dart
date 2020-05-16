import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/home/circle/circle_show.dart';
import 'package:flutter_app2/pages/home/circle/circle_talk.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/model/viewModel/circle_model.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path/path.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/11
 */
class TopicPage extends StatefulWidget {

  int topicId;
  Topic topic;
  String topicName;
  TopicPage({this.topicId,this.topic,this.topicName});

  @override
  _State createState() => _State(topicId:this.topicId,topic: this.topic,topicName:this.topicName);

}

class _State extends State<TopicPage> {

  int topicId;
  Topic topic;
  String topicName;
  _State({this.topicId,this.topic,this.topicName});

  @override
  void initState() {
    super.initState();
    if(topic==null)
      loadTopic();

  }

  loadTopic() async{
//    BotToast.showLoading();
    try{
      if(topicId!=null){
        this.topic = await RestfulApi.fetchTopic(topicId);
      }else{
        print("-----------------------------$topicName");
        this.topic = await RestfulApi.fetchTopicByName(topicName);
      }
      BotToast.closeAllLoading();
      setState(() {});
    }catch(e){
      BotToast.closeAllLoading();
    }
  }

  var isFan = false;

  @override
  Widget build(BuildContext context) {
//    print(topic.toJson());

    TextStyle textStyle({fw,size}) => TextStyle(
      color: Colors.white,
      fontWeight: fw,fontSize: size
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("${topic?.topic??"话题详情页"}"),
      ),
      body: ProviderWidget<CircleTopicModel>(
        onModelReady: (m){m.initData();},
        builder: (BuildContext context, CircleTopicModel model, Widget child) {
          return
            SmartRefresher(
              controller: model.refreshController,
              onLoading: (){model.loadMore();},
              onRefresh: (){model.refresh();},
              child: CustomScrollView(
                slivers: <Widget>[
                  if(topic==null)
                    SliverToBoxAdapter(
                      child: ViewStateEmptyWidget(onPressed: () {},),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(topic.url),
                                    fit: BoxFit.cover
                                )
                            ),
                            height: 200,
                            padding: EdgeInsets.all(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2,
                                      sigmaY: 2,
                                    ),
                                    child: Container(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("#${topic.topic}#",style: textStyle(fw: FontWeight.bold,size: 20.0),),
                                    Container(
                                      height: 80,
                                      child: Text("${topic.desc}",style: textStyle(),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width/4,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("${topic.visible}\n热度",style: textStyle(),textAlign: TextAlign.center,),
                                              Text("${topic.fansCount}\n关注",style: textStyle(),textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                isFan = !isFan;
                                              });
                                              print(isFan);
                                            },
                                            color: isFan?Colors.grey:Colors.blue,
                                            child: Text(isFan?"已关注":"关注",style: textStyle(),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                  // DESC 话题下动态 top , non-top
                  if(model.tops!=null)
                    ...[
                      SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 0.15,
                            color: Colors.grey,
                          )
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (c,i){
                              return talkWidget(c, model.tops[i]);
                            },
                            childCount: model.tops.length
                        ),
                      ),
                    ],
                  if(model.list!=null&&model.list.length>0)
                    ...[
                      SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 0.15,
                            color: Colors.grey,
                          )
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (c,i){
                              return talkWidget(c, model.list[i]);
                            },
                            childCount: model.list.length
                        ),
                      ),
                    ]
                  else
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 30),
                        child: ViewStateEmptyWidget(
                          onPressed: () {model.refresh();},
                        )
                      ),
                    )
                ],
              ),
            );
        }, model: CircleTopicModel(topicId),
      ),
    );
  }
}