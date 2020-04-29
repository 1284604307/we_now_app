import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

/**
 * @createDate  2020/4/27
 */
class CircleSchoolModel extends ViewStateRefreshListModel {
  List<Article> _circles_School;
  List<Article> get hotsCircles => _circles_School;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(RestfulApi.fetchSchoolCircles(0));
    }
    else
      futures.add(RestfulApi.fetchSchoolCircles(pageNum));
    var result = await Future.wait(futures);

    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _circles_School = result[0];
      return result[0];
    } else {
      return result[0];
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}


class CircleRecommendModel extends ViewStateRefreshListModel {

  List<Article> _circles_Hots;
  List<Article> get recommendCircles => _circles_Hots;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(RestfulApi.fetchRecommendCircles(0));
    }
    else
      futures.add(RestfulApi.fetchRecommendCircles(pageNum));


    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      return result[0];
    } else {
      return result[0];
    }
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

