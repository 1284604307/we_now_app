/**
 * @createDate  2020/4/29
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/config/resource_mananger.dart';
import 'package:flutter_app2/services/helper/favourite_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
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
                  other,
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