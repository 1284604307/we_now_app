import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/CommentListWight.dart';
import 'package:flutter_app2/pages/wights/LittleWidgets.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * @createDate  2020/5/1
 */
class CommentPage extends StatefulWidget {

  num id;
  String name;

  CommentPage(this.name,this.id);

  @override
  _State createState() => _State(id,name);

}

class _State extends State<CommentPage> with AutomaticKeepAliveClientMixin {

  num id;
  String name;

  _State(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: ProviderWidget<CommentListModel>(
        onModelReady: (m){m.initData();},
        builder: (BuildContext context, CommentListModel commentListModel, Widget child) {
          return SmartRefresher(
              controller: commentListModel.refreshController,
              enablePullDown: false,
              enablePullUp: commentListModel.list.isNotEmpty,
              onLoading: (){ commentListModel.loadMore(); },
              onRefresh: (){ commentListModel.refresh(); },
              child: CustomScrollView(
                slivers: <Widget>[
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
                                    ChildrenComment(commentListModel.list[i])
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
                ],
              ),
            );
        }, model: CommentListModel(this.id),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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