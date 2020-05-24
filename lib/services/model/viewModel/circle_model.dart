import 'package:flutter_app2/services/model/Article.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:oktoast/oktoast.dart';

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


class CircleRecommendModel extends ViewStateRefreshListModel<Article> {

  List<Article> _circles_Hots;
  List<Article> get recommendCircles => _circles_Hots;

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    List<Future> futures = [];

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
  }
}

class CircleTopicModel extends ViewStateRefreshListModel<Article> {

  var id;
  CircleTopicModel(this.id);

  List<Article> _circle_Hots;
  List<Article> get tops => _circle_Hots;


  @override
  Future<List<Article>> loadData({int pageNum}) async {

    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _circle_Hots = await RestfulApi.fetchTopicTopCircles(id);
    }
    return await RestfulApi.fetchTopicCircles(id,pageNum:pageNum);
  }

  @override
  onCompleted(List data) {
  }
}

class CirclePersonModel extends ViewStateRefreshListModel<Article> {

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await RestfulApi.fetchRecommendCircles(pageNum);
  }

  @override
  onCompleted(List data) {
  }
}


