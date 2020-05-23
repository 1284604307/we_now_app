/**
 * @createDate  2020/4/29
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/avatar.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/helper/favourite_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/model/viewModel/favourite_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'animated_provider.dart';

/// 收藏按钮
class ArticleFavouriteWidget extends StatelessWidget {
  final Article article;
  final UniqueKey uniqueKey;

  ArticleFavouriteWidget(this.article, this.uniqueKey);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavouriteModel>(
      model: FavouriteModel(
        globalFavouriteModel: Provider.of(context, listen: false)),
      builder: (_, favouriteModel, __) => GestureDetector(
          behavior: HitTestBehavior.opaque, //否则padding的区域点击无效
          onTap: () async {
            if (!favouriteModel.isBusy) {
              addFavourites(context,
                circle: article, model: favouriteModel, tag: uniqueKey);
            }
          },
          child: Hero(
            tag: uniqueKey,
            child: ScaleAnimatedSwitcher(
                child: favouriteModel.isBusy
                    ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CupertinoActivityIndicator(radius: 5))
                    : Consumer<UserModel>(
                  builder: (context,userModel,child){
                    print(" -----------------${article.like}----------------- ");
                    return Icon(
                      userModel.hasUser && article.like
                      ? Icons.favorite
                        : Icons.favorite_border,
                        color: Colors.pinkAccent[400]);
                  },
                )
            ),
          )
      ),
    );
  }
}


/// 喜欢按钮
class ArticleLikeWidget extends StatelessWidget {
  final Article article;
  final UniqueKey uniqueKey;

  ArticleLikeWidget(this.article, this.uniqueKey);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LikeModel>(
      model: LikeModel(article),
      builder: (_, likeModel, __) => GestureDetector(
          behavior: HitTestBehavior.opaque, //否则padding的区域点击无效
          onTap: () async {
            if (!likeModel.isBusy) {
              addLike(context,
                  circle: likeModel.article, model: likeModel, tag: uniqueKey);
            }
          },
          child: Hero(
            tag: uniqueKey,
            child: ScaleAnimatedSwitcher(
                child: likeModel.isBusy
                    ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CupertinoActivityIndicator(radius: 5))
                    : Consumer<UserModel>(
                  builder: (context,userModel,child){
                    print(" -----------------${likeModel.article.like}----------------- ");
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        userModel.hasUser && likeModel.article.like
                            ?
                        Icon(
                            IconFonts.thumbUp,
                          color: Colors.pinkAccent[400]):
                        Icon(
                          IconFonts.thumbUp),
                        Text(//likeCount
                          " ${likeModel.article.likeCount}",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        )
                      ],
                    );
                  },
                )
            ),
          )
      ),
    );
  }
}

class RowItem extends StatelessWidget{

  List<Widget> action;
  String left;
  Widget leftWidget;
  Widget other;
  double height;
  Function onPressed;

  RowItem({this.left,this.leftWidget,this.other,this.action,this.height=60,this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.all(10),
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                if(left!=null)
                  Container(
                    width: 80,
                    child: Text(
                      "${left}",
                      style: TextStyle(
//                  color: Colors.grey
                      ),
                    ),
                  ),
                if(leftWidget!=null)leftWidget,
                if(other!=null)
                  Container(width:MediaQuery.of(context).size.width-180 ,
                      child: other
                  )
              ],
            ),
            Container(
              child: Row(
                children: <Widget>[
                  if(action!=null)
                    ...action
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }}


const BUTTON_BACKGROUND_COLOR = Color.fromARGB(255, 58, 58, 67);

const BUTTON_ACCENT_COLOR = Color.fromARGB(255, 234, 67, 89);

class FollowAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FollowAnimationState();
  }
}

class FollowAnimationState extends State with SingleTickerProviderStateMixin {
  bool _follow = false;

  AnimationController _controller;

  Animation leftAnimation, rightAnimation;

  static const TOTAL_WIDTH = 180.0;

  static const MESSAGE_BTN_WIDTH = 60.0;

  static const GAP = 4.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    var rectTween = RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, 0, 0, 0),
        end: RelativeRect.fromLTRB(0, 0, MESSAGE_BTN_WIDTH + GAP, 0));
    var rectTween1 = RelativeRectTween(
        begin: RelativeRect.fromLTRB(TOTAL_WIDTH, 0, -MESSAGE_BTN_WIDTH, 0),
        end: RelativeRect.fromLTRB(TOTAL_WIDTH - MESSAGE_BTN_WIDTH, 0, 0, 0));

    leftAnimation = rectTween.animate(_controller);
    rightAnimation = rectTween1.animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: TOTAL_WIDTH,
      height: 40,
      child: Stack(
        children: <Widget>[
          PositionedTransition(
            rect: leftAnimation,
            child: RaisedButton(
              color: _follow ? BUTTON_BACKGROUND_COLOR : BUTTON_ACCENT_COLOR,
              child: _follow
                  ? Text("取消关注", style: TextStyle(color: Colors.white))
                  : Text(
                "+关注",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  if (_follow) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  _follow = !_follow;
                });
              },
            ),
          ),
          PositionedTransition(
            rect: rightAnimation,
            child: RaisedButton(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              color: BUTTON_BACKGROUND_COLOR,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}




childComment(Comment comment,textTheme){
  return RichText(
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
        text: comment.user!=null?"${comment.user.userName}":"匿名",
        style: TextStyle(color: Colors.blue,fontSize: 14.0),
        children: [
          if(comment.toId > 0)
            TextSpan(text: " 回复 ",
                style: TextStyle(color: textTheme.display1.color,fontSize: 14.0),
                children: [
                  TextSpan(text: "${comment.toId}",style: TextStyle(color: Colors.blue,fontSize: 14.0),)
                ]
            ),
          TextSpan(
            text: "：${comment.content}",
            style: TextStyle(color: textTheme.display1.color,fontSize: 14.0),
          )
        ]
    ),
  );
}


t11(str) => Text(str,style: TextStyle(fontSize: 12,),);


class ChildrenComment extends StatelessWidget{

  Comment comment;
  ChildrenComment(this.comment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              return childComment(comment, Theme.of(context).textTheme);
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

class FirstChildComment extends StatelessWidget{


  Comment comment;
  FirstChildComment(this.comment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              if(comment.user!=null)
                Container(
                  child: Text(
                    "${comment.user.userName}",
                    style: TextStyle(fontSize: 14,color: Theme.of(context).hintColor,fontWeight: FontWeight.w400),),
                ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "${comment.createTime}",
                  style: TextStyle(fontSize: 12,color: Theme.of(context).hintColor),),
              ),
              Container(
                margin: EdgeInsets.only(top: 5,bottom: 5),
                child: Text("${comment.content}",style: TextStyle(fontSize: 14),),
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
              if(comment.children.length>0)
                ChildrenComment(comment)
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.15, color: Theme.of(context).hintColor))
      ),
    );
  }

}

class NonStyleField extends TextField{



}