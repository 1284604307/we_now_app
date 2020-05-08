import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * @author Ming
 * @date 2020/5/8
 * @email 1284604307@qq.com
 */
class WebViewPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _state();
  }

}

class _state extends State<WebViewPage>{

  double _webviewHeight = 1.0;

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text("实现webview与flutter视图兼容滑动"),),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: _webviewHeight,
                  child: WebView(
                    initialUrl: "https://flutterchina.club/",
                    //JS执行模 式 是否允许JS执行
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController controller){
                      _controller = controller;
                    },
                    onPageFinished: (String url) async {
                      // 页面加载完成后注入js方法, 获取页面总高度
                      var str  =await _controller.evaluateJavascript("""
                        document.body.scrollHeight
                      """);
                      print(str);
                      showToast(str.toString());
                      _webviewHeight = double.parse(str);
                      setState(() {
                      });
                    },
//                    javascriptChannels: JavascriptChannel(),
                  ),
                ),
                Text("\n\n\n滑稽")
              ],
            ),
          ),
      ),
      onWillPop: () async{
        showToast("别动！再待会!");
        return true;
      },
    );
  }

}