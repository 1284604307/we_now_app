import 'package:flutter/material.dart';
import 'package:flutter_app2/common/pojos/User.dart';
import 'package:flutter_app2/services/model/viewModel/UsersModel.dart';
import 'package:flutter_app2/services/model/viewModel/buddy_model.dart';
import 'package:flutter_app2/services/model/viewModel/favourite_model.dart';
import 'package:flutter_app2/services/model/viewModel/friend_model.dart';
import 'package:flutter_app2/services/model/viewModel/locale_model.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  ),
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
  ChangeNotifierProvider<GlobalFavouriteStateModel>(
    create: (context) => GlobalFavouriteStateModel(),
  ),
  ChangeNotifierProvider<FriendModel>(
    create: (context) => FriendModel(),
  ),
  ChangeNotifierProvider<UsersModel>(
    create: (context) => UsersModel(),
  ),
];

/// 需要依赖的model
///
/// 比如 UserModel 依赖 globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [
  // desc 例子
//  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
//    create: null,
//    update: (context, globalFavouriteStateModel, userModel) =>
//    userModel ??
//        UserModel(),
//  )
  ChangeNotifierProxyProvider<UserModel , ConversationModel>(
    create: (context){
      print("---------------------------创建消息桶");
      return ConversationModel(Provider.of<UserModel>(context, listen: false));
    },
    update: (context, userModel, messageModel) {
      print("---------------------------更新消息桶");
      return messageModel..updateUser(userModel);
    },
  ),
//  ChangeNotifierProxyProvider<BuddyModel, UserModel>(
//    create: null,
//    update: (context, buddyModel, userModel) =>
//    userModel ??
//        UserModel(),
//  ),
];

List<SingleChildWidget> uiConsumableProviders = [
  // desc 信息流 可以想象，notify一条消息，从头部流到尾部
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
