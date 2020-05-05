import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/common/Api.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/message_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
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
      home: new ChatScreen(""),
    );
  }
}

class ChatScreen extends StatefulWidget {

  String fromUsername;
  ChatScreen(this.fromUsername); //modified
  @override
  State createState() => new ChatScreenState(fromUsername);
}

class ChatScreenState extends State<ChatScreen>  with TickerProviderStateMixin {
  //用户消息列表
  final List<ChatMessage> _messages = <ChatMessage>[];
  //输入控制器
  final TextEditingController _textController = new TextEditingController();

  String friendUsername;
  ChatScreenState(this.friendUsername); //modified

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${friendUsername}")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index){
                Message m = Provider.of<MessageModel>(context).getMessagesList("${friendUsername}")[index];
                if(m.fromUsername == friendUsername){
                  return ChatMessage(m);
                }else return ChatMeMessage(m);
              },//_messages[index],
              itemCount: Provider.of<MessageModel>(context).getMessagesList("${friendUsername}").length,
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
    _textController.clear();
    Message m = Message();
    m.content = text;
    m.fromUsername = Provider.of<UserModel>(context,listen: false).user.userName;
    m.targetUsername = friendUsername;
    ChatMessage message = new ChatMessage(
      m,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    JMConversationInfo conversation = await Api.jMessage.createConversation(
        target: JMSingle.fromJson({
          "type": getStringFromEnum(JMMessageType.text),
          "username": "admin",
        }
    ));
    print(conversation.toJson());
    JMTextMessage jm = await Api.jMessage.sendTextMessage(type: JMSingle.fromJson({
      "type": getStringFromEnum(JMMessageType.text),
      "username": "admin",
    })
        , text: "厉害了");
    print(jm.toJson());
//      Provider.of<MessageModel>(context,listen: false).receiverMessage(m);
    message.animationController.forward();
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

  Message message;
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
            child: new CircleAvatar(child: new Text(message.fromUsername)),
          ),
          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(message.fromUsername, style: Theme.of(context).textTheme.subhead,softWrap: false,overflow:TextOverflow.clip),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.content,
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

  Message message;
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
                new Text(message.fromUsername, style: Theme.of(context).textTheme.subhead,softWrap: false,overflow:TextOverflow.clip),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.content,
                      softWrap: true,
                      overflow:TextOverflow.clip),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: new CircleAvatar(child: new Text(message.fromUsername)),
          ),
        ],
      ),
    );
  }
}