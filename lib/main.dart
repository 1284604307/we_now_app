import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/chat/chat_page.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/services/config/provider_manager.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/locale_model.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sqflite/sqflite.dart';

import 'common/Api.dart';
import 'services/model/viewModel/message_model.dart';
main() async {

  BuildContext _context;
  MessageModel messageModel;

  // desc runApp前进行耗时操作必须执行该静态方法
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  Api.db = await openDatabase('we_now_sqlite.db');
  runApp(
      OKToast(
        child: BotToastInit(
          child: MultiProvider(
              providers: providers,
              child: Consumer2<ThemeModel, LocaleModel>(
                  builder: (context, themeModel, localeModel, child) {
                    _context = context;
                    return RefreshConfiguration(
                        hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                        child:MaterialApp(
                          title: '校园时光',
                          debugShowCheckedModeBanner: false,
                          theme: themeModel.themeData(),
                          darkTheme: themeModel.themeData(platformDarkMode: true),
                          navigatorObservers: [BotToastNavigatorObserver()],
                          locale: localeModel.locale,
                          localizationsDelegates: const [
                            S.delegate,
                            RefreshLocalizations.delegate, //下拉刷新
                            GlobalCupertinoLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate
                          ],
                          supportedLocales: S.delegate.supportedLocales,
                          initialRoute: RouteName.loading,
                          onGenerateRoute: Router.generateRoute,
                        )
                    );
                  }
              )
          ),
        ),
      )
  );


  // DESC 用户消息表
  await Api.db.execute("Create table if not EXISTS  wenow_message "
      "(id INTEGER,serverMessageId INTEGER PRIMARY KEY,fromUsername INTEGER,targetUsername INTEGER,content TEXT,type TEXT"
      ",createTime INTEGER,extras text,senderAvatar text,targetType text,senderType text,isSend INTEGER,action text); ");


  Api.jpush = new JPush();
  Api.jpush.setup(
    production: false,
    debug: true, // 设置是否打印 debug 日志
  );
  Api.jpush.addEventHandler(
    // 接收通知回调方法。
    onReceiveNotification: (Map<String, dynamic> message) async {
      print("flutter 接收通知回调方法: $message");
    },
    // 点击通知回调方法。
    onOpenNotification: (Map<String, dynamic> message) async {
      print("flutter 点击通知回调方法: $message");
    },
    // 接收自定义消息回调方法。
    onReceiveMessage: (Map<String, dynamic> message) async {
      print("flutter 接收自定义消息回调方法: $message");
    },
  );

  Api.jMessage = JmessageFlutter();
  Api.jMessage.init(isOpenMessageRoaming: true, appkey: "3ee80f9fe9855e97c89dd52a");
  Api.jMessage.setDebugMode(enable: true);
  Api.jMessage.setBadge(badge: 1);

  Api.jMessage.addReceiveMessageListener((message) async{

    print("----------极光 IM 消息事件");
    print(message.runtimeType);
    print(message.toJson());

    switch(message.runtimeType.toString()){
      case "JMTextMessage":
        Message nM = new Message();
        showToast("是我JMTextMessage");
        nM.serverMessageId = message.serverMessageId;
        nM.fromUsername = message.from.username;
        nM.targetUsername = message.target.username;
        nM.createTime = message.createTime;
        nM.content = message.text;
        nM.type = message.type.toString();
        nM.extras = message.extras.toString();
        nM.senderAvatar = message.from.avatarThumbPath;
        var s = await Api.db.insert("wenow_message", nM.toJson());
        print("插入 serverMessageId $s 数据成功--------------------------------");
        Provider.of<MessageModel>(_context,listen: false).receiverMessage(message);
        break;
      case "JMUserInfo":
        showToast("是我JMUserInfo");
        break;
    };
  });

  Api.jMessage.addContactNotifyListener((message){
    print("----------极光 IM 好友事件");
    print(message);
    print(message.toJson());
  }); // 添加监听
  Api.jMessage.addLoginStateChangedListener((message){
    print("----------极光 IM 登陆状态改变事件");
    print("被挤掉线了");
  }) ;
  Api.jMessage.addClickMessageNotificationListener((message){
    switch(message.runtimeType.toString()){
      case "JMTextMessage":
        showToast("是我JMTextMessage");
        break;
      case "JMUserInfo":
        showToast("是我JMUserInfo");
        break;
    };
    print(message.runtimeType);
    print("----------极光 IM 点击消息通知事件");
    print(message);
  });
}
