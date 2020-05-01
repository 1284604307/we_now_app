import 'package:flutter/material.dart';
import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

import 'login_model.dart';

/// 我的收藏
class CollectCircleListModel extends ViewStateRefreshListModel<Article> {

  LoginModel loginModel;
  CollectCircleListModel({this.loginModel});

  @override
  void onError(ViewStateError viewStateError) {
    super.onError(viewStateError);
    if (viewStateError.isUnauthorized) {
      loginModel.logout();
    }
  }

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await RestfulApi.fetchCollectList(pageNum);
  }

}

/// 点赞/取消点赞
class FavouriteModel extends ViewStateModel {
  GlobalFavouriteStateModel globalFavouriteModel;

  FavouriteModel({@required this.globalFavouriteModel});

  collect(Article circle) async {
    setBusy();
    try {
      // article.collect 字段为null,代表是从我的收藏页面进入的 需要调用特殊的取消接口
      if (circle.like == null) {
        await RestfulApi.likeCircle(circle.id);
        globalFavouriteModel.removeFavourite(circle.id);
      } else {
        if (circle.like) {
          await RestfulApi.unLikeCircle(circle.id);
          globalFavouriteModel.removeFavourite(circle.id);
        } else {
          await RestfulApi.likeCircle(circle.id);
          globalFavouriteModel.addFavourite(circle.id);
        }
      }
      circle.collect = !(circle.collect ?? true);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

}

/// 全局维护状态是否收藏
///
class GlobalFavouriteStateModel extends ChangeNotifier {
  /// 将页面列表项中所有的收藏状态操作结果存储到集合中.
  ///
  /// [key]为articleId,[value]为bool类型,代表是否收藏
  ///
  /// 设置static的目的是,列表更新时,刷新该map中的值
  static final Map<num, bool> _map = Map();

  /// 列表数据刷新后,同步刷新该map数据
  ///
  /// 在其他终端(如PC端)收藏/取消收藏后,会导致两边状态不一致.
  /// 列表页面刷新后,应该将新的收藏状态同步更新到map
  static refresh(List<Article> list) {
    list.forEach((circle) {
      if (_map.containsKey(circle.id)) {
        _map[circle.id] = circle.collect;
      }
    });
  }

  addFavourite(id) {
    _map[id] = true;
    notifyListeners();
  }

  removeFavourite(id) {
    _map[id] = false;
    notifyListeners();
  }

  /// 用于切换用户后,将该用户所有收藏的文章,对应的状态置为true
  replaceAll(List ids) {
    _map.clear();
    ids.forEach((id) => _map[id] = true);
    notifyListeners();
  }

  contains(id) {
    return _map.containsKey(id);
  }

  operator [](int id) {
    return _map[id];
  }
}

/// 点赞/取消点赞
class LikeModel extends ViewStateModel {

  Article article;

  LikeModel(this.article);

  like(Article circle) async {
    setBusy();
    try {
      var count;
      if (circle.like) {
        count = await RestfulApi.unLikeCircle(circle.id);
      } else {
        count = await RestfulApi.likeCircle(circle.id);
      }
      circle.likeCount = count;
      circle.like = !(circle.like ?? true);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

}