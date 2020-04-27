import 'package:flutter_app2/common/entity/CircleEntity.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_list_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

/**
 * @createDate  2020/4/27
 */
class MessageViewModel extends ViewStateRefreshListModel {

  @override
  Future<List> loadData({int pageNum}) async {
//    List<Future> futures = [];
//    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
//
//      futures.add(null);
//    }
//    else
//      futures.add(RestfulApi.fetchSchoolCircles(pageNum));
//    var result = await Future.wait(futures);
//    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
//      return result[0];
//    } else {
//      return result[0];
//    }
    return [Message(),Message(),Message(),Message(),Message(),Message(),Message(),Message(),Message(),Message(),];

  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

