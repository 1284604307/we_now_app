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
  Widget other;
  double height;
  Function onPressed;

  RowItem({this.left,this.other,this.action,this.height=60,this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(
      onTap: onPressed,
      child: Container(
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