import 'package:flutter_app2/services/model/Comment.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:flutter_app2/services/provider/view_state_model.dart';
import 'package:flutter_app2/services/provider/view_state_refresh_list_model.dart';
import 'package:oktoast/oktoast.dart';

/**
 * @createDate  2020/5/1
 */
class CommentModel extends ViewStateModel{

  // desc 评论信息不需要缓存，
  
  int commentId = -1;
//  Map<int,CommentModel> commentChildren = Map();

  CommentModel(this.commentId);

}

class CommentListModel extends ViewStateRefreshListModel{
  int id;
  bool children;

  CommentListModel(this.id,{this.children = false});

  @override
  Future<List<Comment>> loadData({int pageNum = 1}) async{
    List<Comment> res;
    print("打印第----------------${pageNum}");
    if(children){
      res = await RestfulApi.fetchChildrenComment(id,pageNum: pageNum);
    }else{
      res = await RestfulApi.fetchArticleComment(id,pageNum: pageNum);
    }
    res.forEach(print);
    return res;
  }


  @override
  onCompleted(List data) {
  }

  
}