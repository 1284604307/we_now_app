import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

import '../Article.dart';
import '../Banner.dart';

class HomeModel extends ViewStateRefreshListModel {
  static const String we_now_banners = 'WeNow_Banners';

  List<Banner> _banners;
  List<Article> _topArticles;

  // desc 热门状态
  List<Article> _circles;
  // desc 每日话题
  List<Object> _topics;

  List<Banner> get banners => _banners;

  List<Article> get topArticles => _topArticles;

  HomeModel(){
    List banners = StorageManager.localStorage.getItem(we_now_banners);
//    if(banners!=null){
//      banners.forEach((banner){
//        print(banner);
//        _banners.add(banner);
//      });
//    }
  }

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
      List<Banner> banners = result[0];
      if(banners.length>0) StorageManager.localStorage.setItem(we_now_banners,banners);
      _banners = banners;
      banners.forEach((banner){
        print(banner.toJson());
        print("\n\n\n");
      });
      _topArticles = result[1];
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
