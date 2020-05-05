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
class MessageViewModel<JMConversationInfo> extends ViewStateRefreshListModel {

  // desc 会话组
  List<JMConversationInfo> cs;

  @override
  initData() async {
    return super.initData();
  }


  @override
  onCompleted(List data) {
  }

  @override
  Future<List<JMConversationInfo>> loadData({int pageNum})async{

    return  Api.jMessage.getConversations();
  }
}

class MessageModel extends ChangeNotifier{

  UserModel userModel;
  MessageModel(this.userModel);

  Map<String,MessageGroupModel> _messages = {};
  Map<String,MessageGroupModel> get messagesGroup => this._messages;

  List<UserNotifyMessage> userNotify = [];

  MessageGroupModel getMessages(String username) {
    if(!_messages.containsKey(username))
      _messages[username]=MessageGroupModel([],username);
    return _messages[username];
  }

  List<Message> getMessagesList(String username) {
    if(!_messages.containsKey(username))
      _messages[username]=MessageGroupModel([],username);
    return _messages[username].messages;
  }

  getMessageList(){
    List<Message> messages = [];
    if(_messages!=null)
      _messages.forEach((username,m){
        messages.add(m.getLastMessage());
      });
    return messages;
  }

  loadData() async{
    if(userModel.hasUser){
      print("正在读取用户 ${userModel.user.loginName} 的本地数据......");
      List<Map<String, dynamic>> s;
      try{
        s = await Api.db.query("wenow_message where targetUsername = '${userModel.user.loginName}' or fromUsername =  '${userModel.user.loginName}'");
        if(s==null){
          showToast("用户历史消息为空");
          debugPrint("用户历史消息为空");
          s= [];
        }else _messages={};
        s.forEach((m){
          Message message =Message.fromJson(m);
          print(message.toJson());
          if(message.fromUsername == userModel.user.loginName){
            getMessages(message.targetUsername).putMessage(message);
          }else
            getMessages(message.fromUsername).putMessage(message);
        });
      }catch(e){print(e);}

      //desc 读取本地好友通知事件
      List<Map<String, dynamic>> notifyL = await Api.db.query("wenow_contact_event where targetUsername = '${userModel.user.loginName}'");
      notifyL.forEach((n){
        UserNotifyMessage uNM = UserNotifyMessage.fromJson(n);
        print(uNM);
        userNotify.add(uNM);
      });

      return s;
    }else{
      throw UnAuthorizedException();
    }
  }

  receiverMessage(Message message,{saveSql = true}) async {
    if(_messages==null) await loadData();

    if(saveSql){
      var s = await Api.db.insert("wenow_message", message.toJson());
      print("插入 serverMessageId $s 数据 到SQLITE成功--------------------------------");
    }

    print(_messages.length);

    if(message.fromUsername == userModel.user.loginName){
      getMessages(message.targetUsername).putMessage(message);
    }else
      getMessages(message.fromUsername).putMessage(message);

    print("Model接收到一条新数据");
    print(message.toJson());
    notifyListeners();
  }

  receiverNotify(UserNotifyMessage event) async {
    userNotify.add(event);
    notifyListeners();
  }

  login(String username){

  }

  logout(){
    _messages = {};
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


  UserNotifyMessage();

  Map<String, dynamic> toJson() {
    return {
      'type': getStringFromEnum(type),
      'reason': reason,
      'fromUserName': fromUserName,
      'targetUserName': targetUserName,
      'fromUserAppKey': fromUserAppKey
    };
  }

  UserNotifyMessage.fromJson(Map<dynamic, dynamic> json)
      : type = getEnumFromString(JMContactNotifyType.values, json['type']),
        reason = json['reason'],
        fromUserName = json['fromUsername'],
        targetUserName = json['targetUserName'],
        fromUserAppKey = json['fromUserAppKey'];
}
