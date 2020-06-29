import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/services/provider/view_state.dart';
import 'package:flutter_app2/services/provider/view_state_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * @author Ming
 * @date 2020/5/8
 * @email 1284604307@qq.com
 */
class WebViewPage extends StatefulWidget{

  String title;
  String path;
  WebViewPage({this.title,this.path});

  @override
  State<StatefulWidget> createState() {
    return _state(title: title,path: path);
  }

}

class _state extends State<WebViewPage>{

  String title;
  String path;
  bool success = true;
  _state({this.title,this.path});

  WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BotToast.showLoading();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text("$title"),),
          body: success?WebView(
            initialUrl: path,
            //JS执行模 式 是否允许JS执行
            javascriptMode: JavascriptMode.disabled,
            onWebViewCreated: (WebViewController controller){
              _controller = controller;
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.prevent;
            },
            onPageFinished: (String url) async {
              BotToast.closeAllLoading();
              // 页面加载完成后注入js方法, 获取页面总高度
//              var str  =await _controller.evaluateJavascript("""
//                        document.body.scrollHeight
//                      """);
//              print(str);
//              showToast(str.toString());
//              _webviewHeight = double.parse(str);
//              setState(() {
//              });
            },
            onWebResourceError: (error){
              success = false;
              setState(() {});
            },

//                    javascriptChannels: JavascriptChannel(),
          ):ViewStateEmptyWidget(onPressed: () {
            BotToast.showLoading();
            success = true;
            _controller.reload();
            setState(() {});
          },),
      ),
      onWillPop: () async{
        BotToast.closeAllLoading();
        return true;
      },
    );
  }

}
