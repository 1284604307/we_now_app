import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_list_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';

/**
 * @createDate  2020/4/27
 */
class MessageViewModel extends ViewStateRefreshListModel {

  UserModel userModel;
  MessageViewModel(this.userModel);

  @override
  Future<List<Message>> loadData({int pageNum}) async {
//    List<Future> futures = [];
//    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
//
//      futures.add(null);
//    }
//    else
//      futures.add(RestfulApi.fetchSchoolCircles(pageNum));
//    var result = await Future.wait(futures);
//    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
//      return result[0];
//    } else {
//      return result[0];
//    }
    List<Message> messages = [Message(),Message(),Message()];
    messages.forEach((m){
      m.content="画了个妲己";
      m.senderId=1;
      m.senderAvatar="https://i0.hdslb.com/bfs/face/5a6808606bf1f7a2390b77e14df8d0d1d04680d9.jpg@36w_36h_1c_100q.webp";
      m.createTime = DateTime.now();
    });
    return messages;

  }

  @override
  onCompleted(List data) {
//    GlobalFavouriteStateModel.refresh(data);
  }
}

