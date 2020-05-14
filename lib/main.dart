import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/pages/home/me/me_page.dart';
import 'package:flutter_app2/pages/loading.dart';
import 'package:flutter_app2/pages/login/login.dart';
import 'package:flutter_app2/services/config/provider_manager.dart';
import 'package:flutter_app2/services/config/router_manger.dart';
import 'package:flutter_app2/services/config/storage_manager.dart';
import 'package:flutter_app2/services/generated/l10n.dart';
import 'package:flutter_app2/services/model/Message.dart';
import 'package:flutter_app2/services/model/viewModel/locale_model.dart';
import 'package:flutter_app2/services/model/viewModel/login_model.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
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

  try{
    String version = await StorageManager.localStorage.getItem("we_now_version")??"0.0.0";
    if(version!="1.0.0"){
      // desc 用户事件表
      String t = "SELECT count(*) INTO @colName FROM information_schema.columns"+
          "WHERE table_name = 'wenow_contact_event' AND column_name = 'status'; IF @colName = 0 THEN ";
      await Api.db.execute("$t ALTER TABLE if EXISTS wenow_contact_event ADD "+
          "(status text default null , done text default null); END IF;");
      StorageManager.localStorage.setItem("we_now_version", "1.0.0");
    }
  }catch(e){
    print(e);
  }
  try{
    // DESC 用户消息表
    await Api.db.execute("Create table if not EXISTS  wenow_message "
        "(id INTEGER,serverMessageId INTEGER PRIMARY KEY,fromUsername text,targetUsername text,content TEXT,type TEXT"
        ",createTime INTEGER,extras text,senderAvatar text,targetType text,senderType text,isSend INTEGER,action text); ");
  }catch(e){
    print(e);
  }
  try{
    // desc 用户事件表
    await Api.db.execute("Create table if not EXISTS  wenow_contact_event "
        "(reason text ,fromUsername text,targetUsername text,fromUserAppKey text,type TEXT"
        ",status text,done text); ");
  }catch(e){
    print(e);
  }

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
    Provider.of<ConversationModel>(_context,listen: false).refreshConversations();

    switch(message.runtimeType.toString()){
      case "JMTextMessage":
        break;
      case "JMUserInfo":
        showToast("是我JMUserInfo");
        break;
    };
  });

  Api.jMessage.addContactNotifyListener((message)async{
    print("----------极光 IM 好友事件");
    print(message.toJson());
    UserNotifyMessage event = UserNotifyMessage();
    event.fromUserName = message.fromUserName;
    event.type = message.type;
    event.fromUserAppKey = message.fromUserAppKey;
    event.reason = message.reason;
    event.targetUserName = Provider.of<UserModel>(_context,listen: false).user.loginName;
    print(event.toJson());
    var s = await Api.db.insert("wenow_contact_event", event.toJson());
    print("插入 id $s 好友事件成功--------------------------------");
    Provider.of<ConversationModel>(_context,listen: false).refreshConversations();
  }); // 添加监听

  Api.jMessage.addLoginStateChangedListener((message)async{
    print("----------极光 IM 登陆状态改变事件");
    print("被挤掉线了");
    bool l = await LoginModel(Provider.of<UserModel>(_context,listen: false)).logout();
    if(l){
      showDialog(context: _context,child: Container(
        child: Text("您的账号在其他终端登录，本机已离线"),
      ));
    }else{
      showDialog(context: _context,child: Container(
        child: Text("您的IM聊天系统已离线"),
      ));
    }
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

  print(1);

//  if (!Provider.of<UserModel>(_context,listen: false).hasUser) {
//    Provider.of<UserModel>(_context,listen: false).refreshInfo();
//  }
}
