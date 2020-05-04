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
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/4/27
 */
class MessageViewModel extends ViewStateRefreshListModel {

  MessageModel _messageModel;
  MessageViewModel(this._messageModel);

  MessageModel get messageModel => this._messageModel;


  bool get ok => messageModel.userModel.hasUser;

  @override
  initData() async{
    if(messageModel.userModel.hasUser){
      await messageModel.loadData();
    }else{
      showToast("未登录");
    }
    return super.initData();
  }

  @override
  Future<List<Message>> loadData({int pageNum}) async {
    await messageModel.loadData();
    List<Message> messages = [];
    if(messageModel.messagesGroup!=null)
      messageModel.messagesGroup.forEach((username,m){
        messages.add(m.getLastMessage());
      });
    return messages;
  }

  @override
  onCompleted(List data) {
  }
}

class MessageModel extends ChangeNotifier{

  UserModel userModel;
  MessageModel(this.userModel);

  Map<String,MessageGroupModel> _messages = {};
  Map<String,MessageGroupModel> get messagesGroup => this._messages;

  MessageGroupModel getMessages(String username) {
    if(!_messages.containsKey(username))
      _messages[username]=MessageGroupModel([]);
    return _messages[username];
  }

  List<Message> getMessagesList(String username) {
    if(!_messages.containsKey(username))
      _messages[username]=MessageGroupModel([]);
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
      print("${userModel.user.loginName}");
      List<Map<String, dynamic>> s = await Api.db.query("wenow_message where targetUsername = '${userModel.user.loginName}'");
      if(s==null){
        showToast("用户历史消息为空");
        debugPrint("用户历史消息为空");
        s= [];
      }
      s.forEach((m){
        Message message =Message.fromJson(m);
        print(message.toJson());
        getMessages(message.fromUsername).putMessage(message);
      });
//      _messages.forEach((username,model){
//        print("${username} ------> ${model.getLastMessage()}");
//      });
      return s;
    }else{
      throw UnAuthorizedException();
    }
  }

  receiverMessage(Message message) async {
    if(_messages==null) await loadData();
    print(_messages.length);
    getMessages(message.fromUsername).putMessage(message);
    print("Model接收到一条新数据");
    print(message.toJson());
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
  MessageGroupType type ;


  List<Message> get messages => _messages;

  MessageGroupModel(this._messages,{this.type =  MessageGroupType.USER});

  getLastMessage(){
    return _messages[_messages.length-1];
  }


  putMessage(Message m){
    _messages.add(m);
  }

}

