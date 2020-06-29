import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

/**
 * @createDate  2020/6/29
 */
class UsersModel  extends ViewStateModel {

  Map<String,User> _users = {};

  Map<String,User> get users => _users;

  loadData() async{
    // todo 从xxx加载数据
    notifyListeners();
    return _users;
  }

  put(String username,User user){
    _users[username]= user;
  }

  Future get(username) async{
    if(_users[username]!=null)
      return _users[username];
    else{
      // todo 请求用户数据
      User u = await RestfulApi.getUserInfo(username);
      _users[username] = u;
      return u;
    }
  }

  del(username){
    _users.remove(username);
  }
}