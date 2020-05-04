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
    return messageModel.messages;
  }

  @override
  onCompleted(List data) {
  }
}

class MessageModel extends ChangeNotifier{

  UserModel userModel;
  MessageModel(this.userModel);

  List<Message> _messages;
  List<Message> get messages => this._messages;

  loadData() async{
    if(userModel.hasUser){
      print("${userModel.user.toJson()}");
      List<Map<String, dynamic>> s = await Api.db.query("wenow_message where targetUsername = 'admin'");
      _messages = s.map((m)=>Message.fromJson(m)).cast<Message>().toList();
      print(_messages.length);
      _messages.forEach(print);
    }else{
      throw UnAuthorizedException();
    }
  }

  receiverMessage(Message message) async {
    if(_messages==null) await loadData();
    _messages.forEach(print);
    print(_messages.length);
    _messages.add(message);
    print("Model接收到一条新数据");
    print(message.toJson());
    notifyListeners();
  }

  login(String username){

  }

  logout(){
    _messages = [];
  }

  updateUser(UserModel userModel) {
    print("---------------用户信息改变");
  }


}

