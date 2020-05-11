import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:path/path.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/11
 */
class TopicPage extends StatefulWidget {

  int tipId;
  Topic topic;
  TopicPage(this.tipId,{this.topic});

  @override
  _State createState() => _State(this.tipId,topic: this.topic);

}

class _State extends State<TopicPage> {

  int tipId;
  Topic topic;
  _State(this.tipId,{this.topic});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(topic==null){
      //加载
    }else{

    }
  }

  var isFan = false;

  @override
  Widget build(BuildContext context) {
    print(topic.toJson());
    TextStyle textStyle({fw,size}) => TextStyle(
      color: Colors.white,
      fontWeight: fw,fontSize: size
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("${topic.topic??""}"),
      ),
      body: SmartRefresher(
        controller: RefreshController(),
        child: CustomScrollView(
          slivers: <Widget>[
            if(topic==null)
              SliverToBoxAdapter(
                child: ViewStateEmptyWidget(onPressed: () {},),
              )
            else
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(20),
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
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(20),
                height: 0.25,
                color: Colors.grey,
              )
            )
          ],
        ),
      ),
    );
  }
}