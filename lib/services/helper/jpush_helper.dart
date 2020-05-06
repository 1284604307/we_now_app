import 'package:flutter/cupertino.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

/**
 * @createDate  2020/5/6
 */
class JpushHelper{

  static parseNotify(UserNotifyMessage notify) {
    String str = "";
    switch(notify.type){
      case JMContactNotifyType.invite_received:
        str = "请求添加你为好友";
        break;
      case JMContactNotifyType.invite_accepted:
        str ="同意了你的好友请求！";
        break;
      case JMContactNotifyType.invite_declined:
        str ="拒绝了你的好友请求!";
        break;
      case JMContactNotifyType.contact_deleted:
        str ="删除了与你的好友关系";
        break;
    }
    return str;
  }
}