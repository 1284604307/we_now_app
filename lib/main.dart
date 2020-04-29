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
import 'package:flutter_app2/services/model/viewModel/locale_model.dart';
import 'package:flutter_app2/services/model/viewModel/theme_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/Api.dart';
main() async {

  // desc runApp前进行耗时操作必须执行该静态方法
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();

  runApp(
      OKToast(
        child: BotToastInit(
          child: MultiProvider(
              providers: providers,
              child: Consumer2<ThemeModel, LocaleModel>(
                  builder: (context, themeModel, localeModel, child) {
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



  Api.jpush = new JPush();
  Api.jpush.setup(
    production: false,
    debug: false, // 设置是否打印 debug 日志
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

//  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
//  SystemChrome.setSystemUIOverlayStyle(dark);
//  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
