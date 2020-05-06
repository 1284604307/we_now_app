import 'dart:collection';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/api.dart';
import 'package:flutter_app2/services/provider/view_state.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/4/27
 */
class MessageViewModel extends ViewStateRefreshListModel<JMConversationInfo> {

  ConversationModel messageModel;
  MessageViewModel(this.messageModel);

  @override
  initData() async {
    messageModel.refreshConversations();
    return super.initData();
  }


  @override
  onCompleted(List data) {

  }

  @override
  Future<List<JMConversationInfo>> loadData({int pageNum})async{
      await messageModel.refreshConversations();
    return messageModel.cs;
  }
}

class ConversationModel extends ChangeNotifier{

  UserModel userModel;
  ConversationModel(this.userModel);

  // desc 会话组
  List<JMConversationInfo> cs = [];
  List<UserNotifyMessage> notifies = [];

  refreshConversations() async{
    cs = await Api.jMessage.getConversations();
    cs =cs==null?[]:cs;
    notifies = (await Api.db.query("wenow_contact_event where fromUsername='${userModel.user.loginName}' "
        "or targetUserName = '${userModel.user.loginName}' "))
        .map((json){UserNotifyMessage u = UserNotifyMessage.fromJson(json);print(json);print(u.toJson());return u;}).toList();
//    showToast(notifies.length.toString());
    notifyListeners();
  }

  login(String username){

  }

  logout(){
    cs=[];notifies=[];
  }

  updateUser(UserModel userModel) {
    print("---------------用户信息改变");
  }


}

enum MessageGroupType{
  USER,
  GROUP,
  NOTIFY
}

class MessageGroupModel extends ViewStateModel{

  List<Message> _messages = [];
  String username;
  MessageGroupType type ;


  List<Message> get messages => _messages;

  MessageGroupModel(this._messages,this.username,{this.type =  MessageGroupType.USER});

  getLastMessage(){
    return _messages[_messages.length-1];
  }


  putMessage(Message m){
    _messages.add(m);
  }

}


class UserNotifyMessage {
  JMContactNotifyType type;
  String reason;
  String fromUserName;
  String targetUserName;
  String fromUserAppKey;
  bool done = false;
  String status;


  UserNotifyMessage();

  Map<String, dynamic> toJson() {
    return {
      'type': getStringFromEnum(type),
      'reason': reason,
      'fromUserName': fromUserName,
      'targetUserName': targetUserName,
      'fromUserAppKey': fromUserAppKey,
      'done': done,
      'status': status
    };
  }

  UserNotifyMessage.fromJson(Map<dynamic, dynamic> json)
      : type = getEnumFromString(JMContactNotifyType.values, json['type']),
        reason = json['reason'],
        fromUserName = json['fromUsername'],
        targetUserName = json['targetUserName'],
        done = "${json['done']}"=="true",
        status = json['status'],
        fromUserAppKey = json['fromUserAppKey'];
}
