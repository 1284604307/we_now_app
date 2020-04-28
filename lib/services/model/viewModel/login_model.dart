import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';

const String WeNow_LoginName = 'WeNow_LoginName';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  String getLoginName() {
    return StorageManager.sharedPreferences.getString(WeNow_LoginName);
  }

  Future<bool> login(loginName, password) async {
    setBusy();
    try {
      User user = await RestfulApi.login(loginName, password);
      userModel.saveUser(user);
      StorageManager.sharedPreferences
          .setString(WeNow_LoginName, userModel.user.loginName);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      await RestfulApi.logout();
      userModel.clearUser();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }
}