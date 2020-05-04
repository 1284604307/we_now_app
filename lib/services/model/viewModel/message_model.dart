import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/4/27
 */
class MessageViewModel extends ViewStateRefreshListModel {

  UserModel userModel;
  MessageViewModel(this.userModel);

  @override
  initData() {
    if(userModel.hasUser){
      showToast("已登录应创建表");
//      Api.db.execute("CREATE TABLE IF NOT EXISTS messages (id INTEGER,);");
    }else{
      showToast("未登录");
    }
    return super.initData();
  }

  @override
  Future<List<Message>> loadData({int pageNum}) async {

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
    return null;

  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

