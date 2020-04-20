import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'LoginViewModel.dart';

class RxDartDemo extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => RxDartDemoState();
  
}

class RxDartDemoState extends State<RxDartDemo>{

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mvvm Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// [ChangeNotifierProvider]。所有的viewModel通过 Provider 实现与view 层的绑定。
      /// Provider 是对 [InheritedWidget] 封装。因此我们才能实现调用notifyListeners() 时，通知子树重新构建
      /// 当然你也可以一个插件也不用，自己封装[InheritedWidget]
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        child: LoginWidget(),
      ),
    );
  }
}