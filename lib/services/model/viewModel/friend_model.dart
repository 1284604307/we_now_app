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
    if(_friends.length==0){
      _friends.add(JMUserInfo.fromJson({
        "username":"-123",
        "nickname":"您的列表内没有任何朋友~快去添加一个吧!"
      }));
    }
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

