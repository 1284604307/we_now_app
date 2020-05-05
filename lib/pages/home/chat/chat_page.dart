import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/**
 * @author Ming
 * @date 2020/4/18
 * @email 1284604307@qq.com
 */
class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(null),
    );
  }
}

class ChatScreen extends StatefulWidget {

  JMConversationInfo conversation;
  ChatScreen(this.conversation); //modified
  @override
  State createState() => new ChatScreenState(conversation);
}

class ChatScreenState extends State<ChatScreen>  with TickerProviderStateMixin {
  //用户消息列表
  List<JMTextMessage> _messages = <JMTextMessage>[];
  //输入控制器
  final TextEditingController _textController = new TextEditingController();


  @override
  void initState(){
    conversation.getHistoryMessages(from: 0, limit: 10).then((onValue){
      onValue.forEach((m){
        _messages.insert(0, m);
      });
//      _messages = onValue.map((f)=>JMTextMessage.fromJson(f) );
    showToast("加载完毕");
      setState(() {
        _messages=_messages;
      });
    });
  }

  JMConversationInfo conversation;
  ChatScreenState(this.conversation); //modified

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${conversation.title}")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index){
                JMTextMessage m = _messages[index];
                if(m.from.username == conversation.title){
                  return ChatMessage(m);
                }else return ChatMeMessage(m);
              },//_messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text)async {
    if(text.isEmpty){
      showToast("消息不能为空");
      return;
    }
    _textController.clear();
    showToast("发送消息 ${text}");
    conversation.sendTextMessage(text: text);

  }

  Widget _buildTextComposer() {
    return new IconTheme(                                            //new
      data: new IconThemeData(color: Theme.of(context).accentColor), //new
      child: new Container(                                     //modified
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                maxLines: 6,
                minLines: 1,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }
}



class ChatMessage extends StatelessWidget {

  JMTextMessage message;
  ChatMessage(this.message,{ this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.centerRight,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(message.from.username)),
          ),
          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(message.from.username, style: Theme.of(context).textTheme.subhead,softWrap: false,overflow:TextOverflow.clip),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.text,
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



class ChatMeMessage extends StatelessWidget {

  JMTextMessage message;
  ChatMeMessage(this.message,{ this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.centerRight,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Text(message.from.username, style: Theme.of(context).textTheme.subhead,softWrap: false,overflow:TextOverflow.clip),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.text,
                      softWrap: true,
                      overflow:TextOverflow.clip),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: new CircleAvatar(child: new Text(message.from.username)),
          ),
        ],
      ),
    );
  }
}