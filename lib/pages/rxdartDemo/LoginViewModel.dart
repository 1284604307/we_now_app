
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart'; 如果需要，自行添加插件

/**
 * @author Ming
 * @date 2020/4/19
 * @email 1284604307@qq.com
 */
// file path: package:flutter_mvvm_demo/view_models/login_view_model.dart

// file path: package:flutter_mvvm_demo/models/login_model.dart
class LoginWidget extends StatelessWidget {
  @override
  build(BuildContext context) {
    final provider = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: provider.usernameController,
            decoration: InputDecoration(labelText: "username"),
          ),
          TextField(
            controller: provider.passwordController,
            decoration: InputDecoration(labelText: "password"),
          ),
          RaisedButton(
            onPressed: provider.login,

            /// 根据 state 的值，按钮显示不同内容。
            child: provider.state == 0
                ? Text("login")
                : provider.state == 1
                ? CircularProgressIndicator()
                : provider.state == 2
                ? Icon(Icons.done)
                : Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}

class LoginModel {
  /// 直接将网络请求的 Future 对象包装成 Stream 返回
  /// Stream.fromFuture 等构造方法。更多细节参考官方文档
  /// 因为是 demo 所以用 Future.delayed 模拟请求过程
  Stream<int> login(dynamic data) => Stream.fromFuture(

    Future.delayed(Duration(seconds: 2), () {
      if (data["username"] == "" && data["password"] == "")
        return 0;
      return -1;
    }),
  );
}

/// with ChangeNotifier : 通过 notifyListeners() 函数，可以通知本对象数据的正在使用者们。
/// 如 state 变量，在改变后调用 notifyListeners(), UI根据值重新构建登录按钮显示内容
class LoginViewModel with ChangeNotifier {
  final _model = LoginModel();
  int state = 0; // 0 未请求，1 正在请求， 2 请求成功， 3请求失败
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  login() {
    final data = {
      "username": usernameController.text,
      "password": passwordController.text,
    };

    print(data);

    /// 不为 0 说明上一条请求未完成，直接退出
    if (state != 0) return;

    /// 开始请求，state 赋值为 1， 并通知监听者
    /// 如果用rxDart插件，可作为doOnListen参数的函数体
    state = 1;
    notifyListeners();

    _model.login(data)

    /// rxDart 插件
//        .doOnListen(() {
//      state = 1;
//      notifyListeners();
//    })
        .listen((v) {
      if (v != 0) {
        /// 返回值不为0，请求失败
        state = 3;
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () {
          state = 0;
          notifyListeners();
        });
      } else {
        /// 返回值为0，请求成功
        state = 2;
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () {
          state = 0;
          notifyListeners();
        });
      }
    });
  }
}