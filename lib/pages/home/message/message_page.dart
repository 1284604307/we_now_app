import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/pages/global/global_config.dart';
import 'package:flutter_app2/pages/home/circle/test.dart';
import 'package:flutter_app2/pages/maps/other.dart';
import 'package:flutter_app2/services/helper/refresh_helper.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/provider/provider_widget.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget{
  @override
  MessagePageState createState()=>MessagePageState();
}

class MessagePageState extends State<MessagePage>{

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Text("消息"),
            ),
          ),
          body: ProviderWidget<MessageViewModel>(
            model: MessageViewModel(Provider.of<UserModel>(context)),
            builder: (BuildContext context, messageModel, Widget child) {
              if(!messageModel.userModel.hasUser)
                return ViewStateEmptyWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  message: "用户未登录",
                  buttonText: Text("去登陆"),
                );
              return SmartRefresher(
                controller: messageModel.refreshController,
                footer: RefresherFooter(),
                header: HomeRefreshHeader(),
                onRefresh: ()async{
                  await messageModel.refresh();
                  messageModel.showErrorMessage(context);
                },
//                enablePullDown: messageModel.list.isNotEmpty,
                enablePullUp: messageModel.list.isNotEmpty,
                onLoading: messageModel.loadMore,
                child: CustomScrollView(
                  slivers: <Widget>[
                    Messages()
                  ],
                ),
              );
            },

          )
      ),
      onWillPop: () {

      },// 下边框
    );
  }


}

class Messages extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx,index){
          return Container(
            child: messageWidget(context),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
            ),
          );
        },
        childCount: 12,//recommendModel.list?.length ?? 0,
      ),
    );
  }

  Widget messageWidget(context){
    String name = "老王";
    String content = "这里是消息模板";
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return Test();
            }
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 1.0),
        padding: EdgeInsets.all(10),
        color: Theme.of(context).canvasColor,
        child: new Column(
          children: <Widget>[
            new Container(
                child: new Text(
                    name,
                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.3)
                ),
                margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                alignment: Alignment.topLeft
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(content)
                  ),
                  new Icon(Icons.linear_scale, color: GlobalConfig.fontColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



