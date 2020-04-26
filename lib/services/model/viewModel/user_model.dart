import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';

class UserModel extends ChangeNotifier {
  static const String we_now_user = 'WeNow_User';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(we_now_user);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(we_now_user, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(we_now_user);
  }
}
