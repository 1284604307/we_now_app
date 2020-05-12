import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/common/pojos/AjaxResult.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/api.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:oktoast/oktoast.dart';

const String WeNow_LoginName = 'WeNow_LoginName';
const String WeNow_LoginTicket = 'WeNow_LoginTicket';

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
          ..setString(WeNow_LoginName, userModel.user.loginName)
          ..setString(WeNow_LoginTicket, userModel.user.ticket);

        await Api.jMessage.login(
            username: loginName,
            password: password
        );
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }

  Future<bool> loginByQQ(openid,accessToken) async {
    setBusy();
    try {
      User user = await RestfulApi.loginByQQ(openid, accessToken);
      userModel.saveUser(user);
      StorageManager.sharedPreferences
        ..setString(WeNow_LoginName, userModel.user.loginName)
        ..setString(WeNow_LoginTicket, userModel.user.ticket);

      await Api.jMessage.login(
          username: userModel.user.loginName,
          password: "${userModel.user.loginName}123456"
      );
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }

  Future<bool> register(loginName, password) async {
    setBusy();
    try {
      await RestfulApi.register(loginName, password);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }

  Future<bool> logout() async {

    StorageManager.sharedPreferences.remove(WeNow_LoginTicket);
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      await RestfulApi.logout();
      userModel.clearUser();
      Api.jMessage.logout();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }
}
