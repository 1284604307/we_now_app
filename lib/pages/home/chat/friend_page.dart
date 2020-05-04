import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */

class FriendPage extends StatefulWidget {                     //modified
  @override
  State createState() => new FriendScreenState();
}

class FriendScreenState extends State<FriendPage>  with TickerProviderStateMixin {
  //用户列表
  List<JMUserInfo> _users = <JMUserInfo>[];

  @override
  void initState(){
    super.initState();
    Api.jMessage.getFriends().then((list){
      print(list);
      print("-------------------------");
      _users = list;
      _users.add(JMUserInfo.fromJson({
        "username":"111",
        "nickname":"滑稽"
      }));
      setState(() {

      });
    });
  }

  //输入控制器
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("友人"),centerTitle: true,),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => Container(
                child: Row(
                  children: <Widget>[
                    Text("${_users[index].username}")
                  ],
                ),
              ),
              itemCount: _users.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),
          ),
        ],
      ),
    );
  }
}



String _name = "Api.user.userName";
class ChatMessage extends StatelessWidget {

  ChatMessage({this.text, this.animationController});

  final AnimationController animationController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),
          ),
          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_name, style: Theme.of(context).textTheme.subhead,softWrap: false,overflow:TextOverflow.clip),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text,
                      softWrap: true,
                      overflow:TextOverflow.clip),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}