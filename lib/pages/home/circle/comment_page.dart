import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/CommentListWight.dart';
import 'package:flutter_app2/services/model/viewModel/comment_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';

/**
 * @createDate  2020/5/1
 */
class CommentPage extends StatefulWidget {

  num id;
  String name;

  CommentPage(this.name,this.id);

  @override
  _State createState() => _State(id,name);

}

class _State extends State<CommentPage> with AutomaticKeepAliveClientMixin {

  num id;
  String name;

  _State(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ProviderWidget<CommentListModel>(
        model: CommentListModel(id),
        builder: (BuildContext context, CommentListModel model, Widget child) {
          return CommentListWight(name,model);
        },
        onModelReady: (model){model.loadMore();},
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}