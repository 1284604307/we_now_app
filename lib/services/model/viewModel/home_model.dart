import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

import '../Article.dart';
import '../Banner.dart';

class HomeModel extends ViewStateRefreshListModel {
  List<Banner> _banners;
  List<Article> _topArticles;

  List<Banner> get banners => _banners;

  List<Article> get topArticles => _topArticles;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(RestfulApi.fetchBanners());
      futures.add(RestfulApi.fetchTopArticles());
    }
    futures.add(RestfulApi.fetchArticles(pageNum));

    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      _topArticles = result[1];
      print(result);
      return result[2];
    } else {
      return result[0];
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}
