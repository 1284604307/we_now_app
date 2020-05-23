import 'package:flutter/material.dart';
import 'package:flutter_app2/services/model/Topic.dart';
import "package:dio/dio.dart";
import 'package:flutter_app2/services/net/restful_go.dart';

class PublishTopicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublishTopicPageState();
  }
}

class PublishTopicPageState extends State<PublishTopicPage> {

  List<Topic> topicList= [];
  int _selectCount = 0;

  void Function(int) onMenuChecked;

  @override
  void initState() {
    super.initState();
    loadTopic();
    onMenuChecked = (int i) {
      if(_selectCount != i){_selectCount = i;}
      setState(() {});
    };
  }


  void loadTopic({topic=""}) async {
    topicList = await RestfulApi.fetchTopics(topic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body:Column(
            children: <Widget>[
              Row(
                  children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Color(0xffE4E2E8),
                          borderRadius: BorderRadius.all(Radius.circular(5.0),),
                        ),
                       child: Container(
                         height: 36,
                         child: TextField(
                           maxLines: 1,
                           onSubmitted: (v){
                             loadTopic(topic: v);
                           },
                           decoration: InputDecoration(
                             hintText:"# 话题 电影 书 地点 疫情 特朗普",
                             hintStyle: TextStyle(fontSize: 14),
                             focusedBorder: InputBorder.none,
                             enabledBorder: InputBorder.none,
                           ),
                           style: TextStyle(fontSize: 14, color: Color(0xffee565656)),
                         ),
                       ),
                       ),
                    )
                  ),
                  Container(
                     margin: EdgeInsets.only(right: 15),
                     child: Text("取消",style: TextStyle(fontSize: 14,color: Colors.black),),
                   ),
                ],
              ),
              Container(
                 color: Color(0xffEFEFEF),
                height: 1,
              ),
              RightListView()
            ],
          )
      ),
    );
  }

  Widget RightListView ( ){
    return Expanded(
      child: ListView.builder(
        itemCount: topicList.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              print("选择的描述是:"+topicList[index].topic);
              Navigator.of(context).pop(topicList[index]);
            },
            child: Container(
              padding:  EdgeInsets.only(left: 15),
                child: Column(
                 children: <Widget>[
                  Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                            width: 45,
                            height: 45,
                            margin: EdgeInsets.only(  right: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage('${topicList[index].url}'),
                                    fit: BoxFit.cover
                                )
                            )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("#"+topicList[index].topic+"#",
                              style: TextStyle(
                                  fontSize: 15
                                      ,color: Colors.black
                              ),
                            ),
                            Text("${topicList[index].visible}万人关注",
                              style: TextStyle(
                                  fontSize: 12,color: Color(0xff999999)
                              ),
                            )
                          ],
                        )
                      ],
                    ) ,
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                  ),
                   Container(
                     color: Color(0xffEFEFEF),
                     height: 1,
                   )
                 ],
               ),
            ),
          );
        }
      ),
      flex: 7,
     );
  }
}

 