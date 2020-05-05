import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/model/viewModel/home_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/5/5
 */
class FriendModel extends ViewStateModel{

  List<JMUserInfo> _friends = [];

  List<JMUserInfo> get friends => _friends;

  loadData() async{

    _friends = await Api.jMessage.getFriends();
    _friends.add(JMUserInfo.fromJson({
      "username":"-123",
      "nickname":"用于测试的本地数据"
    }));
    notifyListeners();
    return _friends;
  }

  newFriend(){

  }

  delFriend(){

  }

}

class FriendRefreshModel extends ViewStateRefreshListModel{

  FriendModel friendModel;
  FriendRefreshModel(this.friendModel);

  @override
  Future<List<JMUserInfo>> loadData({int pageNum})async{
    print("加载数据");
    showToast("加载数据");
    if(pageNum>1 || isEmpty){
      List<JMUserInfo> s  =await friendModel.loadData();
      return s;
    }
    return [];
  }



}

