/**
 * @createDate  2020/4/29
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/helper/favourite_helper.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/model/viewModel/favourite_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
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
                      builder: (context,userModel,child)=>Icon(
                          userModel.hasUser && article.collect
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.pinkAccent[400]),
                    )
                ),
          )
      ),
    );
  }
}
