import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/4/27
 */
class BuddyModel extends ViewStateRefreshListModel {

  UserModel userModel;
  BuddyModel(this.userModel);

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
  Future<List<JMUserInfo>> loadData({int pageNum}) async {
    List<JMUserInfo> users  =[];
    return users;
  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

