import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app2/services/model/Article.dart';

import 'avatar.dart';

/**
 * @createDate  2020/4/30
 */
// desc 评论列表构造器
class CommentListWight extends StatefulWidget  {

  String keyName;
  CommentListModel commentListModel;
  CommentListWight(this.keyName,this.commentListModel);

  @override
  _State createState() => _State(keyName,commentListModel);

}

class _State extends State<CommentListWight> {

  String keyName;
  CommentListModel commentListModel;
  _State(this.keyName, this.commentListModel);


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: RefreshController(),
        enablePullUp: true,
        enablePullDown: false,
        header: ClassicHeader(),
        footer: ClassicFooter(),
        onRefresh: (){BotToast.showText(text: "太难了");},
        onLoading: (){
          commentListModel.loadMore();
          BotToast.showText(text: "拉到底了！");
        },
        child:
        CustomScrollView(
          key: PageStorageKey<String>(keyName),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext c, int i) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10,top: 5,),
                          child: Avatar(null,width: 30,height: 30,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // desc 当前评论部分
                            if(commentListModel.list[i].user!=null)
                            Container(
                              child: Text(
                                "${commentListModel.list[i].user.userName}",
                                style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                "${commentListModel.list[i].createTime}",
                                style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5,bottom: 5),
                              child: Text("${commentListModel.list[i].content}",style: TextStyle(fontSize: 14),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(IconFonts.thumbUp,size: 16,),
//                                      t11("11",),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:InkWell(
                                    child: Icon(IconFonts.share,size: 16,),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(IconFonts.message,size: 16,),
                                ),
                              ],
                            ),
                            // desc 子评论容器
                            if(commentListModel.list[i].children.length>0)
                              chidrenComment(commentListModel.list[i])
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
                    ),
                  );
                },
                childCount: commentListModel.list.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(height: 50,),
            )
          ],
        )
    );
  }

  childComment(Comment comment){
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: comment.user!=null?"${comment.user.userName}":"匿名",
          style: TextStyle(color: Colors.blue,fontSize: 14.0),
          children: [
            if(comment.toId > 0)
              TextSpan(text: " 回复 ",
                style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                children: [
                  TextSpan(text: "${comment.toId}",style: TextStyle(color: Colors.blue,fontSize: 14.0),)
                ]
              ),
            TextSpan(
              text: "：${comment.content}",
              style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
            )
          ]
      ),
    );
  }

  commentListBuilder(Article circle){

    return ListView.builder(

        itemCount: 30,
        itemBuilder: ((c,i){
          return Container(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10,top: 5,),
                  child: Avatar(null,width: 30,height: 30,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${circle.user.userName}",
                        style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        "4-24",
                        style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,bottom: 5),
                      child: Text("${circle.content}",style: TextStyle(fontSize: 14),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(IconFonts.thumbUp,size: 16,),
                              t11("11",),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:InkWell(
                            child: Icon(IconFonts.share,size: 16,),
                          ),
                        ),
                        InkWell(
                          child: Icon(IconFonts.message,size: 16,),
                        ),
                      ],
                    ),
                    Container(
                      width: 340,
                      color: Colors.black12,
                      margin:EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // desc 子评论
                          RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: "喵喵的鱼: ",
                                style: TextStyle(color: Colors.blue,fontSize: 14.0),
                                children: [
                                  TextSpan(
                                    text: "喵喵喜欢吃鱼鱼\n兄嘻嘻嘻嘻sadxxxxxxxxxxxxxxxxxxxasdxxxxxxxxxxxxxxxxxxxxxxxx ",
                                    style: TextStyle(color: Theme.of(context).textTheme.display1.color,fontSize: 14.0),
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
            ),
          );
        }
        )
    );
  }

  t11(str) => Text(str,style: TextStyle(fontSize: 12,),);

  chidrenComment(Comment comment) {
    return InkWell(
      onTap: (){
        showToast("应跳转到二级评论详情页");
      },
      child: Container(
        width: 340,
        color: Colors.black12,
        margin:EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...comment.children.map((comment){
              return childComment(comment);
            }),
            if(comment.children.length>3)
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: InkWell(
                  onTap: (){ showToast(comment.cid.toString()); },
                  child: Text("更多回复",
                    style: TextStyle(color: Colors.blue,fontSize: 14.0),),
                ),
              )
          ],
        ),
      ),
    );
  }
}